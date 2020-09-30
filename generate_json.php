<?php
include 'db_conn.php';
$matcd = $_POST['mtcd'];
$batch = $_POST['batc'];
// $matcd = '8994016003525';
// $batch = '0207MC02';

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
                Batch, Quantity, 
                    UoM, RM_MaterialCode, 
                RM_MaterialDescription, RM_Batch,
                RM_Quantity, RM_UoM, 
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
                tbl_ts.Batch, tbl_ts.Quantity, 
                    tbl_ts.UoM, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch,
                tbl_ts.RM_Quantity, tbl_ts.RM_UoM, 
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
                Batch, Quantity, 
                    UoM, RM_MaterialCode, 
                RM_MaterialDescription, RM_Batch, 
                RM_Quantity, RM_UoM, 
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
                tbl_ts.Batch, tbl_ts.Quantity, 
                    tbl_ts.UoM, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch, 
                tbl_ts.RM_Quantity, tbl_ts.RM_UoM, 
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
                tbl_ts.Batch, tbl_ts.Quantity, 
                    tbl_ts.UoM, tbl_ts.RM_MaterialCode, 
                tbl_ts.RM_MaterialDescription, tbl_ts.RM_Batch, 
                tbl_ts.RM_Quantity, tbl_ts.RM_UoM, 
                tbl_ts.CustomerID, tbl_ts.CustomerName,
                tbl_ts.ShiptoID, tbl_ts.ShiptoName,
                e.Description, e.Step_ID
            FROM
                tbl_transaksiINB cte
                INNER JOIN tbl_transaksi tbl_ts
                    ON tbl_ts.MaterialCode = cte.MaterialCode AND tbl_ts.Batch = cte.Batch
            INNER JOIN mstr_step e 
                    ON e.Step_ID = tbl_ts.Step_ID
        )
        SELECT final.*
        FROM (
			  SELECT * FROM tbl_transaksiBASE
	        UNION
	        SELECT * FROM tbl_transaksiPRD
	        UNION
	        SELECT * FROM tbl_transaksiINB
	     ) AS final
        GROUP BY final.Step_ID
        ORDER BY final.Step_ID ASC
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
                        'uom' => $row['UoM'],
                        'quantity' => $row['Quantity'],
                        'rm_material_code' => $row['RM_MaterialCode'],
                        'rm_batch' => $row['RM_Batch'],
                        'rm_uom' => $row['RM_UoM'],
                        'rm_quantity' => $row['RM_Quantity'],
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
                    'uom' => $row['UoM'],
                    'quantity' => $row['Quantity'],
                    'rm_material_code' => $row['RM_MaterialCode'],
                    'rm_batch' => $row['RM_Batch'],
                    'rm_uom' => $row['RM_UoM'],
                    'rm_quantity' => $row['RM_Quantity'],
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

$n = 0;
foreach($nodesArray as $nodes1) {
    // CREATE THE LINK
    foreach($nodes1 as $nodes) {
        // array search nodes make a link
        $key = false;
        $search = [
            'material_code' => $nodes['material_code'],
            'batch' => $nodes['batch'],
            'quantity' => $nodes['quantity'],
            'uom' => $nodes['uom'],
            'rm_material_code' => $nodes['rm_material_code'],
            'rm_batch' => $nodes['rm_batch'],
            'rm_quantity' => $nodes['rm_quantity'],
            'rm_uom' => $nodes['rm_uom'],
            'group' => $nodes['group']
        ];
        if($nodes['group'] == '100'){
            foreach ($nodes1 as $k => $v) {
                if (
                    $v['group'] == '200'
                ) {
                    $key = $k;
                    // key found - break the loop
                    if(empty($linkArray)) {
                        $linkArray = [
                            'links' => [
                                [
                                    'source'=>$nodes['id'],
                                    'target'=>$v['id'],
                                    'step'=>$search['group'] . 'to' . $v['group'],
                                    'value' => $n + 1
                                ],
                            ]
                        ];
                    }
                    else {
                        array_push($linkArray['links'], [
                            'source'=>$nodes['id'],
                            'target'=>$v['id'],
                            'step'=>$search['group'] . 'to' . $v['group'],
                            'value' => $n + 1
                        ]);
                    }
                    break;
                }
            }
        }
        else if($nodes['group'] == '200') {
            foreach ($nodes1 as $k => $v) {
                if (
                    $v['group'] == '300'
                ) {
                    $key = $k;
                    // key found - break the loop
                    array_push($linkArray['links'], [
                        'source'=>$nodes['id'],
                        'target'=>$v['id'],
                        'step'=>$search['group'] . 'to' . $v['group'],
                        'value' => $n + 1
                    ]);
                    break;
                }
            }
        }
        else if($nodes['group'] == '300') {
            foreach ($nodes1 as $k => $v) {
                if (
                    $v['group'] == '350'
                ) {
                    $key = $k;
                    // key found - break the loop
                    array_push($linkArray['links'], [
                        'source'=>$nodes['id'],
                        'target'=>$v['id'],
                        'step'=>$search['group'] . 'to' . $v['group'],
                        'value' => $n + 1
                    ]);
                    break;
                }
                else if(
                    $v['group'] == '400'
                ) {
                    $key = $k;
                    // key found - break the loop
                    array_push($linkArray['links'], [
                        'source'=>$nodes['id'],
                        'target'=>$v['id'],
                        'step'=>$search['group'] . 'to' . $v['group'],
                        'value' => $n + 1
                    ]);
                    break;
                }
            }
        }
        else if($nodes['group'] == '350') {
            foreach ($nodes1 as $k => $v) {
                if (
                    $v['group'] == '400'
                ) {
                    $key = $k;
                    // key found - break the loop
                    array_push($linkArray['links'], [
                        'source'=>$nodes['id'],
                        'target'=>$v['id'],
                        'step'=>$search['group'] . 'to' . $v['group'],
                        'value' => $n + 1
                    ]);
                    break;
                }
            }
        }
        $n++;
    }
}
$jsonArray = [];
$jsonArray = $nodesArray + $linkArray;
echo json_encode($jsonArray,JSON_PRETTY_PRINT);

mysqli_close($conn);

?>