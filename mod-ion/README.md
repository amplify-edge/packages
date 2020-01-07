# mod-ion

ION and CloudWebrtc are a powerful Pub Sub system.

It allows us to do:

- Signup of users and sessions
- Video conferencing
- Multi party video conferencing ( using the Server as a relay)
- Data Publish and Subscribe

The Frontend is Flutter

- use the CloudWebRTC Project code.
- See that folder in this repo for more info



The backend is golang 

- Uses the Ion Project code.

- See that folder for its capabilities

# runtime folder

There are 2 ways to run flutter:

- go-flutter

- google-flutter

go-flutter is what we prefer but at this time it cannot run CloudWebRTC due to the Cpp / CGO aspects. We are in discussions about porting it with @CloudWebrtc

google-flutter is not what we prefer but can run CloudWebRTC on a mac. 

## Try folder

Just a dumping groudn for experiments.

## Getting started

Get google-flutter-desktop running off the make file. worked a month ago.
- Works on my MAC BTW...

Get cloudwebrtc running. Start with flutter-webrtc
- ios sim works on my mac very well.
- android real works and can call the IOS sim.
- mac does not work. POD file missing despite the flu-fix working for mobile.. Weird it used to work :()


## Google Desktop

Mac os needs to copy the Runner project from flutter-desktop-embedding to create a demo.
https://github.com/flutter-webrtc/libwebrtc/releases

