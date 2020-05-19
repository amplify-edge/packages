#!/usr/bin/env bash


# this is needed for bootstrapping this repo manually and then checking it in.
# whenever our boilerplate change we have to do this.

SOURCE_FSPATH="./../core-runtime/boilerplate"
echo SOURCE_FSPATH: ${SOURCE_FSPATH}

TARGET_FSPATH="${PWD}/boilerplate/"
echo TARGET_FSPATH: ${TARGET_FSPATH}

# clean it
#rm -rf ${TARGET_FSPATH}

# update it
#cp -r ${SOURCE_FSPATH} ${TARGET_FSPATH}