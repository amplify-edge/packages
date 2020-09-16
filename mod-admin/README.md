# main Admin

This is for a normal user that is of Admin role. Its designed for them to control the Users,  Data and Upgrades.

This is embedded into the maintemplate !

This can be running on a local desktop or a remote server.

This is built with Flutter

Main route /admin
Guarded by only allowing the user with Role Admin to get here !!

## Architecture

Needs a cron job to run it.


## Features

On every route change it checks if the Default password has been changed and takes user to /setup if not changed yet.
- The default password for Admin is set i the Code.

Below are the sub routes.

/ setup
- walks through setting up..
- change admin password in the DB.

/ users
- search, master page list, details page
- Search Filters:
	- email address.
- Master Page
	- email
- Detail
	- email
	- whatever else is in the GUI of (mod-account currently)

- Comamnds: master pages allows creating new
- Commands: details page allows editing them 

/ audit
- Allows user to see when user sessions occured over time.

## Data

This is for bootstrapping, backup and restore

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
			- Only Click to open Master
			- New ( only for Remote )
	- Detail
		- Name, Description

- backup
	- Search, List, Master pattern.
	- set schedule and location
	- location options are:
		- Local file system
		- Remote asks for an S3 endpoint with auth details
- restore
	- local just asks for a file to load via upload
	- remote gives 2 options:
		- lists existing backup saved in system, and asks to choose one
		- new remote S3 endpoint.
- audit
	- Allows to see when bootstraps, backups and restored occurs over time.

## Upgrade

This is to manage upgrades.

Route: / upgrade

- Settings
	- Automatic checkbox.
	- Download when a new upgrade is available checkbox.
- New Upgrade
	- User is taken here automatically via a Notification or Email whenever the system cron job.
