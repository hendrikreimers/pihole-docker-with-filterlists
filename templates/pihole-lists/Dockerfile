FROM alpine:latest
MAINTAINER Hendrik Reimers at https://github.com/hendrikreimers/docker-pihole

# Variables
ENV git_list_repository="https://github.com/hendrikreimers/pihole-unique-filterlist-creator"
ENV base_path="/var/www/localhost/htdocs"
ENV list_path="${base_path}/pihole-unique-filterlist-creator"

# Install lighttpd
RUN apk add --update --no-cache lighttpd lighttpd-mod_auth

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools wheel requests

# Install Git
RUN apk add --update --no-cache git

# Get the python scripts and update the list for the first time
RUN cd $base_path && git clone $git_list_repository
RUN cd $list_path && sh install.sh
RUN cd $list_path && sh $list_path/run.sh
RUN mkdir $base_path/logs
RUN chown lighttpd:lighttpd -Rf $list_path/dist

# Cleanup
RUN rm -rf /var/cache/apk/*

# Setup lighttpd
COPY etc/lighttpd/* /etc/lighttpd/
COPY var/www/localhost/htdocs/* $base_path

# Enable cronjobs
RUN echo "30 13 27 * * cd $list_path && git pull > /var/www/localhost/htdocs/logs/last_git.log" >> /var/spool/cron/crontabs/root
RUN echo "30 15 27 * * /usr/bin/sh $list_path/run.sh > /var/www/localhost/htdocs/logs/last_listupdates.log" >> /var/spool/cron/crontabs/root

# Expose HTTP Port
EXPOSE 8080

# Startup Script with cronjob
COPY start.sh /usr/local/bin/
CMD crond && sh /usr/local/bin/start.sh
