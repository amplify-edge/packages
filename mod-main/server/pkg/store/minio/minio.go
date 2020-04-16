package minio

import (
	"context"
	"errors"
	"github.com/getcouragenow/packages/mod-main/server/pkg/config"
	mn "github.com/minio/minio-go/v6"
	"github.com/minio/minio-go/v6/pkg/encrypt"
	"github.com/minio/minio-go/v6/pkg/s3utils"
	"io"
	"io/ioutil"
	"regexp"
)

type (
	Ministore struct {
		*mstore
	}
	mstore struct {
		bucket string
		mc     *mn.Client
		sse    encrypt.ServerSide
	}
	Valider interface {
		getParams() string
		getQuery() string
		validateParam() bool
	}
	listQuery struct {
		query string
	}
	singleQuery struct {
		query string
		param string
		regexString string
	}
)

func NewListQuery(query string) *listQuery {
	return &listQuery{
		query,
	}
}

func NewSingleQuery(query, param, regexString string) *singleQuery {
	return &singleQuery{
		query,
		param,
		regexString,
	}
}

func (s *singleQuery) getParams() string {
	return s.param
}

func (s *singleQuery) getQuery() string {
	return s.query
}

func (s *singleQuery) validateParam() bool {
	re := regexp.MustCompile(s.regexString)
	return re.MatchString(s.param)
}

func (l *listQuery) getParams() string {
	return ""
}

func (l *listQuery) getQuery() string {
	return l.query
}

func (l *listQuery) validateParam() bool {
	return true
}

// mstore contains minio bucket and client

func validateQuery(param, regex string) bool {
	re := regexp.MustCompile(regex)
	return re.MatchString(param)
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

func (m *Ministore) selectObject(ctx context.Context, query, objName string) ([]byte, error) {
	opts := mn.SelectObjectOptions{
		ServerSideEncryption: m.sse,
		Expression:           query,
		ExpressionType:       mn.QueryExpressionTypeSQL,
		InputSerialization: mn.SelectObjectInputSerialization{
			CompressionType: mn.SelectCompressionGZIP,
			CSV: &mn.CSVInputOptions{
				FileHeaderInfo:  mn.CSVFileHeaderInfoUse,
				RecordDelimiter: "\n",
				FieldDelimiter:  ",",
			},
		},
		OutputSerialization: mn.SelectObjectOutputSerialization{
			JSON: &mn.JSONOutputOptions{
				RecordDelimiter: "\r\n",
			},
		},
	}
	reader, err := m.mc.SelectObjectContent(ctx, m.bucket, objName, opts)
	if err != nil {
		return nil, err
	}
	defer reader.Close()
	body, err := ioutil.ReadAll(reader)
	return body, nil
}

func (m *Ministore) GetSingle(ctx context.Context, v Valider, objName string) ([]byte, error) {
	match := v.validateParam()
	if !match {
		return nil, errors.New("param(s) are not valid")
	}
	sq := v.getQuery() + v.getParams()
	byteres, err := m.selectObject(ctx, sq, objName)
	if err != nil {
		return nil, err
	}
	return byteres, nil
}

func (m *Ministore) GetMultiple(ctx context.Context, v Valider, objName string) ([]byte, error) {
	lq := v.getQuery()
	byteres, err := m.selectObject(ctx, lq, objName)
	if err != nil {
		return nil, err
	}
	return byteres, nil
}
