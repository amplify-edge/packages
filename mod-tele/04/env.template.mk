LIB_NAME=network
LIB=github.com/winwisely99/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on

SAMPLE_NAME=form
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

CLOUD_PROJECT_ID=winwisely-cloudrun-form

# URL created from cloud-deploy
CLOUD_PROJECT_URL=????
#CLOUD_PROJECT_URL=????https://identicon-generator-ts4lgtxcbq-ew.a.run.app