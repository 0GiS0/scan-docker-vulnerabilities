FROM ubuntu:xenial-20210429

# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.
RUN apt-get update && apt-get install -y apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 curl lynx-common

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite


# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# Expose apache.
EXPOSE 80

# Copy this repo into place.
ADD ["index.html","/var/www/html/"]

# Update the default apache site with the config we created.
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]