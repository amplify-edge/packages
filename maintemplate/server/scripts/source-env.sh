#!/usr/bin/env bash

tail -n 20 ./ENV >> ~/.profile

SHELLNAME="${SHELL##*/}"
case $SHELLNAME in
    fish)
        bax source ~/.profile
        ;;
    zsh)
        emulate sh -c 'eval ~/.profile'
        ;;
    *)
        source ~/.profile
        ;;
esac   