# GRPC tools


Its important to install the grpc tools this way because you need to control the versions.

```make make grpc-all```

- takes a while i know.
- once this settles down, can move move to bootstrap folder and call "grpc.mk", and so CI and devs can us it.


# general info

Also when designing your protobufs follow these basic rules !
https://medium.com/@akhaku/protobuf-definition-best-practices-87f281576f31

https://github.com/deromask/dero-gui/tree/master/protos
- small and concise encapsulatin
