#!/bin/sh -x
set -e

if [ -z $1 ]
then tag=latest
else tag="$1"
fi

container="quay.io/pontuslundgren/shoesmith:$tag"
podman="podman"
#podman="podman --remote-host poddler.local --username root"
podrun="$podman run -d --rm --pod shoesmith -v shoesmith:/srv/shoesmith:z"

$podman pull $container
$podman pod create -n shoesmith -p 80:80,443:443,67:67/udp
$podman volume create shoesmith
$podrun --name cobbler $container 
$podrun --name cobbler-proxy $container /usr/sbin/httpd -DFOREGROUND
$podrun --name cobbler-dhcp $container /watch-dnsmasq.sh
