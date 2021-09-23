FROM timescale/timescaledb:2.4.2-pg13

# Install Patroni and its dependencies
RUN set -ex \
    && apk add --no-cache --virtual .patroni-build-deps coreutils gcc libc-dev make cmake util-linux-dev linux-headers python3-dev \
    && apk add --no-cache python3 \
    && python3 -m ensurepip \
    && pip3 install psycopg2 kazoo patroni \
    && apk del .patroni-build-deps \
    && mkdir patroni-launcher \
    && chown -R postgres:postgres patroni-launcher

COPY docker-patroni-entrypoint.sh /usr/local/bin/docker-patroni-entrypoint.sh
ADD ./* /patroni-launcher/

ENTRYPOINT ["docker-patroni-entrypoint.sh"]
CMD ["postgres"]