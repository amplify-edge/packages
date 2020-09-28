package db

import (
	"errors"
	"math"
	"os"
	"path"

	"github.com/dgraph-io/badger"
)

const (
	maxPendingWrites = 256
)

func RestoreDb(sstDir, restoreFile string) error {
	// Check if the DB already exists
	manifestFile := path.Join(sstDir, badger.ManifestFilename)
	if _, err := os.Stat(manifestFile); err == nil { // No error. File already exists.
		return errors.New("Cannot restore to an already existing database")
	} else if os.IsNotExist(err) {
		// pass
	} else { // Return an error if anything other than the error above
		return err
	}

	// Open DB
	db, err := badger.Open(badger.DefaultOptions(sstDir).
		WithNumVersionsToKeep(math.MaxUint32))
	if err != nil {
		return err
	}
	defer db.Close()

	// Open File
	f, err := os.Open(restoreFile)
	if err != nil {
		return err
	}
	defer f.Close()

	// Run restore
	return db.Load(f, maxPendingWrites)
}
