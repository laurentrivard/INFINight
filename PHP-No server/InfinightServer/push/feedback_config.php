<?php

// Configuration file for feedback.php

$config = array(
	// These are the settings for development mode
	'development' => array(

		// The APNS feedback server that we will use
		'server' => 'feedback.sandbox.push.apple.com:2196',

		// The SSL certificate that allows us to connect to the APNS servers
		'certificate' => 'ck_development.pem',
		'passphrase' => 'infinight@hec.ca',

		// Configuration of the MySQL database
		'db' => array(
			'host'     => 'localhost',
			'dbname'   => 'infinight',
			'username' => 'infinight2',
			'password' => 'infinight@hec.ca',
			),
		),

	// These are the settings for production mode
	'production' => array(

		// The APNS feedback server that we will use
		'server' => 'feedback.push.apple.com:2196',

		// The SSL certificate that allows us to connect to the APNS servers
		'certificate' => 'ck_production.pem',
		'passphrase' => 'infinight@hec.ca',

		// Configuration of the MySQL database
		'db' => array(
			'host'     => 'localhost',
			'dbname'   => 'infinight',
			'username' => 'infinight2',
			'password' => 'infinight@hec.ca',
			),
		),
	);
