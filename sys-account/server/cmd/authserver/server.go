// package main
// this is only used for local testing
// making sure that the sys-account server works locally before wiring it up to the maintemplate.
package main

import (
	"context"
	"github.com/getcouragenow/packages/sys-account/authn/delivery"
	"github.com/getcouragenow/packages/sys-account/authn/pkg/auth"
	"github.com/getcouragenow/packages/sys-account/authn/pkg/utilities"
	"github.com/getcouragenow/packages/sys-account/rpc"
	grpc_middleware "github.com/grpc-ecosystem/go-grpc-middleware"
	grpc_logrus "github.com/grpc-ecosystem/go-grpc-middleware/logging/logrus"
	grpc_recovery "github.com/grpc-ecosystem/go-grpc-middleware/recovery"
	"github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"net"
	"os"
	"time"
)

func recoveryHandler(l *logrus.Entry) func(panic interface{}) error {
	return func(panic interface{}) error {
		l.Warnf("sys-account service recovered, reason: %v",
			panic)
		return nil
	}
}

func main() {
	log := logrus.New().WithField("svc", "sys-account")
	accessSecret, err := utilities.GenRandomByteSlice(32)
	if err != nil {
		log.Fatalf("error creating jwt access token secret: %v\n", err)
		os.Exit(1)
	}
	refreshSecret, err := utilities.GenRandomByteSlice(32)
	if err != nil {
		log.Fatalf("error creating jwt access token secret: %v\n", err)
		os.Exit(1)
	}
	tokenConfig := auth.NewTokenConfig(accessSecret, refreshSecret)
	// AuthDelivery will be the object to be passed around other services if you will
	authDelivery := delivery.AuthDelivery{
		Log:      log,
		TokenCfg: tokenConfig,
	}
	recoveryOptions := []grpc_recovery.Option{
		grpc_recovery.WithRecoveryHandler(recoveryHandler(log)),
	}
	ctx := context.Background()
	ctx, cancel := context.WithTimeout(ctx, 10*time.Second)
	defer cancel()

	netLis, err := net.Listen("tcp", "127.0.0.1:8888")
	if err != nil {
		log.Fatalf("error listening to http://127.0.0.1:8888 => %v\n", err)
		os.Exit(1)
	}
	logrusOpts := []grpc_logrus.Option{
		grpc_logrus.WithLevels(grpc_logrus.DefaultCodeToLevel),
	}

	grpcSrv := grpc.NewServer(
		grpc_middleware.WithUnaryServerChain(
			grpc_recovery.UnaryServerInterceptor(recoveryOptions...),
			grpc_logrus.UnaryServerInterceptor(log, logrusOpts...),
		),
		grpc_middleware.WithStreamServerChain(
			grpc_recovery.StreamServerInterceptor(recoveryOptions...),
			grpc_logrus.StreamServerInterceptor(log, logrusOpts...),
		),
	)
	rpc.RegisterAuthServiceService(grpcSrv, &rpc.AuthServiceService{
		Register:           authDelivery.Register,
		Login:              authDelivery.Login,
		ForgotPassword:     authDelivery.ForgotPassword,
		ResetPassword:      authDelivery.ResetPasssword,
		RefreshAccessToken: authDelivery.RefreshAccessToken,
	})
	reflection.Register(grpcSrv)

	log.Infof("Serving grpc server on %s", "127.0.0.1:8888")
	grpcSrv.Serve(netLis)
}
