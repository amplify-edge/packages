package dao

import (
	"fmt"

	"github.com/genjidb/genji"
)

type User struct {
	ID    string
	Name  string
	Email string
}

func (self User) TableName() string {
	return tableName("users")
}

func (self User) CreateSQL() []string {
	return []string{
		`CREATE TABLE IF NOT EXISTS ` + self.TableName() + ` (
			id TEXT NOT NULL PRIMARY KEY,
			name TEXT NOT NULL,
			email TEXT NOT NULL
		);`,
		"CREATE INDEX IF NOT EXISTS idx_users ON " + self.TableName() + "(name);",
	}
}

func (self *User) Insert(db *genji.DB) error {
	s := fmt.Sprintf("INSERT INTO %s (id, name, email) VALUES (?, ?, ?)", self.TableName())
	return db.Exec(s, self.ID, self.Name, self.Email)
}

func (self *User) Update(db *genji.DB) error {
	s := fmt.Sprintf("UPDATE %s SET  name = ?, email = ? WHERE id = ?", self.TableName())
	return db.Exec(s, self.Name, self.Email, self.ID)
}
