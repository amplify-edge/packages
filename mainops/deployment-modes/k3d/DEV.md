# GRPC LB

We need to run our Servers on Hertzner but also on Desktops / Laptops.

This code uses k3d with envoy and envoy XDS. The envoy XDS does the discovery and load balancing using GRPC.

It allows many client instances and many server instances to communicate over GRPC, scaling out the Servers and Clients thanks to Envoy XDS and LB functionality.

If we add more physical Servers the Envoy XDS ( and nginx) should pick it up. So then the Envoy XDS part needs to be running on a different physical server than the Golang Services.

We want to do slight adaptation to it to allow the Server to run on a Desktop also.

The following needs to be done and checked.

## CI.

Extend make file as you go and keep it simple.

You can do all development easily on your MAC. Do not worry about CI etc for now because we will probably use a Mac mini for all CI, and so it will use the same makefile for builds. This makes things much easier.

This will act as a model for how we will modify the main code.

---

## Flutter Client

Create a Flutter Client for each Service that uses GRPC and Test the LB on Web, Native (Desktop and Mob).

- The existing GRPC Services are fine.

- Check that push works on all platforms. I expect that when running many client instances on your desktop, that there will be issues because it does not know which client to push to. Device ID and Presence will fix that later, but do not worry about it for now. We only want to see how the Flutter Clients perform for now and validate that.

---


## Single Golang binary

Modify the 2 Services to be actually the same binary.

So essentially its a generic golang server that runs different GRPC Services.

This allows us to run the system on bare metal without any k3d, as well as with k3d.

- When in k3d, each boots and the config tells it what to run.

- When as bare metal, it boots and runs all Services. There is no LB or envoy needed.

- The config can drive it: https://github.com/asishrs/proxyless-grpc-lb/blob/master/hello-world/cmd/server/main.go#L12

---

## Add DB

- Each Service is responsible for its GRPC based Domain model and its own embedded Badger DB. Later we can add flamed to make it HA, and have 3 instances of a Service running in the same DC or different DC's. We are essentially sharding the System to allow us to scale.

- You might want to extend the GRPC API for a simple CRUD of a Users domain model. We are only needing to test the fact that it works with durable state.

- Later we can extend it to use Badger Subscribe, and so can replace NATS and use the DB as a message queue. There will be an Outbox per Thread, and users subscribed to that Thread can then get their updates from it.
	- The CRUD Tables will have a hook to get an event when they change ( Create, Update, Delete), and update the Outbox with that change event.
	- This can use a typed or untyped GRPC API.

---

## Deployment to Hertzner

We need to be able to stand up the k3d on Hertzner.

- From CI, the k3d on Hertzner updates.

---

## Deployment to Rasp PI

k3d supports a rasp pi.

On Premise locations can then run 3 rasp PIs, and have a HA System.
Once would be public to the Internet using standard port forwarding on the router OR a Tunnel that we run in the Cloud.

- From CI, the k3d on the Rasp Pi updates

