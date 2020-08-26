<?php
    include 'db_conn.php';
    // $mtcd = $_POST['mtcd'];
    $mtcd = '121001055';

    // Create connection
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }

    $prdInfo_query = "SELECT * FROM mstr_prd_info WHERE materialCode = '$mtcd'";
    $prdInfo_res = mysqli_query($conn, $prdInfo_query);
    $prdInfo_row = mysqli_fetch_assoc($prdInfo_res);
    $myObj->materialCode    = $prdInfo_row['materialCode'];
    $myObj->description     = $prdInfo_row['description'];
    $myObj->additionalInfo  = $prdInfo_row['additionalInfo'];
    $myObj->imageData       = $prdInfo_row['imageData'];
    $myObj->imageType       = $prdInfo_row['imageType'];
    $myObj->imageId         = $prdInfo_row['imageId'];

    echo json_encode($myObj,JSON_PRETTY_PRINT);

    mysqli_close($conn);

?>