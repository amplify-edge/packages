#!/usr/bin/env bash

OSNAME=$(uname -s)

install_prequisites() {
    echo -n "Installing linux prequisites"
    sudo modprobe kvm
    hash apt >/dev/null && {
        sudo apt install -y qemu-kvm libvirtd-daemon bridge-utils \
            virtinst libvirt-daemon-system libprotobuf-dev
    }
    hash dnf >/dev/null && {
        sudo dnf install -y qemu-kvm qemu-img virt-manager libvirt libvirt-python \
            libvirt-client virt-install virt-viewer bridge-utils protobuf-devel
    }
    # User should be in the kvm group 
    sudo gpasswd -a kvm $(echo $USER) kvm
    # Polkit should've accepted administration from KVM
    cat <<<' > $HOME/50-libvirt.rules
    polkit.addRule(function(action, subject) {
        if (action.id == "org.libvirt.unix.manage" &&
            subject.isInGroup("kvm")) {
                return polkit.Result.YES;
            }
    });'
    sudo mv $HOME/50-libvirt.rules /etc/polkit-1/rules.d/50-libvirt.rules
    sudo systemctl enable --now libvirtd virtlogd
    echo "REBOOTING to take effect"
    sudo reboot
}

install_prequisites_mac() {
    echo -n "Installing mac prequisites"
    brew install gnu-sed coreutils 
    # docker app
    brew cask install docker
}

# Gofish
curl -fsSL https://raw.githubusercontent.com/fishworks/gofish/master/scripts/install.sh | bash

gofish install helm

case $OSNAME in
    Linux)
        install_prequisites
        ;;
    Darwin)
        install_prequisites_mac
        ;;
    *)
        echo "No support for windows"
        ;;
esac
