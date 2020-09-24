# tool

This holds the built tools we need.



## Status

Currently builds the things we need:

- Lang

- Hover

- Hugo



## Using

Install:

``` make this-build ```

``` make this-test ```

Using:

Then  ./boilerplate/tool.mk encapsulates the use of these tools, so invoke them from there always.

See the make file of each tool for example usage.







## Future

Downloading

https://github.com/hashicorp/go-getter

- Needed for CI and other aspects i think.

GRPC

https://github.com/fullstorydev/grpcui
- Uses protoreflect

https://github.com/rogchap/wombat
- uses golang QT, which suchs a bit.

DB For Admin aspects

Need a Flutter GUI to show the Tables and Data in genji.

https://pub.dev/packages/sqlview

- Uses SQLite currently

https://pub.dev/packages/json_table

- Allows tabbing between views so you can see many views at once.
- Allows live editing so Rosie can edit Data Loaders. 
	- Just need to save into DB, and then export to JSON 
	- Or save to Disk as JSON. 

https://github.com/leisim/logger

- Flutter Logger and a Console
- Include in sys-core so we can do debuggin off Serer
- Part of Ops ROute !