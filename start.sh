#!/bin/sh

# symlink config
if [ ! -e /root/.trackma ]; then
	ln -s /config /root/.trackma
fi

exec python3 /usr/local/bin/trackma
