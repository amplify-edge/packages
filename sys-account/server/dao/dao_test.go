package dao_test

import (
	"fmt"
	"log"
	"testing"

	"github.com/genjidb/genji"
	dao "github.com/getcouragenow/packages/sys-account/dao"
	"github.com/getcouragenow/packages/sys-core/server/pkg/db"
)

var (
	testDb *genji.DB = db.SharedDatabase()
)

func TestMakeSchema(t *testing.T) {
	log.Print("MakeSchema testing .....")

	if err := db.MakeSchema(testDb); err != nil {
		t.Error(err)
	}
}

func TestInsert(t *testing.T) {
	log.Print("Insert testing .....")

	o := dao.Org{ID: db.UID(), Name: "org001"}
	if err := o.Insert(testDb); err != nil {
		t.Error(err)
	}

	u := dao.User{ID: db.UID(), Name: "user1", Email: "example001@gmail.com"}
	if err := u.Insert(testDb); err != nil {
		t.Error(err)
	}

	p := dao.Project{ID: db.UID(), Name: "proj001", OrgID: o.ID}
	if err := p.Insert(testDb); err != nil {
		t.Error(err)
	}

	r := dao.Roles{ID: db.UID(), Role: "admin"}
	if err := r.Insert(testDb); err != nil {
		t.Error(err)
	}

	pr := dao.Permission{ID: db.UID(), User: u.Name, Org: o.Name, Project: p.Name, Role: r.Role}
	if err := pr.Insert(testDb); err != nil {
		t.Error(err)
	}

	log.Print("Print datas .....")
	printTables(t)

	log.Print("Update .....")
	u.Name = "user2"
	u.Update(testDb)

	o.Name = "org002"
	o.Update(testDb)

	p.Name = "proj002"
	p.Update(testDb)

	r.Role = "user"
	r.Update(testDb)

	pr.Org = o.Name
	pr.Project = p.Name
	pr.User = u.Name
	pr.Update(testDb)
	log.Print("Print datas .....")
	printTables(t)
}

func TestQuery(t *testing.T) {
	var o dao.Org
	sql := fmt.Sprintf("SELECT * FROM " + o.TableName() + " WHERE name = 'org002';")
	if err := db.QueryTable(testDb, &o, sql, func(out interface{}) {
		log.Printf("org => %v", out.(*dao.Org))
	}); err != nil {
		t.Error(err)
	}

	var p dao.Project
	sql = fmt.Sprintf("SELECT * FROM " + p.TableName() + " WHERE name = 'proj002';")
	if err := db.QueryTable(testDb, &p, sql, func(out interface{}) {
		log.Printf("proj => %v", out.(*dao.Project))
	}); err != nil {
		t.Error(err)
	}

	var u dao.User
	sql = fmt.Sprintf("SELECT * FROM " + u.TableName() + " WHERE name = 'user2';")
	if err := db.QueryTable(testDb, &u, sql, func(out interface{}) {
		log.Printf("user => %v", out.(*dao.User))
	}); err != nil {
		t.Error(err)
	}

	var r dao.Roles
	sql = fmt.Sprintf("SELECT * FROM " + r.TableName() + " WHERE role = 'user';")
	if err := db.QueryTable(testDb, &r, sql, func(out interface{}) {
		log.Printf("role => %v", out.(*dao.Roles))
	}); err != nil {
		t.Error(err)
	}

	var pr dao.Permission
	sql = fmt.Sprintf("SELECT * FROM " + pr.TableName() + " WHERE org = 'org002' AND user = 'user2';")
	if err := db.QueryTable(testDb, &pr, sql, func(out interface{}) {
		log.Printf("promission => %v", out.(*dao.Permission))
	}); err != nil {
		t.Error(err)
	}
}

func TestDelete(t *testing.T) {
	log.Print("Clanup all tables .....")
	o := dao.Org{}
	sql := "DELETE FROM " + o.TableName() + " WHERE name = 'org002';"
	log.Printf("DELETE Table: %v\n sql = %v", o.TableName(), sql)
	if err := testDb.Exec(sql); err != nil {
		t.Error(err)
	}

	u := dao.User{}
	sql = "DELETE FROM " + u.TableName() + " WHERE name = 'user2';"
	log.Printf("DELETE Table: %v\n sql = %v", u.TableName(), sql)
	if err := testDb.Exec(sql); err != nil {
		t.Error(err)
	}

	p := dao.Project{}
	sql = "DELETE FROM " + p.TableName() + " WHERE name = 'proj002';"
	log.Printf("DELETE Table: %v\n sql = %v", p.TableName(), sql)
	if err := testDb.Exec(sql); err != nil {
		t.Error(err)
	}

	r := dao.Roles{}
	sql = "DELETE FROM " + r.TableName() + " WHERE role = 'user';"
	log.Printf("DELETE Table: %v\n sql = %v", r.TableName(), sql)
	if err := testDb.Exec(sql); err != nil {
		t.Error(err)
	}

	pr := dao.Permission{}
	sql = "DELETE FROM " + pr.TableName() + " WHERE org = 'org002' AND user = 'user2';"
	log.Printf("DELETE Table: %v\n sql = %v", pr.TableName(), sql)
	if err := testDb.Exec(sql); err != nil {
		t.Error(err)
	}
}

func TestFinalResult(t *testing.T) {
	// If the final data is empty, it means that the test passed
	log.Print("Print result datas .....")
	printTables(t)
}

func printTables(t *testing.T) {
	var o dao.Org
	sql := fmt.Sprintf("SELECT * FROM " + o.TableName() + ";")
	if err := db.QueryTable(testDb, &o, sql, func(out interface{}) {
		log.Printf("org => %v", out.(*dao.Org))
	}); err != nil {
		t.Error(err)
	}

	var p dao.Project
	sql = fmt.Sprintf("SELECT * FROM " + p.TableName() + ";")
	if err := db.QueryTable(testDb, &p, sql, func(out interface{}) {
		log.Printf("proj => %v", out.(*dao.Project))
	}); err != nil {
		t.Error(err)
	}

	var u dao.User
	sql = fmt.Sprintf("SELECT * FROM " + u.TableName() + ";")
	if err := db.QueryTable(testDb, &u, sql, func(out interface{}) {
		log.Printf("user => %v", out.(*dao.User))
	}); err != nil {
		t.Error(err)
	}

	var r dao.Roles
	sql = fmt.Sprintf("SELECT * FROM " + r.TableName() + ";")
	if err := db.QueryTable(testDb, &r, sql, func(out interface{}) {
		log.Printf("role => %v", out.(*dao.Roles))
	}); err != nil {
		t.Error(err)
	}

	var pr dao.Permission
	sql = fmt.Sprintf("SELECT * FROM " + pr.TableName() + ";")
	if err := db.QueryTable(testDb, &pr, sql, func(out interface{}) {
		log.Printf("promission => %v", out.(*dao.Permission))
	}); err != nil {
		t.Error(err)
	}
}
