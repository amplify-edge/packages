package dao

import (
	"fmt"

	"github.com/genjidb/genji"
)

type RoleTypeEnum string

var (
	RoleAdmin      RoleTypeEnum = "Admin"
	RoleUser       RoleTypeEnum = "User"
	RoleSuperAdmin RoleTypeEnum = "SuperAdmin"
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
		"CREATE INDEX IF NOT EXISTS idx_roles ON " + self.TableName() + "(role);",
	}
}

func (self *Roles) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, role) VALUES (?, ?)", self.TableName())
	return db.Exec(s, self.ID, self.Role)
}

func (self *Roles) Update(db *genji.DB) error {
	s := fmt.Sprintf("UPDATE %s SET  role = ? WHERE id = ?", self.TableName())
	return db.Exec(s, self.Role, self.ID)
}
