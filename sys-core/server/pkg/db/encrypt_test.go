package db_test

import (
	"fmt"
	"log"
	"testing"

	"github.com/dgraph-io/badger/v2"
	"github.com/genjidb/genji"
	"github.com/genjidb/genji/engine/badgerengine"
)

var (
	enctypedDb *genji.DB
	encDbName  = "getcouragenow-x.db"
	key        = []byte("testkey000000000")
)

func TestMakeEncryptedDB(t *testing.T) {
	gdb, err := makeOrOpenEncDb(encDbName, key)
	if err != nil {
		t.Error(err)
	}
	enctypedDb = gdb
}

func TestEncryptedDBKeyMismatch(t *testing.T) {
	// close db and reopen.
	if enctypedDb != nil {
		enctypedDb.Close()
		enctypedDb = nil
	}

	_, err := reOpenDb(encDbName)
	if fmt.Sprint(err) != "Encryption key mismatch" {
		t.Errorf("Encryption failed")
	}
}

func TestEncryptedDBReOpen(t *testing.T) {
	gdb, err := makeOrOpenEncDb(encDbName, key)
	if err != nil {
		t.Error(err)
	}
	enctypedDb = gdb
}

func makeOrOpenEncDb(name string, key []byte) (*genji.DB, error) {
	// Create a badger engine
	options := badger.DefaultOptions(name)
	options.EncryptionKey = key
	ng, err := badgerengine.NewEngine(options)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	var gdb *genji.DB
	// Pass it to genji
	gdb, err = genji.New(ng)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}

	return gdb, nil
}

func reOpenDb(name string) (*genji.DB, error) {
	// Create a badger engine
	ng, err := badgerengine.NewEngine(badger.DefaultOptions(name))
	if err != nil {
		return nil, err
	}
	var gdb *genji.DB
	// Pass it to genji
	gdb, err = genji.New(ng)
	if err != nil {
		return nil, err
	}

	return gdb, nil
}
