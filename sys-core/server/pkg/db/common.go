package db

import (
	"github.com/genjidb/genji"
	"github.com/segmentio/ksuid"
)

var (
	database    *genji.DB
	dbName      = "getcouragenow.db"
	tablePrefix = "sys_core"
	modName     = "accounts"
)

func tableName(name string) string {
	return tablePrefix + "_" + modName + "_" + name
}

func UID() string {
	return ksuid.New().String()
}

type DbModel interface {
	TableName() string
	CreateSQL() []string
}
