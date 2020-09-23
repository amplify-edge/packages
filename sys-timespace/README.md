# sys-timespace

Used by many modules.

Provides all functionality related to:
- Space
	- Geographical aspects
- Time
	- time conversions

Examples:

- user can search for campaigns by location and see then on a map

- campaigner can see where all their volunteers are in real time.

- users can update their location in their profile.

- Project admin can update the project location.

## Client

The reusable widgets.

The Admin GUI that also uses the widgets. We need this to check our widgets works, and also to admin the data.

## Server

The golang API and functionality.

---

## GUI

We provide some Flutter Widgets for other Modules to use.

We also have our own Flutter GUI to be able to see the system is correct. These exercise those Flutter widgets

- Sub Route: /geo

- Get location by IP
	- Returns City and Country
	- Used to automatically return the users location.
	- Widget
		- Just returns the data
		- A dual drop down of Country and City where we pre-populate the selected values.

- Get Country & Get City by Country



## API

Modules (mod-*) are written in golang and so they can make a direct go call into us and so dont need to use GRPC.

GRPC is needed for our own GUI and for the Flutter Widgets we provide.

## DB

Will only need to store lookup data, that Modules can reference this lookup data when they store their own data.

For example mod-whatever needs to store X against a City and so uses the City ID as FK ( Foreign key) against the PK in the sys-geo City Table.

Will need to store the data against the LANG.
- We need a generic Lang DB lookup list too then i think.


## LANG

We need to present the data to the GUI in the language they use.

So all API's should have a lang context on them, so we can return the data in the GUI's language.

So the data pumped into the DB needs to be in many languages.
- We will use our lang tool to take a CSV and gen the data in many languages and then pump it in.
- We will need a cleaning tool for the DB
- We will need to have data migrations so we can upgrade deployed systems with new data.
