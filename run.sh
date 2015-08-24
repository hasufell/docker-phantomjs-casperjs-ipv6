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

# make sure we ignore ssl errors!
casperjs --ignore-ssl-errors=yes test start.js

exit
