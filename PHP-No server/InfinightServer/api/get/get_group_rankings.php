<?php
//this class is used to query all the events from the database 

try
{

	// Are we running in development or production mode? You can easily switch
	// between these two in the Apache VirtualHost configuration.
	if (!defined('APPLICATION_ENV'))
		define('APPLICATION_ENV', getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production');

	// In development mode, we show all errors because we obviously want to 
	// know about them. We don't do this in production mode because that might
	// expose critical details of our app or our database. Critical PHP errors
	// will still be logged in the PHP and Apache error logs, so it's always
	// a good idea to keep an eye on them.
	if (APPLICATION_ENV == 'development')
	{
		error_reporting(E_ALL|E_STRICT);
		ini_set('display_errors', 'on');
	}
	else
	{
		error_reporting(0);
		ini_set('display_errors', 'off');
	}

	// Load the config file. I prefer to keep all configuration settings in a
	// separate file so you don't have to mess around in the main code if you
	// just want to change some settings.
	require_once '../api_config.php';
	$config = $config[APPLICATION_ENV];

	// In development mode, we fake a delay that makes testing more realistic.
	// You're probably running this on a fast local server but in production
	// mode people will be using it on a mobile device over a slow connection.
	if (APPLICATION_ENV == 'development') 
		sleep(2);

//	header('Content-type: application/json');

////////////////////////////////////////////////////////
	// To keep the code clean, I put the API into its own class. Create an
	// instance of that class and let it handle the request.
	$retrieve = new RETRIEVE($config);
	$retrieve->handleCommand();
////////////////////////////////////////////////////////


//	echo "OK" . PHP_EOL;
}
catch (Exception $e)
{
	// The code throws an exception when something goes horribly wrong; e.g.
	// no connection to the database could be made. In development mode, we
	// show these exception messages. In production mode, we simply return a
	// "500 Server Error" message.

	if (APPLICATION_ENV == 'development')
		var_dump($e);
	else
		exitWithHttpError(500);
}

class RETRIEVE {
	private $pdo;

	function __construct($config)
	{
		// Create a connection to the database.
		$this->pdo = new PDO(
			'mysql:host=' . $config['db']['host'] . ';dbname=' . $config['db']['dbname'], 
			$config['db']['username'], 
			$config['db']['password'],
			array());
	
	
		// If there is an error executing database queries, we want PDO to
		// throw an exception. Our exception handler will then exit the script
		// with a "500 Server Error" message.
		$this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		// We want the database to handle all strings as UTF-8.
		$this->pdo->query('SET NAMES utf8');
	}
	
		function handleCommand()
	{

		$this->getRankings();
	}
	function getRankings () 
	{
			$this->pdo->beginTransaction();
			$stmt = $this->pdo->prepare('SELECT * FROM groups ORDER BY points DESC');
			$stmt->execute();
			$rankings = $stmt->fetchAll(PDO::FETCH_OBJ);
				
		//set header so XCode accepts the JSON object
	header('Content-Type: application/json');

	   echo json_encode($rankings);
	   return true;
	   
	}
	
}
?>