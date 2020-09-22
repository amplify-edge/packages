# Deployment Modes

The various deployment options allow for  a single server up to multiple servers with automatic scaling and failover.

This allows running everything on a laptop up to a large global cluster of servers.

## Modes

**[Single mode](#single-mode)**

- Used on Premise.
- When you have low load, and do not need any HA.
- No admin skills required.

**[HA mode](#ha-mode)**

- Used on Premise.
- When you have low load, but want basic HA so that a server failure is easy to recover from manually.
- Basic admin skills needed.

**[HA and scaled mode](#ha-scaled-mode)**

- Used on Premise or Cloud.
- When you have high load, but want basic HA so that a server failure is easy to recover from manually.
- Basic admin skills needed.

**[Kubernetes mode](#kubernetes-mode)**

- Used on Premise or Cloud servers.
- When you have very high & dynamic load, and want automated failover.
- Basic kubernetes admin skills needs.

## Design

All the golang code is compiled as single binary always.

When the binary starts, the configuration tells it what Services to run. If not told what Services to run it must fail to start, to ensure no accidental data corruption..

Each Service always has its own DB namespace it uses.

Ingress Routing is always the same.

Auth & Authz is always done in golang.

TLS Certs is always managed in golang.

<a name="single-mode"></a>

## Single mode

1 Sever in 1 DC.

The server runs a single binary, configured as all Services, with a single DB.

DNS Ingress
-  Manual. Fixed DNS settings.

Configuration
- None

<a name="ha-mode"></a>

## HA mode

3 Servers in 1 DC.

Each Server runs a single binary, configured as all Services, with a single DB running in replication mode.

This gets you the same scale with automatic failover.

DNS Ingress

- Manual. Fixed DNS settings.

Configuration

- Manual. Fixed DNS settings to tell servers about each other.


<a name="ha-scaled-mode"></a>

## HA and Scaled mode

9 Servers in same DC, for example.

Each Server runs a single binary, configured as a specific Service, with DB distributed with failover.

This gets you more scale out with automatic failover.
 
DISCO:
- None. All manual 

DB:
- Uses flamed to distribute the data
- IP addresses of followers and master are hardcoded. No SPOF.

LB:
- Needed


<a name="kubernetes-mode"></a>

## Kubernetes mode

Many Servers in 1 DC.

Each Server runs a single binary, configured as a specific Service, with DB distributed with failover.

This gets you scale out with automatic failover.

Uses k3d and Envoy (and its XSD functionality).
- Can deploy and scale up or down dynamically using the kubectl cli.
- Can run on google, aws, azure or own servers. If on own servers must manually bootstrap k3d.
- Disco handles by Envoy XDS
- LB handled by Envoy GRPC LB.
- Ingress handled by Envoy
