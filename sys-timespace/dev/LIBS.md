# DEV

mod-timespace exists, but we should do the functionality at the sys level, because sys needs the data functionality of time space.

For example, it needs to do date and time conversions for its own things.

It maybe that sys-timespace only is a Data layer with an API, and then modules use it as they see it.
- for V2 this makes sense, because then we can continue using mod-timespace.

## DATA 

https://github.com/mledoze/countries
- The actual data is here: https://github.com/mledoze/countries/tree/master/dist
- Its also has flags in 
- Name
- Currency
- Telephone calling code
- Region, Sub Region and Language
- Langs but only a few.

https://github.com/dr5hn/countries-states-cities-database
- has country --> State --> City 
- YAML or JSON or CSV
- DEMO: https://dr5hn.github.io/countries-states-cities-database/
- Final City has:
{
  "id": 24055,
  "name": "Berlin Treptow",
  "state_id": 3010,
  "state_code": "BE",
  "country_id": 82,
  "country_code": "DE",
  "latitude": "52.49376000",
  "longitude": "13.44469000"
}
- SO this would be the FK uses by a Module !



## Golang Geo location Server:

- Geo search and reactive updates
- Hooks for integration into our NATS Message queue
	- https://github.com/tidwall/tile38/pull/504
		- NATS hooks is perfect as we can run our NATS cluster and integrate tidwall as a microservice.
	- But also has GRPC and other endpoint integration: https://github.com/tidwall/tile38/tree/master/internal/endpoint
		- These are sends from tile38 to others but easy to add sends the other way around


### Redis Client OR golang wrapper clent ?

- Redis for dart 👍 https://redis.io/clients#dart

- If we embed golang inside flutter we dont need this and just use a golang redis client.
	- The tile38 cli is really nice too with very clear API etc.
	- 


## Flutter maps GUI
- integrate tile38 this map gui for real time updates.
https://github.com/johnpryan/flutter_map

- this one looks pretty good
- We just have to replace the calls to https://api.tiles.mapbox.com/v4/ with calls to the golang maps sever ( below )  
	- SO then we can provide maps but NOT leak users to any third party :)

Linking: https://pub.dev/packages/map_launcher
- really awesome. We can add our map app as another URL scheme for Mobile and desktop.

Image cache and pan and editing: https://github.com/mattermoran/extended_image
- pure dart and will handle alot of corner cases for MAPS but also DOC and CHAT module
- Might not need this as we already have one now.


## Maps Server

SO we are 100% independent from Google maps etc we can run our own mapping tile server.

Our server is a cache calling out to the open providers.

Server
https://github.com/whosonfirst/go-rasterzen

Issue about API: https://github.com/whosonfirst/go-rasterzen/issues/21
