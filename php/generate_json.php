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
        -- STEP ID 100 & 200

        WITH RECURSIVE
            tbl_transaksiCTE (UUID, Step_ID, Description, LineNo, MaterialCode, Batch, RM_MaterialCode, RM_Batch, MaterialDescription, RM_MaterialDescription, `Key`, Prod_Grp)
            AS
            (
                SELECT UUID, tbl_transaksi.Step_ID, Description, LineNo, MaterialCode, Batch, RM_MaterialCode, RM_Batch, MaterialDescription, RM_MaterialDescription, `Key`, Prod_Grp
                FROM tbl_transaksi
                INNER JOIN mstr_step ON mstr_step.Step_ID = tbl_transaksi.Step_ID
                WHERE (tbl_transaksi.MaterialCode = '$a' AND tbl_transaksi.Batch = '$b')
                
                UNION ALL
                
                SELECT tbl_transaksi.UUID, tbl_transaksi.Step_ID, mstr_step.Description, tbl_transaksi.LineNo, tbl_transaksi.MaterialCode, tbl_transaksi.Batch, tbl_transaksi.RM_MaterialCode, tbl_transaksi.RM_Batch, tbl_transaksi.MaterialDescription, tbl_transaksi.RM_MaterialDescription, tbl_transaksi.`Key`, tbl_transaksi.Prod_Grp
                FROM tbl_transaksi
                INNER JOIN mstr_step ON mstr_step.Step_ID = tbl_transaksi.Step_ID
                JOIN tbl_transaksiCTE ON tbl_transaksi.RM_MaterialCode = tbl_transaksiCTE.MaterialCode
                    AND tbl_transaksi.RM_Batch = tbl_transaksiCTE.Batch
            )
        SELECT 
            *
        FROM
            tbl_transaksiCTE tblCTE
        GROUP BY UUID
    ";

    $trans_res = mysqli_query($c, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        array_push($db_array, $row);
    }
    return $db_array;
}

$resArray = loop_nodes($matcd, $batch, $conn);

$i = 0;
$z = count($resArray) -1;
foreach($resArray as $link) {
    if($i == 0) {
        $json_array = [
            'nodes' => [
                [
                    'id' => $resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
                    'group' => $link['Step_ID'],
                    'detail' => $link['UUID'],
                    'description' => $link['Description']
                ],
            ],
            'links' => [
                [
                    'source' => $resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
                    'target' => $resArray[$i + 1]['Step_ID'] . '-' . $resArray[$i + 1]['MaterialCode'] . '-' . $resArray[$i + 1]['Batch'] . '-' . $resArray[$i + 1]['MaterialDescription'],
                    'value' => $i
                ]
            ]
        ];
    }
    else {

        array_push($json_array['nodes'], [
            'id'=>$resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
            'group' => $link['Step_ID'],
            'detail' => $link['UUID'],
            'description' => $link['Description']
        ]);
        if ($i == $z){
            break;
        }
        array_push($json_array['links'], [
            'source'=>$resArray[$i]['Step_ID'] . '-' . $resArray[$i]['MaterialCode'] . '-' . $resArray[$i]['Batch'] . '-' . $resArray[$i]['MaterialDescription'],
            'target'=>$resArray[$i + 1]['Step_ID'] . '-' . $resArray[$i + 1]['MaterialCode'] . '-' . $resArray[$i + 1]['Batch'] . '-' . $resArray[$i + 1]['MaterialDescription'],
            'value' => $i
        ]);
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

$fp = fopen('../json/generate_json.json', 'w');
fwrite($fp, json_encode($json_array,JSON_PRETTY_PRINT));
fclose($fp);

// echo 'ok';
mysqli_close($conn);
