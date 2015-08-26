FROM        gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald "hasufell@posteo.de"

# set USE flags
RUN echo "*/* acl bash-completion ipv6 kmod openrc pcre readline unicode zlib pam ssl sasl bzip2 urandom crypt tcpd -acpi -cairo -consolekit -cups -dbus -dri -gnome -gnutls -gtk -ogg -opengl -pdf -policykit -qt3support -qt5 -qt4 -sdl -sound -systemd -truetype -wayland -X" >> /etc/paludis/use.conf

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x

# Install phantomjs
RUN chgrp paludisbuild /dev/tty && cave resolve -z phantomjs -x

# install casperjs dependencies
RUN chgrp paludisbuild /dev/tty && cave resolve -z dev-python/pip dev-python/virtualenv -x

# update etc files
RUN etc-update --automode -5

# install casperjs
WORKDIR /opt
RUN git clone --depth=1 git://github.com/n1k0/casperjs.git
WORKDIR /opt/casperjs
RUN ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
WORKDIR /

EXPOSE 8888
COPY www /var/www

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

# used in run.sh
ENV TEST_ADDRESS "http://ipv6.google.com/"

CMD ["/root/run.sh"]
