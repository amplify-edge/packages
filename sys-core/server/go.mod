module github.com/getcouragenow/packages/sys-core/server

go 1.14

replace github.com/getcouragenow/packages/sys-accounts => ../../sys-account/server

require (
	github.com/dgraph-io/badger/v2 v2.2007.2
	github.com/genjidb/genji v0.7.1
	github.com/genjidb/genji/engine/badgerengine v0.7.1
	github.com/getcouragenow/packages/sys-accounts v0.0.0-00010101000000-000000000000
	github.com/segmentio/ksuid v1.0.3
)
