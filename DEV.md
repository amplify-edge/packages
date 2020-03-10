# dev

Tracking the Channels

Git TAGS are used to version the backend and frontend together.

Domains need to be tracked againsts environments
- Domain Y: env-y.json

Map the git TAGS version to the Channel
- stable: (git-tag X)
- beta: (git-tag Y)
- dev: (git-tag Y)
- ci: ( Master always )

Client/assets/env.json
Server/

# DNS

SRV record matching;

ci=maintemplate.ci.getcouragenow.org

beta=maintemplate.beta.getcouragenow.org

dev=maintemplate.dev.getcouragenow.org

stable=maintemplate.stable.getcouragenow.org