package dao

import (
	"fmt"

	"github.com/genjidb/genji"
)

type Project struct {
	ID    string
	Name  string
	OrgID string
}

func (self Project) TableName() string {
	return tableName("projects")
}

func (self Project) CreateSQL() []string {
	return []string{
		`CREATE TABLE IF NOT EXISTS ` + self.TableName() + ` (
			id TEXT NOT NULL PRIMARY KEY,
			name TEXT NOT NULL,
			orgid TEXT
		)`,
		"CREATE INDEX IF NOT EXISTS idx_projects ON " + self.TableName() + "(name);",
	}
}

func (self *Project) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, name, orgid) VALUES (?, ?, ?)", self.TableName())
	return db.
		Exec(s, self.ID, self.Name, self.OrgID)
}

func (self *Project) Update(db *genji.DB) error {
	s := fmt.Sprintf("UPDATE %s SET  name = ?, orgid = ? WHERE id = ?", self.TableName())
	return db.Exec(s, self.Name, self.OrgID, self.ID)
}
