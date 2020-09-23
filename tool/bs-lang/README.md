# lang tool

An approach to lang and i10l that is decoupled so that it can be used by any projects or architecture.

Its very simple.

It can be used by any language since it is JSON data and the key is a template like a mustache style. You can change the template format in the Google Spreadsheet to suit your underlying Application framework ( python, dart, ruby, etc)

The system can do normal lang aspects, but supports custom templates which are vital such corner cases as:

Gender

| Key        | Fr           | En           | 
|-------------|-------------|-------------- | 
|`templated.contact(Gender.male)`| M. {{last_name}} | Mr {{last_name}}
|`templated.contact(Gender.female)`| Mme {{last_name}} | Mrs {{last_name}}




Pluralisation

| Key        | Fr           | En           | 
|-------------|-------------|-------------- | 
|`plurals.man(Plural.zero)`| hommes | man
|`plurals.man(Plural.one)`| Mme {{last_name}} | Mrs {{last_name}}


## How it works:

`lang gsheet <flag>`

1. You should have a file `config/langconfig.yml` in the location where you run the lang tool.
2. see example [here](https://github.com/Winwisly100/bootstrap/blob/master/tool/lang/config/langconfig.yml)
3. The extension field can have handel `.json`, `.arb` or `.toml`
4. Run ./lang gsheet -option=lang

`lang flutter <flag>`


1. Generate full json files from an arb template file, example:
`lang flutter --dir examples --template examples/intl.arb --prefix stock --languages en,fr,es,de -f`

2. then to generate arb files from all json files already generated run:
`lang flutter --dir examples`

Or

1. Generate json minnimum files from an arb template file, example:
`lang flutter --dir examples --template examples/intl.arb --prefix stock --languages en,fr,es,de`
2. then to generate full arb files from all json files already generated run:
`lang flutter --dir examples -f`


## Status

The API and data format will change as we are extending it currently.


## Use Cases

It is used for the following use cases:

Making Test data for your apps or servers.
- We use it as an asset in Flutter for Mock data.

Making I18n data for your GUI.
- We use it together with  Dart annotators to read the JSON and gen the dart code.

Making static content like markdown for your website.
- We use it for  Hugo static sites.
- Just need to script the parsing of the JSON and placing of the markdown directly into the lang folders. Then you site is localised.

## Using

Its a single binary on your laptop Or in CI.

1. Copy one of the Test Google Sheets to your project. See the Test URLS.

3. Add the languages you want by column. ( Language codes: https://cloud.google.com/translate/docs/languages )

3. Open your google sheet: File -> Publish to the web -> "Sheet name" option and "csv" option

4. Then update the gsheet config in your repo with the correct ULRS to your Google Sheet and published CSV.

5. Then run the gsheet tool in the terminal. This will give you the data as JSON with a JSON file per language. 

## Roadmap

### Decouple from google

Its not hard coupled to google. It uses Google sheets ( and its inherent google translate ) at the moment only for convenience. Its designed to be able to use anything for display, storage and machine translation.

- Its important that there is a GUI like google sheets so the cognitive load is as low as pssible.
	- So make a self hosted equivalent. There are various ones out there and we only need a basic table structure
- Machine translation
	- The server can use the various third party ones out there. Easy to do.
	- Reactive. Google Sheets are reactive in that when you change the source text all the secondary languages up date in real time in front of you.
		- SO with our own Server we can do the same with a websocket / GRPC style approach.
- Export
	- This is easy because the data is on our own server.
- Versions
	- Google Sheets has versioning.
	- We can match that easily by using a Key Value store for our own implementation with a sequence counter, which is just like a git hash.
	- Users can then go forward or back in time to the version then want in the Sheet GUI but also from the CLI.
- HA
	- Google gives you High availability for free.
	- We can use a 3 node Master / Follower pattern using RAFT replication so that data is on 3 servers always.
		- If the Master falls over the other 2 hold an election to elect a new Master. No data is lost and there is no loss of data or reactivity for the users.
- CLI
	- Does not change except it calls out server instead of the google server.


### Human Override

Allow humans to override the Machine Translations.

- Just add an extra column for every language.
- the CSV to JSON tool then just checks if there is an override and uses the override.

### Providence

This allows you from the end produce application or web site where the translation came from.

- During export we record the row and col each bit of text comes from and put it into the JSON.
- Then at runtime that data (row and col ) is used to point the developer back to the original source. Its just the original URLS with the range added: "/edit#gid=0&range=E8" added for google sheets ( https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0&range=E8 )
- When running in production env, it ignores the Providence of course, using environment flags.

Then there is the Providence in terms of the Version of the Google Sheet used.

- When exporting also get the Google Sheet Version number.
- This can then be embedded into the Web or App when compiled.



### Watch Mode

In debug mode, allow the data to update live when changed in the Google Sheet.
- runs in untyped mode
- Gsheets has trigger support. We tap into that via a hook server that then updates each developers running local system.
- this is 100% stateless. Its just a tap that is either ON or Off.


## URLS

Example URLS for config:

GOOGLE_SHEET_ID = 16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw

GOOGLE_SHEET_URL = https://docs.google.com/spreadsheets/d/$(GOOGLE_SHEET_ID)
GOOGLE_SHEET_URL (computed) = https://docs.google.com/spreadsheets/d/16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw/edit#gid=0

GOOGLE_SHEET_CSV = https://docs.google.com/spreadsheets/d/e/2PACX-1vTrndYJtszNP2_VL2t_z7wa03v2R01yq3wfRi4-RgmJMzXIEMzAX4OybZT7eEiqcmkZLWcFJhwJqJzA/pub?output=csv

