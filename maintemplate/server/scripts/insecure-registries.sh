#!/usr/bin/env bash

OSNAME=$(uname -s)

function rundocker_registry() {
    docker run -d -p 5000:5000 --restart=always --name registry registry:2
}

function runpodman_registry() {
    podman run -d \
        --name registry \
        -p 5000:5000 \
        -v $HOME/.local/share/containers/registry:$HOME/.local/share/containers/registry \
        --restart=always \
        registry:2

}

if [ "$OSNAME" = "Linux" ]; then
    if hash podman 2>/dev/null; then
        echo "Running podman insecure local registry"
        mkdir -p $HOME/.local/share/containers/registry
        sed -z "s@\[registries\.insecure\]\nregistries\ \= \[\]@\[registries\.insecure\]\nregistries\ \= \['localhost:5000'\]@" /etc/containers/registries.conf | sudo tee /etc/containers/registries.conf
        runpodman_registry
    else
        ## It's running docker
        echo "OPTIONS='--insecure-registry 127.0.0.1:5000 --selinux-enabled .....'" | sudo tee -a /etc/sysconfig/docker
        echo "Running docker insecure local registry"
        sudo systemctl restart docker
        rundocker_registry
    fi
elif [ "$OSNAME" = "Darwin" ]; then
    rundocker_registry
fi