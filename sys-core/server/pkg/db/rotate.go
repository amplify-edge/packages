package db

import (
	"time"

	"github.com/dgraph-io/badger/v2"
)

func RotateDb(sstDir string, oldKey, newKey []byte) error {
	opt := badger.KeyRegistryOptions{
		Dir:                           sstDir,
		ReadOnly:                      false,
		EncryptionKey:                 oldKey,
		EncryptionKeyRotationDuration: 180 * 24 * time.Hour,
	}
	kr, err := badger.OpenKeyRegistry(opt)
	if err != nil {
		return err
	}
	opt.EncryptionKey = newKey
	err = badger.WriteKeyRegistry(kr, opt)
	if err != nil {
		return err
	}
	return nil
}
