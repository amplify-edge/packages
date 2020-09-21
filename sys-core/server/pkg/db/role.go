package db

import (
	"fmt"

	"github.com/genjidb/genji"
)

type Roles struct {
	ID   string
	Role string
}

func (self Roles) TableName() string {
	return tableName("roles")
}

func (self Roles) CreateSQL() []string {
	return []string{
		`CREATE TABLE IF NOT EXISTS ` + self.TableName() + ` (
			id TEXT NOT NULL PRIMARY KEY,
			role TEXT NOT NULL
		)`,
		"CREATE INDEX IF NOT EXISTS idx_roles ON " + self.TableName() + "(name);",
	}
}

func (self *Roles) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, role) VALUES (?, ?)", self.TableName())
	return db.Exec(s, self.ID, self.Role)
}
