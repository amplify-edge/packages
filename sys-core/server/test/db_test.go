package test_db

import (
	"log"
	"testing"

	"github.com/genjidb/genji"
	"github.com/getcouragenow/getcourage-packages/sys-core/server/pkg/db"
)

var (
	testDb *genji.DB
)

func init() {
	testDb = db.DefaultDatabase()
}

func TestMakeSchema(t *testing.T) {
	log.Print("MakeSchema testing .....")

	if err := db.MakeSchema(testDb); err != nil {
		t.Error(err)
	}
}

func TestInsert(t *testing.T) {
	log.Print("Insert testing .....")

	o := db.Org{ID: db.UID(), Name: "org001"}
	if err := o.Insert(testDb); err != nil {
		t.Error(err)
	}

	u := db.User{ID: db.UID(), Name: "user1", Email: "example001@gmail.com"}
	if err := u.Insert(testDb); err != nil {
		t.Error(err)
	}

	p := db.Project{ID: db.UID(), Name: "proj002"}
	if err := p.Insert(testDb); err != nil {
		t.Error(err)
	}

	r := db.Roles{ID: db.UID(), Role: "admin"}
	if err := r.Insert(testDb); err != nil {
		t.Error(err)
	}

	pr := db.Permission{ID: db.UID(), User: u.Name, Org: o.Name, Project: p.Name, Role: r.Role}
	if err := pr.Insert(testDb); err != nil {
		t.Error(err)
	}
}

func TestQuery(t *testing.T) {
	log.Print("Query testing .....")

	var o db.Org
	if err := db.QueryTable(testDb, &o, func(out interface{}) {
		log.Printf("org => %v", out.(*db.Org))
	}); err != nil {
		t.Error(err)
	}

	var p db.Project
	if err := db.QueryTable(testDb, &p, func(out interface{}) {
		log.Printf("proj => %v", out.(*db.Project))
	}); err != nil {
		t.Error(err)
	}

	var u db.User
	if err := db.QueryTable(testDb, &u, func(out interface{}) {
		log.Printf("user => %v", out.(*db.User))
	}); err != nil {
		t.Error(err)
	}

	var r db.Roles
	if err := db.QueryTable(testDb, &r, func(out interface{}) {
		log.Printf("role => %v", out.(*db.Roles))
	}); err != nil {
		t.Error(err)
	}

	var pr db.Permission
	if err := db.QueryTable(testDb, &pr, func(out interface{}) {
		log.Printf("promission => %v", out.(*db.Permission))
	}); err != nil {
		t.Error(err)
	}
}
