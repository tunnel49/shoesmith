#!/bin/sh
set -e

mkdir -p /srv/shoesmith
mkdir -p /srv/shoesmith/tftpboot
touch /srv/shoesmith/dnsmasq.conf
ln -sf /srv/shoesmith/dnsmasq.conf /etc/dnsmasq.conf
/usr/local/bin/envtpl -o /etc/cobbler/settings /etc/cobbler/settings.j2

exec "$@"
