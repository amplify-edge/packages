package db

import "log"

func init() {
	log.Print("Db " + dbName + "Open .....")
	var err error
	database, err = makeDb(dbName, dbEncryptKey)
	if err != nil {
		log.Fatalf("Db "+dbName+"Open failed: %v", err)
	}
}

func close() {
	database.Close()
}
