#!/bin/sh

echo "GENERATING NGINX CONF TEMPLATE..."

# NOTE: We set dollar here to escape $var's in nginxconf, instead we write
# ${DOLLAR}var to escape it.
export DOLLAR='$'

# Swap configs based on SSL
if [[ $SSL_CERTIFICATE ]]
then
    echo "Using SSL certificate '${SSL_CERTIFICATE}' and allowing hosts '${SSL_ALLOWED_HOSTS}'"
    envsubst < /app/nginx/ssl.conf > /etc/nginx/conf.d/default.conf
else
    echo "No SSL certificate env var (SSL_CERTIFICATE) found"
    envsubst < /app/nginx/nginx.conf > /etc/nginx/sites-available/default
fi

echo "nginx/default.conf:"
echo | cat /etc/nginx/sites-available/default

nginx -g "daemon off;"
