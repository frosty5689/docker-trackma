FROM lsiobase/alpine.python3:3.7

LABEL maintainer frosty5689 <frosty5689@gmail.com>

RUN apk add --no-cache --update \
    ca-certificates \
    wget \
    unzip \
 && rm -rf /var/cache/apk* \
 && update-ca-certificates \
 && pip3 install --upgrade --no-cache-dir setuptools pyinotify \
 && pip3 install --no-cache-dir -U pyinotify \
 && rm -rf /root/.cache

ARG TRACKMA_VERSION=master

COPY root/ /

RUN wget -O /tmp/trackma-$TRACKMA_VERSION.zip https://github.com/z411/trackma/archive/$TRACKMA_VERSION.zip && \
    ls -l /tmp && \
    unzip /tmp/trackma-$TRACKMA_VERSION.zip -d /tmp && \    
    cd /tmp/trackma* && \
    python3 setup.py install && \
    rm -rf /tmp/*

VOLUME /config

CMD ["python3", "/usr/bin/trackma"]
