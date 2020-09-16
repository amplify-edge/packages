# DEV

He uses only protobufs and not GRPC, which is correct way to do it, as its now transport agnostic.

## TODO

Need to make a full example

- Make a GRPC that uses his Protobuf
- Gen the Golang GRPC
- Gen the Flutter GRPC
- Make a Golang Server
- Make a Golang client
	- Try to use CMD gen
- Make a Flutter client

- He has "db" tags in the Protoful, which are useful, but can we use that with Genji ? 

## Examples

https://github.com/scottshotgg/zeigarnik
- very nice, but no grpc

https://github.com/ekhabarov/talks/tree/master/struct-transformer/samples
- his own samples that work on top of his examle