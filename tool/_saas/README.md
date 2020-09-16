# saas

SAAS level runs our stateless microServices.
- maintemplates load balancer
- maintemplates flutter web server
- maintemplates golang server

## DEV

SO binaries OR dockers ?
- Dockers will make things easier so lets just use them.
- If we need to go to exotic hardware then can do binaries then.


https://github.com/sfproductlabs/roo
- looks good
- docker swarm based

https://github.com/sfproductlabs/floater
- maps a nodes IP back to your cluster on Hetzner. 


## Packaging

Because Core CI is busted, Package devs can just run direct from here for now.

Github can now host dockers from tags i think. Might be a good idea.
https://help.github.com/en/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages

Later docker and Helm go here and we can work out how to use core-fish and core-bs to deploy it off tags like we do for all binaries.


