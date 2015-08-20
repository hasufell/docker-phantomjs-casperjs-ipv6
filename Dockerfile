FROM        debian:sid
MAINTAINER  Julian Ospald "hasufell@posteo.de"

# environment variables
ENV DEBIAN_FRONTEND noninteractive

# Update the package repository and pull basic packages
RUN apt-get update && \ 
	apt-get upgrade -y && \
	apt-get install -y wget curl locales

# Configure timezone and locale
RUN echo "Europe/Berlin" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	dpkg-reconfigure locales

# Added dotdeb to apt
RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

# Install tools
RUN apt-get update; apt-get install -y fontconfig vim nano git

# Install phantomjs
RUN apt-get update; apt-get install -y phantomjs

# install casperjs dependencies
RUN apt-get update; apt-get install -y python python-dev python-pip python-virtualenv

# install casperjs
WORKDIR /opt
RUN git clone git://github.com/n1k0/casperjs.git
WORKDIR /opt/casperjs
RUN ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
WORKDIR /

EXPOSE 8888
COPY www /var/www

ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

CMD ["/root/run.sh"]
