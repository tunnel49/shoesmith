#!/bin/sh -x
set -e

if [ -z $1 ]
then tag=latest
else tag="$1"
fi

container="quay.io/tunnel49/shoesmith:$tag"
podman="podman"
#podman="podman --remote-host poddler.local --username root"
podrun="$podman run -d --rm --pod shoesmith -e HOST_IP=$(hostname -i) -v shoesmith:/srv/shoesmith:z"

#brctl hairpin cni-podman0 veth449b401c on

#$podman pull $container
$podman pod create -n shoesmith --network=host
#$podman pod create -n shoesmith -p 25151:25151,80:80,443:443,67:67/udp
$podman volume create shoesmith
$podrun --name cobbler $container 
$podrun --name cobbler-proxy $container /usr/sbin/httpd -DFOREGROUND
$podrun --name cobbler-dhcp $container /watch-dnsmasq.sh
