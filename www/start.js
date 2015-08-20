
casper.test.begin("Checking IPv6 connection to http://ipv6.google.com/", 1, function(test) {
        casper.start('http://ipv6.google.com/', function() {
		test.assertHttpStatus(200);
        }).run(function() {
		test.done();
	});
});


