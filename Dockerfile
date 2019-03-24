FROM ubuntu:16.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -yq install \
    curl \
    git \
    apache2 \
    libapache2-mod-php7.0 \
    php7.0-mcrypt \
    php7.0 && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
	
RUN /usr/sbin/phpenmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php/7.0/apache2/php.ini

ENV ALLOW_OVERRIDE **False**

ADD run.sh /run.sh

RUN chmod 755 /*.sh

RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

COPY ./www /app
RUN mv /app/config-sample.php /app/config.php
	
EXPOSE 80

WORKDIR /app

CMD ["/run.sh"]
