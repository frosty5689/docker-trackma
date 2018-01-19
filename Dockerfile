FROM lsiobase/alpine:3.6

LABEL maintainer frosty5689 <frosty5689@gmail.com>

RUN apk add --update \
    ca-certificates \
    python3 \
    wget \
    unzip \
 && rm -rf /var/cache/apk* \
 && update-ca-certificates \
 && python3 -m ensurepip \
 && rm -r /usr/lib/python*/ensurepip \
 && pip3 install --upgrade pip setuptools \
 && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
 && rm -r /root/.cache \
 && pip install --no-cache-dir -U pyinotify

ARG TRACKMA_VERSION=master

COPY root/ /

RUN wget -O /tmp/trackma-$TRACKMA_VERSION.zip https://github.com/z411/trackma/archive/$TRACKMA_VERSION.zip && \
    ls -l /tmp && \
    mkdir -p /opt && \
    unzip /tmp/trackma-$TRACKMA_VERSION.zip -d /opt && \
    mv /opt/trackma* /opt/trackma &&\
    cd /opt/trackma && \
    python3 setup.py develop && \
    rm -rf /tmp/trackma-$TRACKMA_VERSION.zip


VOLUME /config

WORKDIR /opt/trackma

CMD ["python3", "/usr/bin/trackma"]
