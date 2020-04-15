package minio

import (
	"context"
	"github.com/getcouragenow/packages/mod-main/server/pkg/config"
	mn "github.com/minio/minio-go/v6"
	"github.com/minio/minio-go/v6/pkg/encrypt"
	"github.com/minio/minio-go/v6/pkg/s3utils"
	"io"
)

type Ministore struct {
	*mstore
}

// mstore contains minio bucket and client
type mstore struct {
	bucket string
	mc     *mn.Client
	sse    encrypt.ServerSide
}

// New creates new instance of mstore
func New(ctx context.Context, cfg config.ConnCfg) (*Ministore, error) {
	if err := s3utils.CheckValidBucketName(cfg.BucketName); err != nil {
		return nil, err
	}
	mc, err := mn.New(cfg.Endpoint, cfg.AccessKey, cfg.SecretKey, cfg.UseSSL)
	if err != nil {
		return nil, err
	}
	exists, err := mc.BucketExists(cfg.BucketName)
	if err != nil {
		return nil, err
	}
	if !exists {
		err = mc.MakeBucketWithContext(ctx, cfg.BucketName, cfg.Location)
		if err != nil {
			return nil, err
		}
	}
	var sse encrypt.ServerSide
	if len(cfg.EncKey) > 0 {
		sse, err = encrypt.NewSSEC(cfg.EncKey)
		if err != nil {
			return nil, err
		}
	}
	return &Ministore{
		&mstore{
			bucket: cfg.BucketName,
			mc:     mc,
			sse:    sse,
		},
	}, nil
}

// Put will 'put' the object under the name to minio store
// since the object name is prefixed by the ID of both its campaign and support-role
// it should be easily queried.
func (m *Ministore) Put(ctx context.Context, name string, obj io.Reader) (int64, error) {
	return m.mc.PutObjectWithContext(ctx, m.bucket, name, obj, -1, mn.PutObjectOptions{
		ServerSideEncryption: m.sse,
	})
}

func (m *Ministore) Remove(name string) error {
	return m.mc.RemoveObject(m.bucket, name)
}

func (m *Ministore) Open(ctx context.Context, name string) (io.ReadSeeker, error) {
	return m.mc.GetObjectWithContext(ctx, m.bucket, name, mn.GetObjectOptions{
		ServerSideEncryption: m.sse,
	})
}

// TODO fix this implementation as this is an absolute perf hit.
func (m *Ministore) List(ctx context.Context, prefix string) ([]io.ReadSeeker, error) {
	var objContents []io.ReadSeeker
	var objNames []string
	doneChan := make(chan struct{})
	errChan := make(chan error)
	go func() {
		defer close(errChan)
		defer close(doneChan)
		for obj := range m.mc.ListObjectsV2(m.bucket, prefix, true, doneChan) {
			if obj.Err != nil {
				errChan <- obj.Err
			}
			objNames = append(objNames, obj.Key)
		}
	}()
	select {
	case <-doneChan:
		for _, name := range objNames {
			content, err := m.Open(ctx, name)
			if err != nil {
				return nil, err
			}
			objContents = append(objContents, content)
		}
	case err := <-errChan:
		return nil, err
	}

	return objContents, nil
}
