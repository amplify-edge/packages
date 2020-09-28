package db_test

import (
	"log"
	"testing"

	"github.com/getcouragenow/packages/sys-core/server/pkg/db"
)

const (
	restoreDir = "backups"
)

func TestRestore(t *testing.T) {
	backupFile := "./" + restoreDir + "/" + "db_backup.bak"
	dbName := "restored_db.db"
	log.Printf("backup %v => %v", dbName, backupFile)
	if err := db.RestoreDb(dbName, backupFile); err != nil {
		t.Error(err)
	}
}
