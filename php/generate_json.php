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

$stepsID = "";
$json_array = [];
function loop_nodes($a, $b, $c)
{
    $db_array = [];
    $trans_query = "
        WITH RECURSIVE
            tbl_transaksiCTE (
                UUID, Step_ID, Description, 
                LineNo, MaterialCode, Batch, 
                RM_MaterialCode, RM_Batch, MaterialDescription, 
                RM_MaterialDescription, `Key`, Prod_Grp
            )
            AS
            (
                SELECT 
                    UUID, a.Step_ID, Description, 
                    LineNo, MaterialCode, Batch, 
                    RM_MaterialCode, RM_Batch, MaterialDescription, 
                    RM_MaterialDescription, `Key`, Prod_Grp
                FROM
                    tbl_transaksi a
                    INNER JOIN mstr_step b ON b.Step_ID = a.Step_ID
                WHERE 
                    (a.MaterialCode = '$a' AND a.Batch = '$b')
                    OR (a.RM_MaterialCode = '$a' AND a.RM_Batch = '$b')
                
                UNION ALL
                
                SELECT 
                    d.UUID, d.Step_ID, e.Description, 
                    d.LineNo, d.MaterialCode, d.Batch, 
                    d.RM_MaterialCode, d.RM_Batch, d.MaterialDescription, 
                    d.RM_MaterialDescription, d.`Key`, d.Prod_Grp
                FROM 
                    tbl_transaksiCTE c
                    INNER JOIN tbl_transaksi d ON
                        (
                            (d.RM_MaterialCode = c.MaterialCode AND d.RM_Batch = c.Batch)
                        )
                    INNER JOIN mstr_step e ON e.Step_ID = d.Step_ID
            )
        SELECT
            a.UUID, a.Step_ID, c.Description, 
            a.LineNo, a.MaterialCode, a.Batch, 
            a.RM_MaterialCode, a.RM_Batch, a.MaterialDescription, 
            a.RM_MaterialDescription, a.`Key`, a.Prod_Grp
        FROM
            tbl_transaksiCTE b
            JOIN tbl_transaksi a ON 
                (a.MaterialCode = b.MaterialCode AND a.Batch = b.Batch)
                OR (a.RM_MaterialCode = b.MaterialCode AND a.RM_Batch = b.Batch)
                OR (a.MaterialCode = b.RM_MaterialCode AND a.Batch = b.RM_Batch)
                OR (a.RM_MaterialCode = b.RM_MaterialCode AND a.RM_Batch = b.RM_Batch)
            INNER JOIN mstr_step c ON c.Step_ID = a.Step_ID
        GROUP BY a.UUID
        ORDER BY a.Step_ID ASC
    ";

    $i = 0;
    $trans_res = mysqli_query($c, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        array_push($db_array, $row);
    }
    return $db_array;
}

$resArray = loop_nodes($matcd, $batch, $conn);

$i = 0;
$z = count($resArray) -1;
$MatCode = '';
$Batch = '';

function generate_link1($Step_ID, $MatCode, $Batch, $array) {
    // Step 1 Search Step ID
    $keys = array_keys(array_column($array, 'Step_ID'), $Step_ID);
    $new_array = array_map(function($k) use ($array){return $array[$k];}, $keys);
    // Step 2 Search Material Code
    $keys = array_keys(array_column($new_array, 'MaterialCode'), $MatCode);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    // Step 3 Search Batch
    $keys = array_keys(array_column($new_array, 'Batch'), $Batch);
    $new_array = array_map(function($k) use ($new_array){return $new_array[$k];}, $keys);
    return $new_array;
}

function generate_link2($Step_ID, $MatCode, $Batch, $array) {
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
    if($i == 0) {

        if($nodes['Step_ID'] == '100' ) {

            $new_array = generate_link1(200, $MatCode, $Batch, $resArray);
            if($new_array) {
                $json_array = [
                    'nodes' => [
                        [
                            'id' => $resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
                            'group' => $nodes['Step_ID'],
                            'detail' => $nodes['UUID'],
                            'description' => $nodes['Description']
                        ],
                    ],
                    'links' => [
                        [
                            'source'=>$nodes['UUID'],
                            'target'=>$new_array[0]['UUID'],
                            'value' => $i + 1
                        ],
                    ]
                ];                
            }
        }
    }
    else {

        array_push($json_array['nodes'], [
            'id'=>$resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
            'group' => $nodes['Step_ID'],
            'detail' => $nodes['UUID'],
            'description' => $nodes['Description']
        ]);

        if ($i == $z){
            break;
        }
        
        if($nodes['Step_ID'] == '200' ) {

            $new_array = generate_link2(300, $MatCode, $Batch, $resArray);
            if($new_array) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$new_array[0]['UUID'],
                    'value' => $i
                ]);
            }
        }
        if($nodes['Step_ID'] == '300' ) {

            $new_array = generate_link2(300, $MatCode, $Batch, $resArray);
            if($new_array) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$new_array[0]['UUID'],
                    'value' => $i
                ]);
            }
            $new_array = generate_link1(400, $MatCode, $Batch, $resArray);
            if($new_array) {
                array_push($json_array['links'], [
                    'source'=>$nodes['UUID'],
                    'target'=>$new_array[0]['UUID'],
                    'value' => $i
                ]);
            }

        }
    }
   
    $i++;
}

// echo json_encode($json_array, JSON_PRETTY_PRINT);
// $json_array = [
//     'nodes' => [
//         ['id' => 'Material A', 'group' => '0', 'detail' => 'Detail from Material A'],
//         ['id' => 'Inv. Transfer A', 'group' => '1', 'detail' => 'Detail from Inv. Trans. A']
//     ],
//     'links' => [
//         ['source' => 'Material A', 'target' => 'Inv. Transfer A', 'value' => '1']
//     ]
// ];

//push into nodes
// array_push($json_array['nodes'], ['id'=>'Inv. Transfer B','group'=>'2','detail'=>'Detail from Inv. Transfer B']);
// array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.1", "group"=> 2, "detail"=> "kfc"]);
// array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.2", "group"=> 2, "detail"=> "kfc"]);
// array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.3", "group"=> 2, "detail"=> "kfc"]);
// array_push($json_array['nodes'], ["id"=> "Shipping", "group"=> 5, "detail"=> "kyt"]);
// array_push($json_array['nodes'], ["id"=> "Prod. A", "group"=> 3, "detail"=> "fde"]);

//push into links
// // array_push($json_array['links'], ['source'=>'Inv. Transfer A','target'=>'Inv. Transfer A.1','value'=>'1']);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer A', 'target'=> 'Inv. Transfer A.2', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer A', 'target'=> 'Inv. Transfer A.3', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Prod. A', 'target'=> 'Inv. Transfer B', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer B', 'target'=> 'Shipping', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer A.1', 'target'=> 'Prod. A', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer A.2', 'target'=> 'Prod. A', 'value'=> 1]);
// // array_push($json_array['links'], ['source'=> 'Inv. Transfer A.3', 'target'=> 'Prod. A', 'value'=> 1]);

// echo json_encode($resArray,JSON_PRETTY_PRINT);
$fp = fopen('../json/generate_json.json', 'w');
fwrite($fp, json_encode($json_array,JSON_PRETTY_PRINT));
fclose($fp);

// echo 'ok';
mysqli_close($conn);
