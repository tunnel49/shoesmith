#!/bin/sh
set -e
mkdir -p /srv/cobbler
touch /srv/cobbler/dnsmasq.conf
rm /etc/dnsmasq.conf
ln -s /srv/cobbler/dnsmasq.local /etc/dnsmasq.conf
/usr/local/bin/envtpl -o /etc/cobbler/settings /etc/cobbler/settings.j2

exec "$@"
