<?php
function set_db_connection()
{
	header('X-XRDS-Location: http://' . $_SERVER['SERVER_NAME'] .
     '/services.xrds.php');

	// Connect to database
	$db = new PDO('mysql:host=localhost;dbname=ci_rest', 'root', '');
	
	// Create a new instance of OAuthStore and OAuthServer
	$store = OAuthStore::instance('PDO', array('conn' => $db));
	$server = new OAuthServer();
}