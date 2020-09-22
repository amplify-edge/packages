# ops Main

This is for debugging, and NOT for Super Admin.

This is embedded into the maintemplate !

When a User Admin finds gets a report of an Issue, an Ops person can access this remotely to debug the problem.
Its also for Developers developing the system.

Because it uses the typical golang Telemetry tools that GRPC Middleware uses, The GUI cant be flutter based.
Its more just a URL route mapping into those golang tools.

There may be a way to make the nav FLutter and load the tools into Iframes.

Only works on web !

The user name and password is only set here.
- Not sure where we store it or maybe use a ssh key, which requires a special login.

route /ops

This can be running on a local desktop or a remote server.

## Features

See sub folders.
