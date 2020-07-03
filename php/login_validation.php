<?php

	include "db_conn.php";
	
	$username_val 	= $_POST['username'];
	$password_val 	= $_POST['password'];
	
	$retVal     = false;
	$myObj 		= new \stdClass();
	
	// Create connection
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	// Check connection
	if (!$conn) {
	    die("Connection failed: " . mysqli_connect_error());
	}
	
	$query1 = "
				SELECT * FROM users WHERE name = '" . $username_val . "' and password =  '" . $password_val . "'
              ";
    $res1 	= mysqli_query($conn, $query1);
    if(mysqli_num_rows($res1) > 0){
		$checkID			=   true;
		$myObj->checkID		=	$checkID;
		$myObj->username	=	$username_val;
		$retVal 			= 	json_encode($myObj);
	}
	else{
		$checkID			=   false;
		$myObj->checkID		=	$checkID;
		$myObj->username	=	$username_val;
		$retVal 			= 	json_encode($myObj);
	}
	
	echo $retVal;
	
	mysqli_close($conn);

?>