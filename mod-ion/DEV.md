# dev


This is just a running stream of notes that we keep..... 
Its not that organised and more like a quick a dirty notepad

This is built on desktop using the Google Flutter embedded system
- From the flutter app it will open the the video conf app, passing any params needed


## go-flutter approach


Video on Desktop
https://github.com/go-flutter-desktop/examples/tree/master/texture_tutorial
- shows it posible

CGO calls on Desktop, so we can call Webrtc engien:
https://github.com/go-flutter-desktop/go-flutter/issues/296

Dart FFI call on desktop.




https://github.com/cdnbye/flutter-p2p-engine
- plugins: 
	- ios: https://github.com/cdnbye/ios-p2p-engine
	- and: https://github.com/cdnbye/android-p2p-engine


https://github.com/instrumentisto/medea
- rust
- web gui only
- media server supporting 3 way conferencing
- this approach relies on a Webview for each Target of course.


MediaSoup / Jitsu golang wrapper
https://github.com/murillo128
- main dev 

https://github.com/jitsi/jitsi-videobridge
- Its does nto sue a server to MIX all the channels togehter, but insetad send them to P2P to everyone.

https://github.com/medooze/media-server
https://github.com/notedit/media-server-go
https://github.com/notedit/media-server-go-demo
- wraps the c code
https://github.com/notedit/rtclive/blob/master/go.mod
- uses media-server-go
- he is also changing to gstreamer


# Foreground / Background approach

https://github.com/rwrz/flutter-webrtc

Background does all Webrtc using pion and gomobile.


https://github.com/poi5305/go-yuv2webRTC
- 




