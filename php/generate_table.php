<?php
    include 'db_conn.php';
    $uuid = $_POST['id'];
    $step = $_POST['Step_ID'];
    $alias = $_POST['Alias'];
    // $uuid = '';
    // $step = '100';
    // $alias = 1;

    // Create connection
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }

    function unique_multidim_array($array, $key) {
        $temp_array = array();
        $i = 0;
        $z = 0;
        $key_array = array();
       
        foreach($array as $val) {
            if (!in_array($val[$key], $key_array)) {
                $key_array[$i] = $val[$key];
                if($val[$key]) {
                    $temp_array[$z] = $val;
                    $z++;
                }
            }
            $i++;
        }
        return $temp_array;
    }
    
    $field = "";
    $row_array->row_array = [];
    $row_array->alias_array = [];

    if($alias == 0) {
        // push data by step
        $field_query = "
            SELECT GROUP_CONCAT(Filed) as Field FROM mstr_query WHERE Step_ID = '$step' ORDER BY Seq_No
        ";
        $field_res = mysqli_query($conn, $field_query);
        $field_row = mysqli_fetch_assoc($field_res);
        $field = $field_row['Field'];
        $trans_query = "
            SELECT 
                $field
            FROM 
                tbl_transaksi a 
                INNER JOIN mstr_step b ON a.Step_ID = b.Step_ID 
            WHERE
            a.UUID = '$uuid'
        ";
        $trans_res = mysqli_query($conn, $trans_query);
        while($trans_row = mysqli_fetch_assoc($trans_res)) {
            array_push($row_array->row_array, $trans_row);
        }
    }

    if($alias == true) {
        $alias_query = "
            SELECT Alias as Alias FROM mstr_query WHERE Step_ID = '$step'
        ";
        $alias_res = mysqli_query($conn, $alias_query);
        while($alias_row = mysqli_fetch_assoc($alias_res)) {
            array_push($row_array->alias_array, $alias_row['Alias']);
        }
    }

    echo json_encode($row_array);
    mysqli_close($conn);

?>