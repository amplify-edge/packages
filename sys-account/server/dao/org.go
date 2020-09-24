package dao

import (
	"fmt"

	"github.com/genjidb/genji"
)

type Org struct {
	ID   string
	Name string
}

func (self Org) TableName() string {
	return tableName("orgs")
}

func (self Org) CreateSQL() []string {
	return []string{
		`CREATE TABLE IF NOT EXISTS ` + self.TableName() + ` (
			id TEXT NOT NULL PRIMARY KEY,
			name TEXT NOT NULL
		)`,
		"CREATE INDEX IF NOT EXISTS idx_orgs ON " + self.TableName() + "(name);",
	}
}

func (self *Org) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, name) VALUES (?, ?)", self.TableName())
	return db.Exec(s, self.ID, self.Name)
}

func (self *Org) Update(db *genji.DB) error {
	s := fmt.Sprintf("UPDATE %s SET  name = ? WHERE id = ?", self.TableName())
	return db.Exec(s, self.Name, self.ID)
}
