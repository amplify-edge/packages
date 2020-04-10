# mod_chat_beta

This is a Roadmap for the chat module. mod_chat is a stub for demos; this
is where new work should take place.

Features that need implementation:
- Real Time Typing
- Read Receipts
- Group IDs / Sender Names for every message

Where we need to implement them:

- [ ] Server Side
- [x] Protocol Buffers (un-compiled in Go)
- [x] Dart Models
- [ ] Flutter Frontend
- [ ] Hive Persistence

### Notes:
- Protocol buffers have to be compiled into Dart and Go code. They have been
compiled into Dart; they still need compilation for Go. View the source at
 `../server/api/service.proto`
- Only the most basic of Dart models is done. All the hard work (tying
boilerplate into flutter) is in progress. See models at 
`/lib/grpc_web_example/models/`
- The Message model has been retrofitted with group and sender IDs. This
is necessary for master-detail, but will probably break current code.
- Group IDs and Sender Names have been tied to chats individually; we need
the master pattern implementation.
- We'll need to structure Hive so it touches every level and acts as a sort
of cache. This will allow (limited) offline functionality.
