#!/bin/sh

# symlink config
if [ ! -e /root/.trackma ]; then
	ln -s /config /root/.trackma
fi

# configure account and settings
python config.py

exec python /usr/local/bin/trackma
