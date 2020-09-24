package delivery_test

import (
	"context"
	"github.com/getcouragenow/packages/sys-account/delivery"
	"github.com/getcouragenow/packages/sys-account/pkg/auth"
	rpc "github.com/getcouragenow/packages/sys-account/rpc/v2"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"os"
	"testing"
)

var (
	ad            *delivery.AuthDelivery
	loginRequests = []*rpc.LoginRequest{
		{
			Email:    "someemail@example.com",
			Password: "someInsecureBlaBlaPassword",
		},
		{
			Email:    "superadmin@getcouragenow.org",
			Password: "superadmin",
		},
	}
)

func TestAuthDeliveryAll(t *testing.T) {
	os.Setenv("JWT_ACCESS_SECRET", "AccessVerySecretHush!")
	os.Setenv("JWT_REFRESH_SECRET", "RefreshVeryHushHushFriends!")
	tc := auth.NewTokenConfig([]byte(os.Getenv("JWT_ACCESS_SECRET")), []byte(os.Getenv("JWT_REFRESH_SECRET")))
	ad = &delivery.AuthDelivery{
		Log:      logrus.New().WithField("test", "auth-delivery"),
		TokenCfg: tc,
	}
	t.Run("Test Login User", testUserLogin)
	t.Parallel()
}

func testUserLogin(t *testing.T) {
	// empty request
	_, err := ad.Login(context.Background(), nil)
	assert.Error(t, err, status.Errorf(codes.Unauthenticated, "Can't authenticate: %v", auth.AuthError{Reason: auth.ErrInvalidParameters}))
	// Wrong credentials
	_, err = ad.Login(context.Background(), loginRequests[0])
	assert.Error(t, err, status.Errorf(codes.Unauthenticated, "cannot authenticate: %v", auth.AuthError{Reason: auth.ErrInvalidCredentials}))
	// Correct Credentials
	resp, err := ad.Login(context.Background(), loginRequests[1])
	assert.NoError(t, err)
	t.Logf("Successfully logged in user: %s => %s, %s",
		loginRequests[1].Email, resp.AccessToken, resp.RefreshToken)
}
