FROM cseelye/rpi-raspbian-cross
MAINTAINER Carl Seelye <cseelye@gmail.com>

RUN [ "cross-build-start" ]
RUN apt-get update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install nginx nginx-extras ca-certificates supervisor && \
    rm --force --recursive /etc/nginx/conf.d/* /etc/nginx/sites-enabled /etc/nginx/sites-available /etc/nginx/snippets /var/www /usr/share/nginx/html/* && \
    apt-get autoremove && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY sample.crt /etc/ssl/nginx.crt
COPY sample.key /etc/ssl/nginx.key
RUN [ "cross-build-end" ]

CMD ["/usr/bin/supervisord"]
