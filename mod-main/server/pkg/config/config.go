package config

import (
	"os"
	"reflect"
	"strconv"
	"time"
)

type configer interface {
	validate() error
}

type ModMainCfg struct {
	ConnOpt ConnCfg
}

// ConnCfg is the Connection Option for minio storage
type ConnCfg struct {
	AccessKey string
	SecretKey string
	EncKey []byte
	Endpoint string
	Location string
	UseSSL bool
	Timeout time.Duration
	BucketName string
}

// NewCfg creates new instance of ModMainCfg
func NewCfg() (*ModMainCfg, error) {
	usesSSL := false
	if os.Getenv("MINIO_USE_SSL") == "true" {
		usesSSL = true
	}
	c := &ModMainCfg{
		ConnCfg{
			AccessKey: os.Getenv("MINIO_ACCESS_KEY"),
			SecretKey: os.Getenv("MINIO_SECRET_KEY"),
			EncKey:    []byte(os.Getenv("MINIO_ENC_KEY")),
			Endpoint:  os.Getenv("MINIO_ENDPOINT"),
			Location:  os.Getenv("MINIO_LOCATION"),
			UseSSL:    usesSSL,
			Timeout:   time.Millisecond * time.Duration(validateUintEnv("MINIO_TIMEOUT")),
			BucketName: os.Getenv("BUCKET_NAME"),
		},
	}
	err := c.validate()
	return c, err
}

func (m *ModMainCfg) validate() error {
	v := reflect.ValueOf(m).Elem()
	baseConfigType := reflect.TypeOf((*configer)(nil)).Elem()
	
	for i := 0; i < v.NumField(); i++ {
		if v.Type().Field(i).Type.Implements(baseConfigType) {
			if err := v.Field(i).Interface().(configer).validate(); err != nil {
				return err
			}
		}
	}
	return nil
}

func validateUintEnv(envName string) uint32 {
	v := os.Getenv(envName)
	if v == "" {
		return 0
	}
	u, err := strconv.ParseUint(v, 10, 64)
	if err != nil {
		return 0
	}
	return uint32(u)
}