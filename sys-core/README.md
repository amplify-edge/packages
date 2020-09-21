# Sys Core 

Its designed for them to control the Users, Data and Upgrades.

This can be running on a local desktop or a remote server.

This is built with Flutter.

Main route: /sys

Guarded by only allowing the user with SuperAdmin to get here !!

## Accounts

On every route change it checks if the Default password has been changed and takes user to /setup if not changed yet.
- The default password for Admin is set in the Code.
- The account email, password is "superadmin", "superadmin" hardcoded into the code, and when first installed forces the user to setup a real email, password.

Sub route: /accounts

Below are the sub routes.

/ setup
- walks through setting up..
- change superadmin password in the DB LIKE OTHER USERS.

/ users
- search, master page list, details page
- Search Filters:
	- email address.
- Master Page
	- email
	- ..
- Detail
	- email
	- whatever else is in the GUI of (mod-account currently)

- Comamnds: master pages allows creating new
- Commands: details page allows editing them

/ audit
- Allows user to see when user sessions occured over time.

## Data

This is for data bootstrapping, backup and restore

route: /data

- bootstrap
	- For loading a data set into the system.
		- Assume for now ONLY complete, and so deletes existing DB ( except for current user that is admin)
	- Search, Master, Detail pattern.
	- Search
		- Filters
			- Local
			- Remote S3 (from config or past usage)
	- Master
		- Name, Local or Remote
		- Actions
			- ..
	- Detail
		- Name, Description

- backup
	- Search, List, Master pattern.
	- set schedule and location
	- location options are:
		- Local file system
		- Remote asks for an S3 endpoint with auth details

- restore
	- gives 2 options:
		- lists existing backup saved in system (local or remote), and asks to choose one.
		- new local or remote S3 endpoint.
	- local just asks for a file to load via upload.
	

- audit
	- Allows to see when bootstraps, backups and restored occurs over time.

## Upgrade

This is to manage upgrades.

Route: /upgrade

- Settings
	- Automatic checkbox.
	- Download when a new upgrade is available checkbox.
- New Upgrade
	- User is taken here automatically via a Notification or Email to let them knwo to come to this page.
	- assumes a golang cron job.
