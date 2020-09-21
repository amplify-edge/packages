package db

import (
	"log"

	"github.com/dgraph-io/badger/v2"
	"github.com/genjidb/genji"
	"github.com/genjidb/genji/engine/badgerengine"
)

func DefaultDatabase() *genji.DB {
	return database
}

func MakeDb(name string) (*genji.DB, error) {
	// Create a badger engine
	ng, err := badgerengine.NewEngine(badger.DefaultOptions(name))
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	var db *genji.DB
	// Pass it to genji
	db, err = genji.New(ng)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}

	return db, nil
}

// MakeSchema create tables for `accounts` if not exists.
func MakeSchema(gdb *genji.DB) error {
	// DO in a transaction
	tx, err := gdb.Begin(true)
	if err != nil {
		log.Panic(err)
		return err
	}
	defer tx.Rollback()

	tables := []DbModel{
		User{},
		Project{},
		Org{},
		Roles{},
		Permission{},
	}

	for _, table := range tables {
		log.Printf("Create Table: %v, sql = %v", table.TableName(), table.CreateSQL()[0])
		for _, sql := range table.CreateSQL() {
			if err := gdb.Exec(sql); err != nil {
				err = tx.Rollback()
				log.Panic(err)
				return err
			}
		}
	}

	err = tx.Commit()
	if err != nil {
		err = tx.Rollback()
		log.Panic(err)
		return err
	}

	return nil
}
