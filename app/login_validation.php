<?php

	include "db_conn.php";
	
	$username_val 	= $_POST['username'];
    $password_val 	= $_POST['password'];
	// $username_val 	= "admin";
    // $password_val 	= "admin";
    $retVal     = false;
	
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
        $retVal =   true;
    }
	
	echo $retVal;
	
	mysqli_close($conn);

?>