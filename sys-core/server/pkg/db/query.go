package db

import (
	"log"

	"github.com/genjidb/genji"
	"github.com/genjidb/genji/document"
)

func QueryTable(db *genji.DB, in interface{}, sql string, outcb func(out interface{})) error {
	stream, err := db.Query(sql)
	if err != nil {
		log.Print(err)
		return err
	}

	defer stream.Close()

	// Iterate over the results
	var out interface{} = in
	err = stream.Iterate(func(d document.Document) error {
		err = document.StructScan(d, out)
		if err != nil {
			return err
		}
		//log.Printf("out => %v", out)
		outcb(out)
		return nil
	})

	if err != nil {
		log.Print(err)
		return err
	}
	return nil
}
