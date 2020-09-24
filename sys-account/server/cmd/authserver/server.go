// package main
// this is only used for local testing
// making sure that the sys-account server works locally before wiring it up to the maintemplate.
package main

import (
	"context"
	"github.com/getcouragenow/packages/sys-account/delivery"
	"github.com/getcouragenow/packages/sys-account/pkg/auth"
	"github.com/getcouragenow/packages/sys-account/pkg/utilities"
	"github.com/getcouragenow/packages/sys-account/rpc/v2"
	grpc_middleware "github.com/grpc-ecosystem/go-grpc-middleware"
	grpc_auth "github.com/grpc-ecosystem/go-grpc-middleware/auth"
	grpc_logrus "github.com/grpc-ecosystem/go-grpc-middleware/logging/logrus"
	grpc_recovery "github.com/grpc-ecosystem/go-grpc-middleware/recovery"
	"github.com/improbable-eng/grpc-web/go/grpcweb"
	"github.com/sirupsen/logrus"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"net/http"
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
		UnauthenticatedRoutes: []string{
			"/getcouragenow.v2.sys_account.AuthService/Login",
			"/getcouragenow.v2.sys_account.AuthService/Register",
			"/getcouragenow.v2.sys_account.AuthService/ResetPassword",
			"/getcouragenow.v2.sys_account.AuthService/ForgotPassword",
			"/getcouragenow.v2.sys_account.AuthService/RefreshAccessToken",
			// debugging purposes
			"/grpc.reflection.v1alpha.ServerReflection/ServerReflectionInfo",
		},
	}
	recoveryOptions := []grpc_recovery.Option{
		grpc_recovery.WithRecoveryHandler(recoveryHandler(log)),
	}
	ctx := context.Background()
	ctx, cancel := context.WithTimeout(ctx, 10*time.Second)
	defer cancel()

	//netLis, err := net.Listen("tcp", "127.0.0.1:8888")
	//if err != nil {
	//	log.Fatalf("error listening to http://127.0.0.1:8888 => %v\n", err)
	//	os.Exit(1)
	//}
	logrusOpts := []grpc_logrus.Option{
		grpc_logrus.WithLevels(grpc_logrus.DefaultCodeToLevel),
	}

	grpcSrv := grpc.NewServer(
		grpc_middleware.WithUnaryServerChain(
			grpc_recovery.UnaryServerInterceptor(recoveryOptions...),
			grpc_logrus.UnaryServerInterceptor(log, logrusOpts...),
			grpc_auth.UnaryServerInterceptor(authDelivery.DefaultInterceptor),
		),
		grpc_middleware.WithStreamServerChain(
			grpc_recovery.StreamServerInterceptor(recoveryOptions...),
			grpc_logrus.StreamServerInterceptor(log, logrusOpts...),
			grpc_auth.StreamServerInterceptor(authDelivery.DefaultInterceptor),
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

	grpcWebServer := grpcweb.WrapServer(
		grpcSrv,
		grpcweb.WithCorsForRegisteredEndpointsOnly(false),
		grpcweb.WithWebsocketOriginFunc(func(req *http.Request) bool {
			return true
		}),
		grpcweb.WithWebsockets(true),
	)

	httpServer := &http.Server{
		Handler: h2c.NewHandler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			w.Header().Set("Access-Control-Allow-Origin", "*")
			w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
			w.Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, X-User-Agent, X-Grpc-Web")
			log.Infof("Request Endpoint: %s", r.URL)
			grpcWebServer.ServeHTTP(w, r)
		}), &http2.Server{}),
	}
	httpServer.Addr = "127.0.0.1:8888"
	log.Infof("server listening at %v\n", httpServer.Addr)
	if err := httpServer.ListenAndServe(); err != nil {
		log.Fatalf("error running http server: %v\n", err)
	}
}
