FROM ubuntu:14.04
MAINTAINER Rod <rod@protobia.tech>

RUN echo 'deb http://mirrors.aliyuncs.com/ubuntu precise main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu precise-security main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu precise-updates main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu precise-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyuncs.com/ubuntu precise-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu precise main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu precise-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu precise-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu precise-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyuncs.com/ubuntu precise-backports main restricted universe multiverse\n'\
>> /etc/apt/sources.list



RUN apt-get update && \
    apt-get upgrade



RUN apt-get install -y  \
    git \
    apache2 \
    mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql \
    php5 libapache2-mod-php5 php5-mcrypt \



RUN a2enmod rewrite && \
    service apache2 start && \
    service mysql start


RUN mkdir -p /app && \
    rm -fr /var/www/html && \
    ln -s /app /var/www/html



RUN apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer



RUN git submodule update --init



COPY . /app
