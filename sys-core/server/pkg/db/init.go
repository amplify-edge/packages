package db

import "log"

func init() {
	log.Print("DbOpen .....")
	var err error
	database, err = MakeDb(dbName)
	if err != nil {
		log.Fatalf("DbOpen failed: %v", err)
	}
}

func close() {
	database.Close()
}
