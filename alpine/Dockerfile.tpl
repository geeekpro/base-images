FROM #{FROM}

#{LABEL}

#{QEMU}

RUN apk add --update \
	bash \
	ca-certificates \
	dbus \
	findutils \
	openrc \
	tar \
	udev \
	&& rm -rf /var/cache/apk/*

# Config OpenRC
RUN sed -i '/tty/d' /etc/inittab
COPY rc.conf /etc/

COPY resin /etc/init.d/

RUN rc-update add resin default \
	&& rc-update add dbus default

COPY entry.sh /usr/bin/entry.sh
                  
ENTRYPOINT ["/usr/bin/entry.sh"]
