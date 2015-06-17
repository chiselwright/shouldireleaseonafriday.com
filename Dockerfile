FROM    kyma/docker-nginx
ADD     www-files/     /var/www
CMD     'nginx'
