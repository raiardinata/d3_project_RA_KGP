<?php
    include 'db_conn.php';
    $id = $_POST['id'];

    // Create connection
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }

	$myObj 		= new \stdClass();
    $upd_acl    =   "UPDATE acl_users SET time_stamp = CURRENT_TIMESTAMP WHERE id = '$id'";
    if( mysqli_query($conn, $upd_acl) ) {
        $myObj->access  =   true;
    }
    else {
        $myObj->access  =   false;
    }
    $del_acl    =   "DELETE FROM acl_users WHERE time_stamp <= NOW() - INTERVAL 15 MINUTE";
    mysqli_query($conn, $del_acl);
    $retVal 	= 	json_encode($myObj);
    echo $retVal;
?>