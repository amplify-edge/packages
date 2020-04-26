#!/usr/bin/env bash

tail -n 20 ./ENV >> $HOME/.profile 

SHELLNAME='${SHELL##*/}'
case $SHELLNAME in
    fish)
        bax source $HOME/.profile
        ;;
    zsh)
        emulate sh -c '. $HOME/.profile'
        ;;
    *)
        source $HOME/.profile
        ;;
esac   