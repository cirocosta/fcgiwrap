FROM alpine:3.4

MAINTAINER Ciro S. Costa <ciro.costa@liferay.com>

ADD ./src /usr/src/fcgiwrap

RUN set -x &&  \
    apk --update upgrade      &&  \
    apk add --virtual build_deps  \
      autoconf                    \
      libtool                     \
      build-base                  \
      automake                    \
      fcgi-dev                    \
      pkgconfig               &&  \


    cd /usr/src/fcgiwrap      &&  \
    autoreconf -i             &&  \
    ./configure LDFLAGS="-static" \
      --prefix=/usr               \
      --mandir=/share/man         \
      --sbindir=/bin          &&  \
    make && make install      &&  \


    apk del build_deps        &&  \
    rm -rf /var/cache/apk/*   &&  \
    rm -rf /tmp/*                                         

