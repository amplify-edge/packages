# Packages

Flutter and Golang is used for the MicroServices and Clients.

You can write both in any language though.

Design the Golang MicroServices to support the 2 patterns of CQRS:
- READ
  - Load All (from Minio). A Read ALL.
  - Load catch ups (from LiftBridge), based on where you are in the catchup sequence.
- WRITE
  - Sent Mutation ( from client to server). Is always a CUD (Create, Update, Delete)

The system at the PASS level will then do this for you:
- Images
  - Send Mutation (CUD) → Minio →
  - Minio events to NATS.
  - LiftBridge sends a URL ( hash) to the Clients.
  - Clients pull the image and stores / caches it.
- Data
  - Send Mutation (CUD) → NATS →
  - WRITE SIDE: LiftBridge --> other devices
  - READ SIDE: Minio (add the extra line item) so its read for a Load ALL.
