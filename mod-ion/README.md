# mod-ion

ION and CloudWebrtc are a powerful system for Video Conferencing.

It allows us to do:

- Signup of users and sessions
- Video conferencing
- Multi party video conferencing ( using the Server as a relay)
- Data Publish and Subscribe


## DEV
For devs..but not master detail view yet: 3bb572c927a79e91060eb8f2f614fe63bf1888cc


# Topology ( Servers )

ion sdk —wss—-> signal—>biz—->islb—->sfu

change to

ion sdk —grpc—->grpc sinal—>biz—->islb->sfu
- relies on k8, envoy to handle all communications between client and server using just standard GRPC.

# Entry points 

Each Server and what the do.

...

# Redis swap out

Why and where ...


## Google Desktop

Uses ASTI embeddign inside go-flutter

- when a webrtc session occurs, the go-embed layer can open the ASTI layer and run flutter web inside it.


