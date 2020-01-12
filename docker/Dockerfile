FROM fedora

RUN yum -y install cobbler syslinux curl dnsmasq pip && \
    yum -y install iproute && \
    yum -y clean all

RUN pip install envtpl

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY watch-dnsmasq.sh /watch-dnsmasq.sh

COPY settings.j2 /etc/cobbler/settings.j2
COPY modules.conf /etc/cobbler/modules.conf
COPY dnsmasq.template /etc/cobbler/dnsmasq.template
COPY genders /etc/genders

RUN sed -i 's/which_dhcp_module == "manage_/which_dhcp_module == "managers./g'   /usr/lib/python3.7/site-packages/cobbler/modules/sync_post_restart_services.py

ENV HOST_IP=127.0.0.1

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 67/UDP 80/tcp 443/tcp 25151/tcp

CMD ["/usr/bin/cobblerd", "-F", "-l", "INFO", "-f", "/dev/stdout"]
