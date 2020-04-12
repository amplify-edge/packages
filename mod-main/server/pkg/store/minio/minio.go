package minio

import (
	"context"
	"github.com/getcouragenow/packages/mod-main/server/pkg/config"
	mn "github.com/minio/minio-go/v6"
	"github.com/minio/minio-go/v6/pkg/encrypt"
	"github.com/minio/minio-go/v6/pkg/s3utils"
	"io"
)

// Mstore contains minio bucket and client
type Mstore struct {
	bucket string
	mc *mn.Client
	sse encrypt.ServerSide
}

// New creates new instance of mstore
func New(ctx context.Context, bucketName string, cfg config.ConnCfg) (*Mstore, error) {
	if err := s3utils.CheckValidBucketName(bucketName); err != nil {
		return nil, err
	}
	mc, err := mn.New(cfg.Endpoint, cfg.AccessKey, cfg.SecretKey, cfg.UseSSL)
	if err != nil {
		return nil, err
	}
	exists, err := mc.BucketExists(bucketName)
	if err != nil {
		return nil, err
	}
	if !exists {
		err = mc.MakeBucketWithContext(ctx, bucketName, cfg.Location)
		if err != nil {
			return nil, err
		}
	}
	var sse encrypt.ServerSide
	if len(cfg.EncKey) > 0 {
		sse, err = encrypt.NewSSEC(cfg.EncKey)
		if err != nil {
			return nil,err
		}
	}
	return &Mstore{
		bucket: bucketName,
		mc: mc,
		sse: sse,
	}, nil
}

func (m *Mstore) Put(ctx context.Context, name string, obj io.Reader) (int64, error) {
	return m.mc.PutObjectWithContext(ctx, m.bucket, name, obj, -1, mn.PutObjectOptions{
		ServerSideEncryption: m.sse,
	})
}

func (m *Mstore) Remove(name string) error {
	return m.mc.RemoveObject(m.bucket, name)
}

func (m *Mstore) Open(ctx context.Context, name string) (io.ReadSeeker, error) {
	return m.mc.GetObjectWithContext(ctx, m.bucket, name, mn.GetObjectOptions{
		ServerSideEncryption: m.sse,
	})
}

