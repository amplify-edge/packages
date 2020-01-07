# dev

Running notepad ....

## status

Web
- works well and easy 

IOS
- pod install issues

AND
- works well
- forces and SDK 28 install. 

## BASIC TODO

- Server - Get NodesJs containerised and run on google cloud
	- OR try ion




Flutter GUI
https://github.com/cloudwebrtc/flutter-webrtc
https://github.com/cloudwebrtc/flutter-webrtc-demo
- Requires Google Flutter Desktop

SIP and Asterisk
https://github.com/cloudwebrtc/dart-sip-ua
Golang Asterisk REST Interface (ARI) library
https://github.com/CyCoreSystems/ari
https://www.voip-info.org/asterisk

SIP and kamailio
https://github.com/kamailio
Golang API: https://github.com/CyCoreSystems/kamconfig



Support: https://gitter.im/flutter-webrtc/Lobby


Web Demo ( live)
https://demo.cloudwebrtc.com:8086/
Issue: https://github.com/cloudwebrtc/flutter-webrtc/issues/85
PR: https://github.com/cloudwebrtc/flutter-webrtc/pull/120
- looks like its almost there.
- use the correct branch


Google Desktop
https://github.com/cloudwebrtc/flutter-webrtc/issues/37


Dart-SIP-UA
https://github.com/cloudwebrtc/dart-sip-ua/issues/4


Server
https://github.com/cloudwebrtc/flutter-webrtc-server
Yes,If you only need P2P communication, a nodejs server + turn server is enough.
If it is a video conference, live broadcast, you need an SFU, such as mediasoup, ion, etc.
In fact, flutter-webrtc can also use the sip protocol with the sip server, using dart-sip-ua.
https://github.com/cloudwebrtc/dart-sip-ua



Core lib for Flutter
https://github.com/cloudwebrtc/flutter-webrtc


Blockers: https://github.com/cloudwebrtc/flutter-webrtc/issues/37
- waiting for Texture and GLFW and GLAD support to land.