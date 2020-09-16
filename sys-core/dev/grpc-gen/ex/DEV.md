# grpc gen


This allows rapid code gen from GRPC.

I only had 30 minutes to spend on all of this.
Each folder has a make file which runs an example.

If we like this we can  use for our own GRPC, is the intent !!


1. Gen the golang structs from Protobufs
- see: structs/bold-commerce__protoc-gen-struct-transformer
	- see make file
- This might be needed to make it easier to interact with the DB.
- See if it does.


2. Gen the data from the golang structs, and then output to FS.
- see: data/sayboras__zds
	- see make file
- this is really useful, because it allows us to gen test data, that you can then feed into the system.
	- it quickly gives a dev real data to code against
	- it loads up the GUI
	- It gives the biz people JSON examples to create real JSON files that the mod-admin can use to bootstrap the system.


3. Gen CLI 
- see: cmd/NathanBaulch__protoc-gen-cobra
	- see make file
- this generate corba cli to allow you to test the GRPC Server
