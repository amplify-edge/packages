package auth

import (
	"github.com/getcouragenow/packages/sys-account/pkg/utilities"
	"time"

	"github.com/dgrijalva/jwt-go"
	rpc "github.com/getcouragenow/packages/sys-account/rpc/v2"
)

var (
	DefaultAccessExpiration  = 10 * time.Minute    // 10 minutes access token
	DefaultRefreshExpiration = 14 * 24 * time.Hour // two weeks
)

type TokenConfig struct {
	AccessSecret      []byte
	RefreshSecret     []byte
	AccessExpiration  time.Duration
	RefreshExpiration time.Duration
}

func NewTokenConfig(accessSecret, refreshSecret []byte) *TokenConfig {
	return &TokenConfig{
		AccessSecret:      accessSecret,
		RefreshSecret:     refreshSecret,
		AccessExpiration:  DefaultAccessExpiration,
		RefreshExpiration: DefaultRefreshExpiration,
	}
}

// Claimants are ones who are able to get token claims
type Claimant interface {
	GetEmail() string
	GetRole() *rpc.UserRoles
}

// TokenClaims is the representation of JWT auth claims
type TokenClaims struct {
	UserId    string         `json:"userId"`
	Role      *rpc.UserRoles `json:"role"`
	UserEmail string         `json:"userEmail"`
	jwt.StandardClaims
}

// TokenPairDetails contain both AccessToken and RefreshToken of the user
// This in turn will be saved to the Genji / Badger DB as `session data`
type TokenPairDetails struct {
	AccessToken  string
	RefreshToken string
	ATExpiry     int64  // unix epoch or nano (TODO @WinWisely268: specify be it in millis or in nanos, for now use milli)
	RTExpiry     int64  // same as above
	ATId         string // access token id, for storing to the database alongside refresh token id below
	RTId         string // this way we can update and delete token (somewhat) easily.
}

// NewTokenPairs returns new TokenPairDetails for given Claimant
func (tc *TokenConfig) NewTokenPairs(claimant Claimant) (*TokenPairDetails, error) {
	var tpd TokenPairDetails
	cl := NewTokenClaims(tc.AccessExpiration, claimant)
	accessToken, err := tc.newAccessToken(cl)
	if err != nil {
		return nil, err
	}
	tpd.AccessToken = accessToken
	rcl := NewTokenClaims(tc.RefreshExpiration, claimant)
	refreshToken, err := jwt.NewWithClaims(jwt.SigningMethodHS512, rcl).SignedString(tc.RefreshSecret)
	if err != nil {
		return nil, err
	}
	tpd.RefreshToken = refreshToken
	tpd.ATExpiry = time.Now().Unix() + tc.AccessExpiration.Milliseconds()
	tpd.RTExpiry = time.Now().Unix() + tc.RefreshExpiration.Milliseconds()
	tpd.ATId = utilities.NewID()
	tpd.RTId = utilities.NewID()

	return &tpd, nil
}

// create token claims for refresh / access token
func NewTokenClaims(exp time.Duration, c Claimant) *TokenClaims {
	role := c.GetRole()
	claims := TokenClaims{
		Role:      role,
		UserEmail: c.GetEmail(),
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(exp).Unix(),
		},
	}
	return &claims
}

// ParseTokenStringToClaim parses given token (access or refresh) and returns token claims with embedded JWT claims
// if token is indeed valid
func (tc *TokenConfig) ParseTokenStringToClaim(authenticate string, isAccess bool) (TokenClaims, error) {
	var claims TokenClaims
	token, err := jwt.ParseWithClaims(authenticate, &claims, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, AuthError{Reason: ErrDecryptionToken}
		}
		if isAccess {
			return tc.AccessSecret, nil
		} else {
			return tc.RefreshSecret, nil
		}
	})
	if err != nil {
		return TokenClaims{}, AuthError{Reason: ErrDecryptionToken, Err: err}
	}

	if !token.Valid {
		return TokenClaims{}, AuthError{Reason: ErrInvalidToken}
	}
	return claims, nil
}

// RenewAccessToken given a refresh token
func (tc *TokenConfig) RenewAccessToken(tcl *TokenClaims) (string, error) {
	// TODO @winwisely268: RenewAccessToken should remove / invalidates the currently supplied access token first
	return tc.newAccessToken(tcl)
}

func (tc *TokenConfig) newAccessToken(tcl *TokenClaims) (string, error) {
	return jwt.NewWithClaims(
		jwt.SigningMethodHS512,
		tcl,
	).SignedString(tc.AccessSecret)
}
