# Architecture for chat

chat use grpc and jetstream and nats to pub/sub.

protofile: server/grpc-web/pkg/proto/v3.proto

- Client should make request to register and provide username and deviceID.
- Users can have many devices.
- Server use username and the deviceID as a keys for push a message to the right users.
- The client should send a message with the informations:
    - from_user.
    - to_user.
    - text.
    - deviceID
