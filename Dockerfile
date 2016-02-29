FROM 	gliderlabs/alpine:3.3

MAINTAINER Kazimieras Gurskas <kazimieras.gurskas@nfq.com>

RUN apk add --no-cache  nginx \
                        php-fpm \
                        php-curl \
                        php-opcache \
                        php-intl \
                        php-posix \
                        php-ctype \
                        php-xml \
                        php-dom \
                        php-pdo \
                        php-json \
                        php-iconv \
                        php-pcntl \
                        openjdk7-jre-base \
                        sudo \
                        procps \
                        supervisor

ENV ELASTICSEARCH_VERSION 2.2.0
RUN \
  mkdir -p /opt && \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  tar -xzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  mv elasticsearch-$ELASTICSEARCH_VERSION /opt/elasticsearch && \
  adduser -S elasticsearch && \
  addgroup elasticsearch && \
  chown -R elasticsearch:elasticsearch /opt/elasticsearch

ADD root /

RUN sudo -u elasticsearch /opt/elasticsearch/bin/elasticsearch -d && \
    sleep 20 && \
    php /var/www/bin/console ongr:es:index:create && \
    php /var/www/bin/console ongr:es:index:import /var/www/app/Resources/data/demo.json

RUN chmod +x /run.sh /init

EXPOSE 80
WORKDIR /var/www
CMD ["/run.sh"]
