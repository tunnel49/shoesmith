#!/bin/sh -x
set -e

container="quay.io/pontuslundgren/shoesmith"
podman="podman --remote-host poddler.local --username root"
podrun="$podman run -d --rm --pod shoesmith"

$podman pull $container
$podman pod create -n shoesmith -p 80:80,443:443,10.0.1.146:67:67/udp
$podrun --name cobbler $container 
$podrun --name cobbler-proxy $container /usr/sbin/httpd -DFOREGROUND
$podrun --name cobbler-dhcp $container /usr/sbin/dnsmasq --no-daemon
