# Security


The Architecture is designed to be an End to End secure system.

See the [sys-core](https://github.com/getcouragenow/packages/tree/master/sys-core) for the code and domain model and the roles and permissions.


## Modules

Each Module needs security to be applied.

### Client

For client security, all data is gotten from the server/sys-core and enforced by the client/sys-core code.

Routing guards enforce what the user can route to and is enforced by sys-core.

Navigation GUI guards enforce what the user sees is enforced by sys-core.

With regards RTC ( like chat), access and functions that a client can perform is enforced by sys-core.

### Server

Each Module uses GRPC and so Auth and Authz is enforced automatically by the GRPC middleware that sys-core loads.

Each Module owns the DB tablespace it uses, and the sys-core enforces that they can only acces their tables. This means that a third party module can not access another Modules data.

At the DB query layer, the domain model describes the Authz permissions and is enforced by sys-core.

---

## Security Architecture

All security aspects are enforced in sys-core to remediate developers accidentally making mistakes.

The layer cake of the End to End looks like this.

Client

- Generates it own private key and gives the public key to the Server.
- Public key stored in Server ( gateway )

DNS

- DNS inspection can be reduced if the users use an Encrypted DNS, and they are becoming more and more common.
- We do not want to introduce Wireguard VPN as it tends to expose the user to the WebRTC leak hack.
	- Tailscale was a Wireguard Server and client that circumvents the WebRTC leak, but we really prefer standard Encrypted DNS mainstream and aim to develop in that vein.

Transport

- Uses TLS 1.3 with Certs auto issued by Lets Encrypt.
- Client and Server checks the TLS Certificate.

Server 

- State is encrypted in the DB
- Master key stored in TPM chips via OS keychain.
- Keys rotation.


### High Level Security Roadmap

**V2**

Only single server and RPC.

TLS
- Auto Certs

Server
- DB is encrypted, ensuring that Admins runnng the system cannot see he data.

**V3**

Many Servers sharded and Client doing small amount of RTC.

Client

- Private key and Public key introduced because we start to use RTC ( eg Chat )

Server

- Global Registry Server introduced will be needed to hold DB master keys, Transport certs, Client Pub keys
- MTL Certs used between Global Registry Server and Servers.

**v4**

we will be running many instances of each golang MOD as their own Servers

No real changes needed.
