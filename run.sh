#!/bin/sh

die() {
	echo $@
	exit 1
}

cd /root || die "failed to cd into /root"

# set the test address dynamically
sed -e \
	"s#^var test_address = .*#var test_address = \"${TEST_ADDRESS}\"\;#" \
	/var/www/start.js > start.js || die "failed to set test address"

ip addr del $(ip -4 addr show eth0 | egrep '[^\s]inet .* global eth0$' | awk '{ print $2 }') dev eth0 || die "failed to remove ipv4 address!"

cat << EOF > /etc/resolv.conf
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
nameserver 2a01:4f8:0:a102::add:9999
nameserver 2a01:4f8:0:a0a1::add:1010
nameserver 2a01:4f8:0:a111::add:9898
EOF

# make sure we ignore ssl errors!
casperjs --ignore-ssl-errors=yes test start.js

exit
