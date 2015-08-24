var test_address = "http://ipv6.google.com/";

casper.test.begin("Checking IPv6 connection to " + test_address, 1, function(test) {
        casper.start(test_address, function() {
		test.assertHttpStatus(200);
        }).run(function() {
		test.done();
	});
});


