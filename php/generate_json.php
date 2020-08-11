<?php
include 'db_conn.php';
// $matcd = $_POST['mtcd'];
// $batch = $_POST['batc'];
$matcd = '124000714';
$batch = '20191011';

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die('Connection failed: ' . mysqli_connect_error());
}

$step100 = false;
$step200 = false;
$step300 = false;
$step400 = false;
$json_array = [];
function loop_nodes($a, $b, $c)
{
    $db_array = [];
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
                        (a.MaterialCode='$a' AND a.Batch = '$b')
                        OR	(a.RM_MaterialCode='$a' AND a.RM_Batch = '$b')
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

    $i = 0;
    $trans_res = mysqli_query($c, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        if($row['Step_ID'] == 100) {
            $step100 = true;
        }
        else if($row['Step_ID'] == 200) {
            $step200 = true;
        }
        else if($row['Step_ID'] == 300) {
            $step300 = true;
        }
        else if($row['Step_ID'] == 400) {
            $step400 = true;
        }
        array_push($db_array, $row);
    }
    return $db_array;
}

$resArray = loop_nodes($matcd, $batch, $conn);
// echo $step100, $step200, $step300, $step400;

$i = 0;
$z = count($resArray) -1;
$MatCode = '';
$Batch = '';

function generate_link1($Step_ID, $MatCode, $Batch, $Qty, $array) {
    // Step 1 Search Step ID
    $keys = array_keys(array_column($array, 'Step_ID'), $Step_ID);
    $new_array = array_map(function($k) use ($array){return $array[$k];}, $keys);
    // Step 2 Search Material Code
    $keys = array_keys(array_column($new_array, 'MaterialCode'), $MatCode);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    // Step 3 Search Batch
    $keys = array_keys(array_column($new_array, 'Batch'), $Batch);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    // echo json_encode($new_array);
    return $new_array;
}

function generate_link2($Step_ID, $MatCode, $Batch, $Qty, $array) {
    // Step 1 Search Step ID
    $keys = array_keys(array_column($array, 'Step_ID'), $Step_ID);
    $new_array = array_map(function($k) use ($array){return $array[$k];}, $keys);
    // Step 2 Search Material Code
    $keys = array_keys(array_column($new_array, 'RM_MaterialCode'), $MatCode);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    // Step 3 Search Batch
    $keys = array_keys(array_column($new_array, 'RM_Batch'), $Batch);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    if($Step_ID == 300) {
        // Step 3 Search Qty
        $keys = array_keys(array_column($new_array, 'RM_Quantity'), $Qty);
        $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    }
    return $new_array;
}

function generate_link3($Step_ID, $MatCode, $Batch, $Qty, $array) {
    // Step 1 Search Step ID
    $keys = array_keys(array_column($array, 'Step_ID'), $Step_ID);
    $new_array = array_map(function($k) use ($array){return $array[$k];}, $keys);
    // Step 2 Search Material Code
    $keys = array_keys(array_column($new_array, 'RM_MaterialCode'), $MatCode);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    // Step 3 Search Batch
    $keys = array_keys(array_column($new_array, 'RM_Batch'), $Batch);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    return $new_array;
}

foreach($resArray as $nodes) {

    $MatCode = $nodes['MaterialCode'];
    $Batch = $nodes['Batch'];
    $Qty = $nodes['Quantity'];
    if($i == 0) {

        $link_array = generate_link1(200, $MatCode, $Batch, $Qty, $resArray);
        $link_count = 0;
        foreach($link_array as $link) {
            if($link_count == 0) {
                $json_array = [
                    'nodes' => [
                        [
                            'id' => $resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
                            'group' => $nodes['Step_ID'],
                            'detail' => $nodes['UUID'],
                            'description' => $nodes['Description'],
                            'material' => $nodes['MaterialDescription']
                        ],
                    ],
                    'links' => [
                        [
                            'source'=>$nodes['UUID'],
                            'target'=>$link['UUID'],
                            'value' => $i + 1
                        ],
                    ]
                ];    
            }
            else {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$link['UUID'],
                    'value' => $i + 1
                ]);
            }
            $link_count++;
        }
        
    }
    else {

        array_push($json_array['nodes'], [
            'id'=>$resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
            'group' => $nodes['Step_ID'],
            'detail' => $nodes['UUID'],
            'description' => $nodes['Description'],
            'material' => $nodes['MaterialDescription']
        ]);
        
        if($nodes['Step_ID'] == '200' ) {

            $link_array = generate_link2(300, $MatCode, $Batch, $Qty, $resArray);
            foreach($link_array as $link) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$link['UUID'],
                    'value' => $i
                ]);
            }
                
        }
        if($nodes['Step_ID'] == '300' ) {

            $link_array = generate_link3(300, $MatCode, $Batch, $Qty, $resArray);
            foreach($link_array as $link) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$link['UUID'],
                    'value' => $i
                ]);
            }
            $link_array = generate_link1(400, $MatCode, $Batch, $Qty, $resArray);
            foreach($link_array as $link) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$link['UUID'],
                    'value' => $i
                ]);
            }

        }
    }
   
    $i++;
}

echo json_encode($json_array,JSON_PRETTY_PRINT);

mysqli_close($conn);

?>
