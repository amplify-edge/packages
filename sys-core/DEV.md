# dev notes

Low level implementation notes for developers.

Syscore holds common client and server code.

## Accounts

Accounts is the important one.
The basic Authz data model is: User, Org, Project, Roles

Roles:
- Admin
- User
- SuperAdmin

Types:
- Org
- Project

E.g.
- User A, is a member of Org 001, null, role: Admin
	- they are an Admin of that Org and so can create, edit, delete, etc Projects in it because they have Admin Role
	- they can see all the Projects and Users in that Org
	- they can grant Admin role of the Org to another User.
	- they can grant Admin role of a Project in that org, to another User.
- User C, is a member of Org 001, Proj 001, role: Admin
	- they are an Admin of that Orgs project.
	- they can edit the project data and users of the project.
	- they can grant Admin role of the Project to another User.
- User B, is a member of Org 001, Proj 001, role: User
	- they are a User of that Orgs project. So essentially enrolled into that project, but cant do much.


Sys-core GUI
- routes: Setup, Upgrade (backups and restore)

sys-accounts GUI
**  mod-account code !!! to sys-accounts.
- SO all mods import sys-core and sys-accounts.
- routes: route/accounts 
- SO the SuperAdmin, OrgAdmin and ProjectAdmin can admin the users and their rights
- so its reusable based on the users that is currently using it. Multi-tenant concept.
- this is a  global module to see all the Auth and Authz data.
- route: /admin?org=001,Project=002, and then look at users authz jwt to check they can admin this path.
	- So superamdin can do it for ALL
	- so Org Admin only for their org
	- etc etc
- we need it so we can check Accounts are working ok. The GUI does not need to be pretty at all.


## Server Config

Sys-core loads it up from disk, and gives a pointer to the modules.

Each Module needs to have their own server config.
So in the config file he data is nested by Module name ( mod-x).

There will likely be a sys-core section in the config file of course also.
- CORS  (needed for v2 because will be running in iframe of Customers website)

## DB

SysCore loads it up, and gives a pointer out to other Modules.

Each Module needs to have their own DataBase Tables.
So they use the prefix "mod-X" to separate their tables from other modules.
Dont think we need sys-code to check that enforcement.

Migrations

Again each Module will have their own migration files that live in that module.
At build we should embed them.
The semver of the binary is the version number we use ? Not sure its smart to use that. Might be better to just use a sequence ?
- Decide Later. Check best practices.
- Syscore manages the migrations of course on behalf of the Modules.

## GRPC

https://github.com/mwitkow/go-proto-validators

middleware: https://github.com/grpc-ecosystem/go-grpc-middleware#middleware
- Like in README !

- Example
https://github.com/argoproj/argo-cd/blob/master/server/server.go


## Test Data

https://github.com/sayboras/zds
- Perfect. See 
