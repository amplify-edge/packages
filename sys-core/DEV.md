# dev notes

Syscore holds common client and server code

Accounts is the important one
The basic Authz data model is: User, Org, Project, Roles

Roles:
- Admin
- User

Types:
- Org
- Project

E.g.
- User A, is a member of Org 001, null, role: Admin
	- they are an Admin of that Org and create, edit, delete, etc Projects in it because they have Admin Role
	- they can see all the Projects and Users in that Org
	- they can grant Admin status of the Org to another User.
	- they can grant Admin status of a Project to another User.
- User C, is a member of Org 001, Proj 001, role: Admin
	- they are an Admin of that Orgs project. 
	- they can edit the project data and users of the project.
- User B, is a member of Org 001, Proj 001, role: User
	- they are a User of that Orgs project. So essentially enrolled into that project

So in mod-main, what is returned from calls to the Server and what Routes you can access is determined by the Accounts system.
In mod-chat, later, it is of course used also.

mod-admin
- this is a special global module to see all the Auth and Authz data.
- we need it so we can check things are working ok. The GUI does not need to be pretty at all.
- is a hardcoded username, password of the system that is forced to be changed on install.

mod-accounts
- maybe not needed


