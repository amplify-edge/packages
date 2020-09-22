package delivery

import (
	"context"
	"github.com/getcouragenow/packages/sys-account/authn/pkg/auth"
	"github.com/getcouragenow/packages/sys-account/rpc"
	"github.com/grpc-ecosystem/go-grpc-middleware/util/metautils"
	l "github.com/sirupsen/logrus"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type (
	// ContextKey auth gRPC context key.
	ContextKey string

	// AuthDelivery is the delivery layer of the authn
	AuthDelivery struct {
		Log      *l.Entry
		TokenCfg *auth.TokenConfig
		// repo ==> some repository layer for querying users
	}
)

func (c ContextKey) String() string {
	return "sys_account.delivery.grpc context key " + string(c)
}

var (
	// ContextKeyClaims defines claims context key provided by token.
	ContextKeyClaims = ContextKey("auth-claims")
	HeaderAuthorize  = "authorization"
)

// for now we hardcode the user first
// later we'll use Genji from getcouragenow/sys-core/server/db
func (ad *AuthDelivery) getAndVerifyUser(_ context.Context, req *rpc.LoginRequest) (*rpc.Account, error) {
	// TODO @winwisely268: query actual account from database and verify it here.
	if req.GetEmail() != "superadmin@getcouragenow.org" && req.GetPassword() != "superadmin" {
		return nil, status.Errorf(codes.Unauthenticated, "cannot authenticate: %v", auth.AuthError{Reason: auth.ErrInvalidCredentials})
	}
	return &rpc.Account{
		Id:       "1hpR8BL89uYI1ibPNgcRHI9Nn5Wi",
		Email:    req.GetEmail(),
		Password: req.GetPassword(),
		Role: &rpc.UserRoles{
			Role:     rpc.Roles_SUPERADMIN,
			Resource: &rpc.UserRoles_All{All: true},
		},
	}, nil
}

// DefaultInterceptor is default authN/authZ interceptor, validates only token correctness without performing any role specific authorization.
func (ad *AuthDelivery) DefaultInterceptor(ctx context.Context) (context.Context, error) {
	claims, err := ad.ObtainAccessClaimsFromMetadata(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Unauthenticated, "Request unauthenticated with error: %v", err)
	}

	return context.WithValue(ctx, ContextKeyClaims, claims), nil
}

// Register satisfies rpc.Register function on AuthService proto definition
func (ad *AuthDelivery) Register(_ context.Context, in *rpc.RegisterRequest) (*rpc.RegisterResponse, error) {
	// TODO @winwisely268: currently unimplemented
	return &rpc.RegisterResponse{
		Success:     true,
		SuccessMsg:  "Not implemented",
		ErrorReason: nil,
	}, nil
}

func (ad *AuthDelivery) Login(ctx context.Context, in *rpc.LoginRequest) (*rpc.LoginResponse, error) {
	if in == nil {
		return &rpc.LoginResponse{}, status.Errorf(codes.Unauthenticated, "Can't authenticate: %v", auth.AuthError{Reason: auth.ErrInvalidParameters})
	}
	var claimant auth.Claimant

	u, err := ad.getAndVerifyUser(ctx, in)
	if err != nil {
		return &rpc.LoginResponse{
			ErrorReason: &rpc.ErrorReason{Reason: err.Error()},
		}, err
	}
	claimant = u

	tokenPairs, err := ad.TokenCfg.NewTokenPairs(claimant)
	if err != nil {
		return &rpc.LoginResponse{
			ErrorReason: &rpc.ErrorReason{Reason: err.Error()},
		}, status.Errorf(codes.Unauthenticated, "Can't authenticate: %v", auth.AuthError{Reason: auth.ErrCreatingToken, Err: err})
	}
	return &rpc.LoginResponse{
		Success:      true,
		AccessToken:  tokenPairs.AccessToken,
		RefreshToken: tokenPairs.RefreshToken,
		ErrorReason:  nil,
		LastLogin:    nil,
	}, nil
}

// ObtainAccessClaimsFromMetadata obtains token claims from given context with gRPC metadata.
func (ad *AuthDelivery) ObtainAccessClaimsFromMetadata(ctx context.Context) (claims auth.TokenClaims, err error) {
	var authmeta string
	if authmeta, err = fromMetadata(ctx); err != nil {
		return auth.TokenClaims{}, err
	}

	if claims, err = ad.TokenCfg.ParseTokenStringToClaim(authmeta, true); err != nil {
		return auth.TokenClaims{}, err
	}

	return claims, nil
}

// ObtainClaimsFromContext obtains token claims from given context with value.
func ObtainClaimsFromContext(ctx context.Context) auth.TokenClaims {
	claims, ok := ctx.Value(ContextKeyClaims).(auth.TokenClaims)
	if !ok {
		return auth.TokenClaims{}
	}
	return claims
}

func fromMetadata(ctx context.Context) (authMeta string, err error) {
	authMeta = metautils.ExtractIncoming(ctx).Get(HeaderAuthorize)
	if authMeta == "" {
		return "", auth.AuthError{Reason: auth.ErrMissingToken}
	}
	return authMeta, nil
}
