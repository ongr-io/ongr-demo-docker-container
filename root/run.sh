#!/bin/sh
set -e

chown -R nobody:nobody /var/www

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
