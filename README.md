# Packages

This contains the Functional modules with:

- GUI
- Business Logic
- Data schema

The functional spec for each is here for now:

https://drive.google.com/drive/folders/1X0sMEOxYP_zoBVl_E0SbZs6MMfZlnvEs

In each folder there is:

- Flutter
- Makefile.

## Docs

Use the same structure as here for this repo, so its easy to publish and easy for others to use.

https://github.com/rodydavis/plugins

Its uses: https://github.com/flutter/plugin_tools



## IO

IO is GRPC to the embed golang layer running on the device.

See the embed repo.


## Modularity and IOC

Use the inside out approach so things dont get monolithic.


Also we want it to be easy for others to use a Module and compose it how they want with their app.
Flutter does not have Modular Routing yet but the following does the same:

https://pub.dev/packages/flutter_modular

Examples:

- https://github.com/Flutterando/github_search

- https://github.com/felipewom/flutter_app_modular

- https://github.com/VictorOchoaS/ToDo-App