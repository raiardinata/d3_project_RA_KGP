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

$json_array = [];
function loop_nodes($a, $b, $c)
{
    $link_array = [];
    $trans_query = "
        SELECT
        a.UUID U1, a.MaterialDescription s1, a.RM_MaterialDescription rs1, a.Step_ID
        , B.UUID U2, b.MaterialDescription s2, b.RM_MaterialDescription rs2, b.Step_ID
        , C.UUID U3, c.MaterialDescription s3, c.RM_MaterialDescription rs3, c.Step_ID
        , Z.UUID U4, z.MaterialDescription s4, z.RM_MaterialDescription rs4, z.Step_ID
        , D.UUID U5, d.MaterialDescription s5, d.RM_MaterialDescription rs5, d.Step_ID, d.CustomerName
        FROM tbl_transaksi a
        LEFT JOIN tbl_transaksi b ON a.MaterialCode = b.MaterialCode AND a.Batch = b.Batch AND b.Step_ID = 200
        LEFT JOIN tbl_transaksi c ON c.RM_MaterialCode = b.MaterialCode AND c.RM_Batch = b.Batch AND c.RM_Quantity = b.Quantity AND c.Step_ID = 300
        LEFT JOIN tbl_transaksi z ON z.RM_MaterialCode = c.MaterialCode AND z.RM_Batch = c.Batch AND c.RM_Quantity = b.Quantity AND  z.Step_ID = 300
        LEFT JOIN tbl_transaksi d ON d.MaterialCode = IF(z.MaterialCode IS NOT NULL, z.MaterialCode, c.MaterialCode) AND d.Batch = IF(z.Batch IS NOT NULL, z.Batch, c.Batch) AND d.Step_ID = 400
        WHERE
            a.Step_ID = 100 
            AND ( 
                (A.MaterialCode='$a' AND A.Batch = '$b')
                OR	(B.MaterialCode='$a' AND B.Batch = '$b')
                OR	(C.RM_MaterialCode='$a' AND C.RM_Batch = '$b')
                OR	(Z.RM_MaterialCode='$a' AND Z.RM_Batch = '$b')
                OR	(D.MaterialCode='$a' AND D.Batch = '$b')
            )
        GROUP BY
            U1, U2 ,U3, U5
    ";

    $i = 0;
    $trans_res = mysqli_query($c, $trans_query);
    while ($row = mysqli_fetch_assoc($trans_res)) {
        if($i == 0) {
            if($row['U1'] && $row['U2']) {
                $link_array = [
                    'links' => [
                        [
                            'source'=>$row['U1'],
                            'target'=>$row['U2'],
                            'value' => $i + 1
                        ]
                    ]
                ];
            }
            if($row['U2'] && $row['U3']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U2'],
                        'target'=>$row['U3'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U3'] && $row['U4']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U3'],
                        'target'=>$row['U4'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U3'] && $row['U5'] && is_null($row['U4'])) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U3'],
                        'target'=>$row['U5'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U4'] && $row['U5']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U4'],
                        'target'=>$row['U5'],
                        'value' => $i + 1
                    ]
                );
            }
        }
        else {
            if($row['U1'] && $row['U2']) {
            array_push($link_array['links'], 
                    [
                        'source'=>$row['U1'],
                        'target'=>$row['U2'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U2'] && $row['U3']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U2'],
                        'target'=>$row['U3'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U3'] && $row['U4']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U3'],
                        'target'=>$row['U4'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U3'] && $row['U5'] && !$row['U4']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U3'],
                        'target'=>$row['U5'],
                        'value' => $i + 1
                    ]
                );
            }
            if($row['U4'] && $row['U5']) {
                array_push($link_array['links'], 
                    [
                        'source'=>$row['U4'],
                        'target'=>$row['U5'],
                        'value' => $i + 1
                    ]
                );
            }
        }
        $i++;
    }
    return $link_array;
}

$linkArray = loop_nodes($matcd, $batch, $conn);
$nodesArray = [];
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
foreach($linkArray as $link) {
    foreach($link as $nodes) {
        if($n == 0) {
            $nodesArray = [
                'nodes' => [
                    [
                        'id'=>$nodes['source']
                    ]
                ]
            ];
            array_push($nodesArray['nodes'], 
            [
                'id'=>$nodes['target']
            ]
        );
        }
        else {
            array_push($nodesArray['nodes'], 
                [
                    'id'=>$nodes['source']
                ]
            );
            array_push($nodesArray['nodes'], 
                [
                    'id'=>$nodes['target']
                ]
            );
        }
        $n++;
    }
}
$nodesArray['nodes'] = unique_multidim_array($nodesArray['nodes'],'id');

$countNodes = 0;
foreach($nodesArray as $nodes) {
    foreach($nodes as $id) {
        $trans_query = "
            SELECT * FROM tbl_transaksi a INNER JOIN mstr_step b ON a.Step_ID = b.Step_ID WHERE UUID = '" . $id['id'] . "'
        ";
        $trans_res = mysqli_query($conn, $trans_query);
        while ($row = mysqli_fetch_assoc($trans_res)) {
            if($countNodes == 0) {
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
            $countNodes++;
        }
    }
}

$newArray = $nodesArray + $linkArray;
echo json_encode($newArray,JSON_PRETTY_PRINT);

mysqli_close($conn);

?>
