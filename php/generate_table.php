<?php
    include 'db_conn.php';
    $matcd = $_POST['mtcd'];
    $batch = $_POST['batc'];
    // $matcd = '121001055';
    // $batch = '20191003';

    // Create connection
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }

    $rowArray = [];
    $trans_query = "
        WITH RECURSIVE tbl_transaksiCTE AS
        (
            SELECT 
                a.*, b.Description
            FROM
                tbl_transaksi a
            INNER JOIN mstr_step b ON b.Step_ID = a.Step_ID
            WHERE
                    (
                        (a.MaterialCode='$matcd' AND a.Batch = '$batch')
                        OR	(a.RM_MaterialCode='$matcd' AND a.RM_Batch = '$batch')
                    )
            
            UNION ALL
            
            SELECT 
                d.*, e.Description
            FROM 
                tbl_transaksiCTE c
            INNER JOIN tbl_transaksi d ON (d.MaterialCode = c.RM_MaterialCode AND d.Batch = c.RM_Batch)
            INNER JOIN mstr_step e ON e.Step_ID = d.Step_ID
        
        )
        SELECT
            *
        FROM
            tbl_transaksiCTE b
        GROUP BY b.UUID
        ORDER BY b.Step_ID ASC
    ";
    $trans_res = mysqli_query($conn, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        array_push($rowArray, $row);
    }
    echo $jsonRes = json_encode($rowArray);
    mysqli_close($conn);

?>