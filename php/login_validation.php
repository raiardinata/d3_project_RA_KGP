<?php

	include "db_conn.php";
	
	$username_val 	= $_POST['username'];
	$password_val 	= $_POST['password'];
	
	$retVal     = false;
	$myObj 		= new \stdClass();
	$session_UUID	=	create_guid();
	
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
	$cnt_acl    =   "SELECT COUNT(*) as count FROM acl_users";
    $cnt_res    =   mysqli_query($conn, $cnt_acl);
    $cnt_row    =   mysqli_fetch_assoc($cnt_res);
    $myObj->count   =   (int)$cnt_row['count'];
    if(mysqli_num_rows($res1) > 0){
		$myObj->checkID		=	true;
		$myObj->username	=	$username_val;
	}
	else{
		$myObj->checkID		=	false;
	}
	$row 			= 	mysqli_fetch_assoc($res1);
	$checkAclQuery	=	"SELECT * FROM acl_users WHERE usr_list = '". $row['name'] ."'";
	$checkAclRes 	= mysqli_query($conn, $checkAclQuery);
	if(mysqli_num_rows($checkAclRes) > 0){
		$checkAclRow 	=	mysqli_fetch_assoc($checkAclRes);
		$myObj->sessionID	=	$checkAclRow['id'];
		$query2			=	"
								UPDATE acl_users SET time_stamp = CURRENT_TIMESTAMP WHERE usr_list = '". $row['name'] ."'
							";
		$res2 	= mysqli_query($conn, $query2);
	}
	else{
		
		$myObj->sessionID	=	$session_UUID;
		$query2			=	"
								INSERT INTO acl_users (id, usr_id, usr_list, time_stamp)
								VALUES('" . $session_UUID. "', '" . $row['id'] . "', '" . $row['name'] . "', CURRENT_TIMESTAMP)
								ON DUPLICATE KEY UPDATE usr_list = '" . $row['name'] . "'
							";
		$res2 	= mysqli_query($conn, $query2);
	}


	/**
	 * A temporary method of generating GUIDs of the correct format for our DB.
	 *
	 * @return string contianing a GUID in the format: aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
	 *
	 * Portions created by SugarCRM are Copyright (C) SugarCRM, Inc.
	 * All Rights Reserved.
	 * Contributor(s): ______________________________________..
	 */
	function create_guid()
	{
		$microTime = microtime();
		list($a_dec, $a_sec) = explode(' ', $microTime);

		$dec_hex = dechex($a_dec * 1000000);
		$sec_hex = dechex($a_sec);

		ensure_length($dec_hex, 5);
		ensure_length($sec_hex, 6);

		$guid = '';
		$guid .= $dec_hex;
		$guid .= create_guid_section(3);
		$guid .= '-';
		$guid .= create_guid_section(4);
		$guid .= '-';
		$guid .= create_guid_section(4);
		$guid .= '-';
		$guid .= create_guid_section(4);
		$guid .= '-';
		$guid .= $sec_hex;
		$guid .= create_guid_section(6);

		return $guid;
	}

	function create_guid_section($characters)
	{
		$return = '';
		for ($i = 0; $i < $characters; ++$i) {
			$return .= dechex(mt_rand(0, 15));
		}

		return $return;
	}

	function ensure_length(&$string, $length)
	{
		$strlen = strlen($string);
		if ($strlen < $length) {
			$string = str_pad($string, $length, '0');
		} elseif ($strlen > $length) {
			$string = substr($string, 0, $length);
		}
	}

	function microtime_diff($a, $b)
	{
		list($a_dec, $a_sec) = explode(' ', $a);
		list($b_dec, $b_sec) = explode(' ', $b);

		return $b_sec - $a_sec + $b_dec - $a_dec;
	}

	$retVal 			= 	json_encode($myObj);
	echo $retVal;
	
	mysqli_close($conn);

?>