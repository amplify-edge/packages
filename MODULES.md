# Modules

## Intro

The Modular architecture allows composition.

The following explains how that is used.


## Status

STABLE. Looks like its enough for V2 and Vxxx going forward.

**NOTE: We are at V2 development stage !!!**


## Trade Offs

- Resiliency by isolation at the Flutter GUI Layer.
	- Each GUI runs in its own Browser Tab / App, and the modules have very complex code that breaks easily.

- Security can be hardened for Sys-main.
	- IP whitelisting etc if needed.

- Easier for developers.
	-  SYS and MOD Modules are cleanly isolated at DEV and RUNTIME.

- Different branding and GUI complexity for each.
	- SuperAdmin and Ops get a GUI 100% DIFFERENT from Org Admin & Users.

- Testing is easier.

- Relies on good build tooling though.
	- bs-box and boilerplates help this.

- Configuration isolation
	- Easier configuration management
	- More secure.

- Allows easier scale out with no code changes.


## Physical Topology

Note: See the [DEPLOYMENT.md](https://github.com/getcouragenow/packages/tree/master/DEPLOYMENT.md) for information on deploying the system.

For V2, it's all a single binary:

- Sys code and Mod code is together with a single DB.
- Mod code calling Sys uses Golang, and so Mod code must in Golang.
- Sys code does security checks on the calls from Mod code, to prevent Mod code accessing data it should not.

For V3, it's 2 binaries:

- Sys code is the PAAS with its own DB, and Mod code is the SAAS with its own DB.
- Mod code calling Sys uses GRPC, and so Mod code can be in any language.
- Sys code does security checks on the calls from Mod code, to prevent Mod code accessing data it should not.

For V4, its numerous binaries.

- One per Module. The Modules are effectively running of each other.
- Each binary type is a sharded DB. This allows scaling by sharding the Compute between Servers.

For V5, its numerous binaries and each instance is linked via RAFT.

- Each binary type is a sharded DB. This allows scaling as before.
- Each binary instance of the same type is linked to the others via RAFT. This allows Fault tolerance / HA.
- We have a LoadBalancer and Discovery Services.

So the Security Auth and Authz in Sys code must be done at the Golang level and not at GRPC level. Then it all works for all versions.


## Design

This shows the import dependencies chain.

**V1**

MainTemplate was used for V1, and is using K8 and all that complex stuff we do not want.

**V2**
MainTemplate2 is the new Entry Point for V2.

mod-main is now mod-disco.


### Domains

**V2**

We don't isolate the domains.

Domain: www.example.com

- Used by SuperAdmin and Ops
- Used by Org Admin & Users

**V3 and beyond**

We isolate the domains.

Domain: sys-main.example.com

- Used by SuperAdmin and Ops

Domain: mod-main.example.com

- Used by Org Admin & Users

## Server

Important:

- JWT needs to be designed to work across many Domains to support V3 from the start.
- Wildcard TLS and CORS to be designed to work across many Domains to support V3 from the start.
- All Security Auth and AuthZ checks occur in sys-core golang code and nowhere else.
- We always compile all the Modules, so that the build process is idempotent, so that we never miss a bug.

Modular Config:

- Use the Modular Config override mechanism to turn on the Modules we need. No Override results in no Modules being loaded.

**V2**

There is 1 binary:

- MainTemplate2

Services:

- HTTP Services
	- Single HTTP Server, with wildcard TLS and CORS.
	- Serves Sys-main Flutter Web GUI, which is made up of its Flutter sub modules.
	- Serves Mod-main Flutter Web GUI, which is made up of its Flutter sub modules.
- GRPC Services
	- Single GRPC Server, with wildcard TLS and CORS.
	- Serves Mod-main GRPC Service, which is made up of its Golang sub modules.
		- Called by Sys-Main Golang CLI and Flutter Web GUI.

**V3 and onwards**

There are 2 binaries:

- MainTemplate2 which only runs the mod code.

- SysTemplate which only runs the sys code.

 MainTemplate2 Services:

- HTTP Services
	- Single HTTP Server, with wildcard TLS and CORS.
		- Serves Sys-main Flutter Web GUI, which is made up of its Flutter sub modules.
		- Serves Mod-main Flutter Web GUI, which is made up of its Flutter sub modules.
- GRPC Services
	- Single GRPC Server, with wildcard TLS and CORS.
	- Serves Mod-main GRPC Service, which is made up of its Golang sub modules.
		- Called by Sys-Main Golang CLI and Flutter Web GUI.

SysTemplate Services:

- HTTP Services
	- Single HTTP Server, with wildcard TLS and CORS.
		- Serves Sys-main Flutter Web GUI, which is made up of its Flutter sub modules.
		- Serves Mod-main Flutter Web GUI, which is made up of its Flutter sub modules.
- GRPC Services
	- Single GRPC Server, with wildcard TLS and CORS.
	- Serves Mod-main GRPC Service, which is made up of its Golang sub modules.
		- Called by Sys-Main Golang CLI and Flutter Web GUI.






N: 
Services:

- HTTP Services
	- Single HTTP Server, with wildcard TLS and CORS.
	- Serves Sys-main Flutter Web GUI, which is made up of its Flutter sub modules.
	- Serves Mod-main Flutter Web GUI, which is made up of its Flutter sub modules.
- GRPC Services
	- Single GRPC Server, with wildcard TLS and CORS.
	- Serves Mod-main GRPC Service, which is made up of its Golang sub modules.
		- Called by Sys-Main Golang CLI and Flutter Web GUI.

## Clients

These communicate to their respective GRPC Services, to provide the required Remote management tooling.

Security is enforced at the GRPC Services layer.

## Flutter Clients ( Web, Desktop, Mobile )

**v2**

Mod-main Flutter imports ...

- Mod-main Flutter GRPC Client to communicate to the Mod-main Golang GRPC Service and its imports ( mod-*, sys-*, etc etc).

**v3**

Sys-main Flutter imports ...

- Sys-main Flutter GRPC Client to communicate to the Sys-main Golang GRPC Service and its imports ( sys-*, etc etc).

Mod-main Flutter imports ...

- Mod-main Flutter GRPC Client to communicate to the Mod-main Golang GRPC Service and its imports ( mod-*, sys-*, etc etc).

## Golang Clients ( CLI )

**v2**

Mod-main Golang imports ...

- Mod-main Golang GRPC Client to communicate to the Mod-main Golang GRPC Service and its imports ( mod-*, sys-*, etc etc).

**v3**

Sys-main Golang imports ...

- Sys-main Golang GRPC Client to communicate to the Sys-main Golang GRPC Service and its imports ( sys-*, etc etc).

Mod-main Golang imports ...

- Mod-main Golang GRPC Client to communicate to the Mod-main Golang GRPC Service and its imports ( mod-*, sys-*, etc etc).


### HTTP Services

Just Serves the Flutter Web GUI.

Maintemplate2 Golang imports...

- Sys-core
	- Golang to serve the:
		- Sys-main Flutter PWA ( Simple GUI )
			- has security hardening as needed, like ip whitelisting etc.
		- MainTemplate2 Flutter PWA ( Complex GUI )
		
### GRPC Services

Just Serves the Flutter GRPC ( for the Flutter PWA ) & Golang GRPC ( for the CLI ).

A single GRPC Service, so that Genji has one caller.

Maintemplate2 golang imports...

Sys-main Service imports:

- Sys-core
	- Golang

- Sys-account  
	- Golang

- Sys-timespace
	- Golang

- Sys-*, etc
	- Golang

Mod-Main Service imports:

- Mod-core
	- Flutter
		- Has the special responsive stuff and lang stuff. It imports the sys-core GRPC / GO
	- Golang
		- Basic Golang for this Module. It imports the sys-account GRPC / Golang

- Mod-account
	- Flutter
		- Can have extra widgets and domain and use Meta fields. It imports the sys-account GRPC / GO
	- Golang
		- Basic Golang for this Module. It imports the sys-account GRPC / Golang

- Mod-timespace
	- Flutter
		- Can have extra widgets and domain models and use Meta fields. It imports the sys-timespace GRPC / GO
	- Golang
		- Basic Golang for this Module. It imports the sys-account GRPC / Golang

- Mod-Disco (was mod-main)
	- This module is for Discovering Orgs, and their Projects.
		- Each Org and each of their Projects has a simple questionnaire.
	- FLU and GO with its own Table Namespace.

- Mod-*, etc etc
	- Other Modules by the Community.
	- FLU and GO with its own Table Namespace.
	- May import sys-account and sys-timespace Golang client.
