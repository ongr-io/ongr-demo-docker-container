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
                        supervisor

ENV ELASTICSEARCH_VERSION 1.7.4
RUN \
  mkdir -p /opt && \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  tar -xzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  mv elasticsearch-$ELASTICSEARCH_VERSION /opt/elasticsearch

ADD root /

RUN /opt/elasticsearch/bin/elasticsearch -d && \
    sleep 20 && \
    php /var/www/app/console ongr:es:index:create && \
    php /var/www/app/console ongr:es:index:import --raw /var/www/src/ONGR/DemoBundle/Resources/data/ongr.json

RUN chmod +x /run.sh /init

EXPOSE 80
WORKDIR /var/www
CMD ["/run.sh"]
