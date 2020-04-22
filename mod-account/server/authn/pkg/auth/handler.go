package auth

import (
	"fmt"
	"github.com/getcouragenow/getcourage-packages/mod-account/authn/pkg/pass"
	"github.com/getcouragenow/getcourage-packages/mod-account/authn/pkg/store"
	"github.com/getcouragenow/getcourage-packages/mod-account/authn/pkg/utilities"
	kutil "github.com/getcouragenow/getcourage-packages/mod-account/server/keyutils"
	"time"
)

type (
	AuthnRepo struct {
		signingKey kutil.Signer
		store store.Storer
	}
)

func NewAuthnRepo(signingKey kutil.Signer, datastore store.Storer) *AuthnRepo {
	return &AuthnRepo{signingKey, datastore}
}

// NewClaim takes ClientID, UserID, Issuer, Audience (scopes), and Duration for expiry
func (a *AuthnRepo) NewClaim(cid, uid, iss string, aud []string, dur time.Duration) (string, error) {
	appclaim := kutil.NewAppClaims(cid, uid, iss, aud, dur)
	return appclaim.CreateJwtClaims(a.signingKey)
}

// VerifyGetUser Verifies user and password, then move on
func (a *AuthnRepo) VerifyGetUser(id string) (*store.User, error) {
	switch id {
	case "":
		uid := utilities.NewID()
		randmail := fmt.Sprintf("%s@example.com", uid)
		h, s, err := pass.Hash("")
		if err != nil {
			return nil, err
		}
		newuser := store.NewUser(id, "guest", randmail, h)
	}
}

