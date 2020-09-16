LIB_NAME=bootstrap
LIB=github.com/yourrepo/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=gsheet
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

GO111MODULE=on

CLOUD_PROJECT_ID=winwisely-cloudrun-googlesheet

# URL created from cloud-deploy
CLOUD_PROJECT_URL=????
#CLOUD_PROJECT_URL=????https://identicon-generator-ts4lgtxcbq-ew.a.run.app

GOOGLE_SHEET_ID = 16eeYgh8dus50fISokKK8TMVWLR8A18Er-p5dBcO0FYw
GOOGLE_SHEET_URL = https://docs.google.com/spreadsheets/d/$(GOOGLE_SHEET_ID)
GOOGLE_SHEET_CSV =https://docs.google.com/spreadsheets/d/e/2PACX-1vTrndYJtszNP2_VL2t_z7wa03v2R01yq3wfRi4-RgmJMzXIEMzAX4OybZT7eEiqcmkZLWcFJhwJqJzA/pub?output=csv

