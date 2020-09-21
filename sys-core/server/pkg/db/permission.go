package db

import (
	"fmt"

	"github.com/genjidb/genji"
)

type Permission struct {
	ID      string
	User    string
	Org     string
	Project string
	Role    string
}

func (self Permission) TableName() string {
	return tableName("premission")
}

func (self Permission) CreateSQL() []string {
	return []string{
		`CREATE TABLE IF NOT EXISTS ` + self.TableName() + ` (
			id TEXT NOT NULL PRIMARY KEY,
			user TEXT NOT NULL,
			org TEXT NOT NULL,
			project TEXT NOT NULL,
			role TEXT NOT NULL,
		)`,
		"CREATE INDEX IF NOT EXISTS idx_orgs ON " + self.TableName() + "(name);",
	}
}

func (self *Permission) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, user, org, project, role) VALUES (?, ?, ?, ?, ?)", self.TableName())
	return db.Exec(s, self.ID, self.User, self.Org, self.Project, self.Role)
}
