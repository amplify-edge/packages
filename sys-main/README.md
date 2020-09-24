 # sys-main

 



## Archi

Use go-Generate for flu and go
ex: https://github.com/ctessum/cityaq/blob/master/gendoc.go

DO we embed is the real question ?



Code Rule

- All golang only dependent on sys, so we dont get cyclic dependency shit.
- All flutter only dependent on sys, so we dont get cyclic dependency shit.


Data Rule

- Data Loader per Module ( sys-core calls each module's Data Loader), which handles.
	- Syscore just tells it the global Data suite and the global data version of the DB.
	- The Data loading from Test data into the DB.
	- The Data Migration.
	- Database version exists in DB. It has nothing to do with the Golang version.
	- Below we just us a sequence going up.

```

1_initialize_schema.down.sql
1_initialize_schema.up.sql
2_add_table.down.sql
2_add_table.up.sql

```

- Maybe later
	- Loader must ask for the PK ( UUID ) for any sub data dependencies.

---

Design time

- can manually call generator
- manual make config files
	- manually copy them up to the main entry point
	- Date Suite can be in Override config file
- run example...

---

Build time

Main does NOT need manually call down into its subs, because its all done by go:generate recursively.

- grpc gen
- data gen
- lang gen

- Who does the embed ? Need to check / test it

---

Run Time
Main is told via config or ENV Assets suite to load.

- sys-core does the work
- reflects on embedded assets and processes them.
- config is NOT embedded
- GRPC - nothing to do.
- data schema is loaded ( and migrations run against version )
- data is bulk inserted into DB
- lang is ?

## Non example

this-build.


flu
- lang

go
- Lang
- Config
- Data & Schema Migration

## Example

Is being maintemplate :)
- Mod-main is a perfect example of the code to use.!!!

this-example-build
- go and flu

this-example-build
- go and flu
