FROM lsiobase/alpine:3.6

LABEL maintainer frosty5689 <frosty5689@gmail.com>

COPY root/ /

RUN apk add --no-cache ca-certificates python3 && \
    update-ca-certificates && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    pip install --no-cache-dir -U pyinotify && \
    cd /trackma && \
    python3 setup.py install && \
    cd / && \
    rm -rf /trackma

VOLUME /config

CMD ["python3", "/usr/bin/trackma", "-a1"]
