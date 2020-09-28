package db_test

import (
	"log"
	"testing"

	"github.com/getcouragenow/packages/sys-core/server/pkg/db"
)

var (
	oldKey = []byte("testkey000000000")
	newKey = []byte("testkey111111111")
)

func TestRotate(t *testing.T) {
	dbName := "getcouragenow-x.db"
	log.Printf("rotate db: %v, %v => %v", dbName, oldKey, newKey)
	if err := db.RotateDb(dbName, oldKey, newKey); err != nil {
		t.Error(err)
	}
}
