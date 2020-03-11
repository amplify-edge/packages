# https://github.com/jhomlala/catcher

LIB_NAME=catcher
LIB=github.com/jhomlala/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on

SAMPLE_NAME=
SAMPLE_FSPATH=$(LIB_FSPATH)/example/$(SAMPLE_NAME)

CLOUD_PROJECT_ID=winwisely-cloudrun-form

# URL created from cloud-deploy
CLOUD_PROJECT_URL=????
#CLOUD_PROJECT_URL=????https://identicon-generator-ts4lgtxcbq-ew.a.run.app