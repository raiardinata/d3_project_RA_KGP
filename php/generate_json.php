<?php
include 'db_conn.php';
// $matcd = $_POST['mtcd'];
// $batch = $_POST['batc'];
$matcd = '8994016003525';
$batch = '0207MC02';

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die('Connection failed: ' . mysqli_connect_error());
}

$nodesArray = [];
function loop_nodes($a, $b, $c)
{
    $link_array = [];
    $trans_query = "
        WITH RECURSIVE tbl_transaksiBASE AS(
            SELECT 
                UUID, `Key`,
                MaterialCode, MaterialDescription, 
                Batch, RM_MaterialCode, 
                RM_MaterialDescription, RM_Batch, 
                CustomerID, CustomerName,
                ShiptoID, ShiptoName,
                b.Description, b.Step_ID
            FROM 
                tbl_transaksi a
                JOIN mstr_step b ON b.Step_ID = a.Step_ID
            WHERE MaterialCode = '$a' AND Batch = '$b'
            
            UNION
            
            SELECT 
                tbl_ts.UUID, tbl_ts.`Key`,
                tbl_ts.MaterialCode, tbl_ts.MaterialDescription, 
                tbl_ts.Batch, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch, 
                tbl_ts.CustomerID, tbl_ts.CustomerName,
                tbl_ts.ShiptoID, tbl_ts.ShiptoName,
                e.Description, e.Step_ID
            FROM
                tbl_transaksiBASE cte
                INNER JOIN tbl_transaksi tbl_ts
                    ON tbl_ts.RM_MaterialCode = cte.MaterialCode AND tbl_ts.RM_Batch = cte.Batch
            INNER JOIN mstr_step e 
                    ON e.Step_ID = tbl_ts.Step_ID
        ), tbl_transaksiPRD AS(
            SELECT 
                UUID, `Key`,
                MaterialCode, MaterialDescription, 
                Batch, RM_MaterialCode, 
                RM_MaterialDescription, RM_Batch, 
                CustomerID, CustomerName,
                ShiptoID, ShiptoName,
                b.Description, b.Step_ID
            FROM 
                tbl_transaksi a
                JOIN mstr_step b ON b.Step_ID = a.Step_ID
            WHERE MaterialCode = '$a' AND Batch = '$b'
            
            UNION
            
            SELECT 
                tbl_ts.UUID, tbl_ts.`Key`,
                tbl_ts.MaterialCode, tbl_ts.MaterialDescription, 
                tbl_ts.Batch, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch, 
                tbl_ts.CustomerID, tbl_ts.CustomerName,
                tbl_ts.ShiptoID, tbl_ts.ShiptoName,
                e.Description, e.Step_ID
            FROM
                tbl_transaksiPRD cte
                INNER JOIN tbl_transaksi tbl_ts
                    ON tbl_ts.MaterialCode = cte.RM_MaterialCode AND tbl_ts.Batch = cte.RM_Batch
            INNER JOIN mstr_step e 
                    ON e.Step_ID = tbl_ts.Step_ID
        ), tbl_transaksiINB AS(
            SELECT 
                *
            FROM 
                tbl_transaksiBASE
            
            UNION
            
            SELECT 
                tbl_ts.UUID, tbl_ts.`Key`,
                tbl_ts.MaterialCode, tbl_ts.MaterialDescription, 
                tbl_ts.Batch, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch, 
                tbl_ts.CustomerID, tbl_ts.CustomerName,
                tbl_ts.ShiptoID, tbl_ts.ShiptoName,
                e.Description, e.Step_ID
            FROM
                tbl_transaksiINB cte
                INNER JOIN tbl_transaksi tbl_ts
                    ON tbl_ts.MaterialCode = cte.MaterialCode AND tbl_ts.Batch = cte.Batch AND tbl_ts.Step_ID = 400
            INNER JOIN mstr_step e 
                    ON e.Step_ID = tbl_ts.Step_ID
        )
        SELECT * FROM tbl_transaksiBASE
        UNION
        SELECT * FROM tbl_transaksiPRD
        UNION
        SELECT * FROM tbl_transaksiINB
        GROUP BY Step_ID
        ORDER BY Step_ID ASC
    ";
    $i = 0;
    $trans_res = mysqli_query($c, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        if($i == 0) {
            $nodesArray = [
                'nodes' => [
                    [
                        'id'=>$row['UUID'],
                        'group' => $row['Step_ID'],
                        'description' => $row['Description'],
                        'material' => $row['MaterialDescription'],
                        'material_code' => $row['MaterialCode'],
                        'batch' => $row['Batch'],
                        'key' => $row['Key']
                    ]
                ]
            ];
        }
        else {
            array_push($nodesArray['nodes'], 
                [
                    'id'=>$row['UUID'],
                    'group' => $row['Step_ID'],
                    'description' => $row['Description'],
                    'material' => $row['MaterialDescription'],
                    'material_code' => $row['MaterialCode'],
                    'batch' => $row['Batch'],
                    'key' => $row['Key']
                ]
            );
        }
        $i++;
    }
    return $nodesArray;
}

$nodesArray = loop_nodes($matcd, $batch, $conn);
$linkArray = [];
function array_filter_recursive($input){
    foreach ($input as &$value){
        if (is_array($value)){
            $value = array_filter_recursive($value);
        }
    }
    return array_filter($input);
}
function unique_multidim_array($array, $key) {
    $temp_array = array();
    $i = 0;
    $key_array = array();
   
    foreach($array as $val) {
        if (!in_array($val[$key], $key_array)) {
            $key_array[$i] = $val[$key];
            array_push($temp_array, $val);
        }
        $i++;
    }
    return $temp_array;
}
// array_filter_recursive($resArray);
// $details = unique_multidim_array($resArray,'UUID');
// $resArray = array_unique($resArray, SORT_REGULAR);
$n = 0;
foreach($nodesArray as $nodes) {
    // CREATE THE LINK
    foreach($nodes as $nodes) {
        // array search nodes make a link
        // echo array_search("red",$nodesArray);
    }
}

foreach($nodesArray as $index => $columns) {
    foreach($columns as $key => $value) {
        if ($key == 'Step_ID' && $value == '200') {
            $filtered[] = $columns;
            echo $filtered;
        }
    }
}

$newArray = $nodesArray + $linkArray;
// echo json_encode($nodesArray,JSON_PRETTY_PRINT);

mysqli_close($conn);

?>
