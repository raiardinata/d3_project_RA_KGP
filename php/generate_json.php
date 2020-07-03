<?php
    include 'db_conn.php';
    // Create connection
	$conn = mysqli_connect($servername, $username, $password, $dbname);
	// Check connection
	if (!$conn) {
	    die('Connection failed: ' . mysqli_connect_error());
    }

    $header_query   =   '';
    // $res1 	= mysqli_query($conn, $header_query);
    
    $json_array = [
        'nodes' => [
            ['id' => 'Material A', 'group' => '0', 'detail' => 'Detail from Material A'],
            ['id' => 'Inv. Transfer A', 'group' => '1', 'detail' => 'Detail from Inv. Trans. A']
        ],
        'links' => [
            ['source' => 'Material A', 'target' => 'Inv. Transfer A', 'value' => '1']
        ]
    ];

    //push into nodes
    array_push($json_array['nodes'], ['id'=>'Inv. Transfer B','group'=>'2','detail'=>'Detail from Inv. Transfer B']);
    array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.1", "group"=> 2, "detail"=> "kfc"]);
    array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.2", "group"=> 2, "detail"=> "kfc"]);
    array_push($json_array['nodes'], ["id"=> "Inv. Transfer A.3", "group"=> 2, "detail"=> "kfc"]);
    array_push($json_array['nodes'], ["id"=> "Shipping", "group"=> 5, "detail"=> "kyt"]);
    array_push($json_array['nodes'], ["id"=> "Prod. A", "group"=> 3, "detail"=> "fde"]);

    //push into links
    array_push($json_array['links'], ['source'=>'Inv. Transfer A','target'=>'Inv. Transfer A.1','value'=>'1']);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer A', 'target'=> 'Inv. Transfer A.2', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer A', 'target'=> 'Inv. Transfer A.3', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Prod. A', 'target'=> 'Inv. Transfer B', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer B', 'target'=> 'Shipping', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer A.1', 'target'=> 'Prod. A', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer A.2', 'target'=> 'Prod. A', 'value'=> 1]);
    array_push($json_array['links'], ['source'=> 'Inv. Transfer A.3', 'target'=> 'Prod. A', 'value'=> 1]);

    $retVal 		=   json_encode($json_array);
    echo $retVal;
	mysqli_close($conn);
?>