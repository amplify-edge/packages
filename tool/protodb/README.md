# Protodb

https://github.com/jackskj/protoc-gen-map

- Uses new Google Protobufs support from: https://github.com/protocolbuffers/protobuf-go
- Uses a .SQL gotemplate and maps the CRUD ( Create, Read, Update, Delete) Protobuf calls to the Database
	- Is based on github.com/Masterminds/sprig
- Provide 100% pure SQL control in the template, so there is nothing you cant do.
- Does not:
	- Manage the SQL migration
	- Manage the SQL creation
- Needs testing with TIDB which is a mySQL based DB.
- We need an approach to picking up CUD and turning that into Events
	- Maybe we can use the Pre and Post events this lib has to detect a CUD mutation and then 
		- Pump into NATS OR
		- Pump into a topic table in the db itself.

---


