package db

import (
	"bufio"
	"math"
	"os"

	"github.com/dgraph-io/badger/v2"
)

func BackupDb(sstDir, backupFile string) error {
	opt := badger.DefaultOptions(sstDir).
		WithTruncate(false).
		WithNumVersionsToKeep(math.MaxUint32)
	// Open DB
	db, err := badger.Open(opt)
	if err != nil {
		return err
	}
	defer db.Close()

	// Create File
	f, err := os.Create(backupFile)
	if err != nil {
		return err
	}

	bw := bufio.NewWriterSize(f, 64<<20)
	if _, err = db.Backup(bw, 0); err != nil {
		return err
	}

	if err = bw.Flush(); err != nil {
		return err
	}

	if err = f.Sync(); err != nil {
		return err
	}

	return f.Close()
}
