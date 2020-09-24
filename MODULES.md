# Modules

## Intro

The Modular architecture allows composition so that we can divide the Dev, Test and Runtime as we need.

**Domains**

sys-main.domain.com

- Used by SuperAdmin and Ops

main-template.domain.com

- Used by Org Admin & Users

**Why ?**

- Resiliency by isolation at the Flutter Layer.
	- Each GUI runs in its own Browser Tab / App.
	- Makes SYS and MOD cleanly isolated at DEV and RUNTIME in the right way.
- Different branding and GUI complexity for each.
	- SuperAdmin and Ops get a GUI 100% DIFFERENT from Org Admin & Users
- Testing is easier.
	- Check flutter_riverpod (https://pub.dev/packages/flutter_riverpod)
		- EX: https://github.com/flutterdata/flutter_data_setup_app/blob/master/pubspec.yaml
		- Not to V2.
- Relies on good build tooling though.

## Design

This shows the import dependencies chain.

### Processes

- Single Server ( just like now )
	- HTTP Services
		- Serves both Flutter Web GUI's on each domain.
	- GRPC Services
		- Severs the GRPC Endpoint for the both CLI's and Flutter GUI.
		- They both use the same GRPC Endpoint, but each domain has a different API.
	- NOTE : Both CORS and JWT need to work across both because the same SignIn mechanism is used.

### Web & CLI Clients

- Sys-main CLI & WEB imports:
	- sys-main GRPC API
- MainTemplate CLI & Web imports:
	- MainTemplate GRPC API

### GRPC Services

Sys-main Service imports:
- Sys-core
	- FLU (Simple GUI) and GO

- Sys-account  
	- FLU (Simple GUI) and GO

- Sys-timespace
	- FLU (Simple GUI) and GO

- Sys-*, etc
	- FLU (Simple GUI) and GO

MainTemplate Service imports:

- Mod-core
	- FLU
		- Has the special responsive stuff and lang stuff.
	- No Golang for this Module. It calls the sys-core GRPC

- Mod-account
	- FLU
		- Can have extra widgets and domain and use Meta fields
	- No Golang for this Module. It calls the mod-account GRPC

- Mod-timespace.
	- FLU 
		- Can have extra widgets and domain and use Meta fields
	- No Golang for this Module. It calls the sys-timespace GRPC
- Mod-*, etc etc
	- FLU and GO
