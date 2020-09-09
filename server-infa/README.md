# Server

This is the design of the Infra.

Its designed to easily support running everything on a laptop up to a large cluster.

## Modes

**Single mode**

### <a name="singlemode"></a>A Heading in this SO entry!

- Used on Premise generally where low load and can restart if hardware fails.

**HA mode**

- Used on Premise generally where low load and manual failover.

**HA and Scaled mode**

- Used on Premise or in Cloud generally where you want operational simplicity, scaling and manual failover.

**HA and Scaled k3d mode**

- Used on Premise or Google Cloud servers where you need to scale up and down quickly and automatic failover.

## Foundation

All the golang code is compiled as single binary always.

When the binary starts, the conf tells it what Services to run. If not told it must fail to start, to ensure no mistakes.

Each Service has its own table namespace it uses.

Ingress Routing is always the same.

Auth & Authz done in golang always.

[Take me there](#there_you_go)

[Take me where](#here)


## Single mode

<a name="there_you_go"></a>Take me there

1 Sever in same DC.

The server runs a single binary, configured as all Services, with a single DB.

## HA mode

<a name="here"></a>Take me where

3 Servers in same DC.

Each Server runs a single binary, configured as all Services, with a single DB distributed with failover.

This gets you the same scale with automatic failover.

Ingress
-  Manual. Fixed DNS

DISCO
- Manual. Fixed IP

DB
- Uses flamed to distribute the data.


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


## k3d mode

Many Servers in same DC.

Each Server runs a single binary, configured as a specific Service, with DB distributed with failover.

This gets you scale out with automatic failover.

Uses k3d and Envoy ( and its XSD).
- Can scale up and down dynamically using the kubectl
- Can run on google or own servers. If on own servers must manually bootstrap.
- Disco handles by Envoy XDS
- LB handled by Envoy GRPC LB.
- Ingress handled by Envoy
