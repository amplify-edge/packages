package auth_test

import (
	"github.com/getcouragenow/packages/sys-account/authn/pkg/auth"
	"github.com/getcouragenow/packages/sys-account/authn/pkg/utilities"
	"github.com/getcouragenow/packages/sys-account/rpc"
	"github.com/stretchr/testify/assert"
	"testing"
)

var (
	tc             *auth.TokenConfig
	accountSeeders = []*rpc.Account{
		{
			Id:       "1hpMOKQj30jOrqtB8hLmclWtXGx",
			Email:    "winwisely268@example.com",
			Password: "SOME_HASHED_ARGON",
			Role:     nil,
		},
		{
			Id:       "1hpMToJZs40ZHEiIuDGQkqtd8oV",
			Email:    "winwisely269@example.com",
			Password: "HATH_NO_FURY_LIKE",
			Role: &rpc.UserRoles{
				Role:     4, // Superadmin
				Resource: &rpc.UserRoles_All{All: true},
			},
		},
		{
			Id:       "1hpMToJZs40ZHEiIuDGQkqtd8oV",
			Email:    "winwisely267@example.com",
			Password: "A_CI_BEING_SCORNED",
			Role: &rpc.UserRoles{
				Role: 3, // Org Admin
				Resource: &rpc.UserRoles_Org{
					Org: &rpc.Org{
						Id: "1hpMx8pkde4IGFYdhrASY5cPei2",
					},
				},
			},
		},
		{
			Id:       "1hpMToJZs40ZHEiIuDGQkqtd8oV",
			Email:    "winwisely267@example.com",
			Password: "WE_WANT_GO_GENERICS",
			Role: &rpc.UserRoles{
				Role: 2, // Project Admin
				Resource: &rpc.UserRoles_Project{
					Project: &rpc.Project{
						Id: "1hpMx8pkde4IGFYdhrASY5cPei2",
					},
				},
			},
		},
	}
)

func TestTokenAll(t *testing.T) {
	accessSecret, err := utilities.GenRandomByteSlice(32)
	assert.NoError(t, err)
	refreshSecret, err := utilities.GenRandomByteSlice(32)
	assert.NoError(t, err)
	tc = auth.NewTokenConfig(accessSecret, refreshSecret)
	t.Run("TestNewTokenPairs", testNewTokenPairs)
	t.Parallel()
}

func testNewTokenPairs(t *testing.T) {
	for _, acc := range accountSeeders {
		tpairs, err := tc.NewTokenPairs(acc)
		assert.NoError(t, err)
		t.Logf("Successfully generated token pairs for: %s => Access: %s\n, Refresh: %s\n",
			acc.GetEmail(), tpairs.AccessToken, tpairs.RefreshToken)
	}
}
