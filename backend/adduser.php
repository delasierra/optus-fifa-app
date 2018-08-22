<?php

date_default_timezone_set('Etc/UTC');

$servername = "optussportfifachallenge.com:2083";
$username = "optusspo_yb";
$password = "5MLtZOSKlw2s";
$dbname = "optusspo_fifa-app";

//vars
$tabletId=$_POST["tabletId"];
$name=$_POST["name"];
$dob=$_POST["dob"];
$dni=$_POST["mobile"];
$address=$_POST["email"];
$postcode=$_POST["terms"];
$city=$_POST["promo"];
$province=$_POST["levels_scored"];
$phone=$_POST["quiz_completed"];
$user_quitted=$_POST["user_quitted"];
$date=$_POST["date"];

$last_insert=0;

// Create connection
$conn = mysql_connect($servername, $username, $password);

// echo 'buuuu';

mysql_select_db($dbname, $conn);

mysql_set_charset('utf8', $conn);

// Check connection
if ($conn->connect_error) {
	echo json_encode(array('msg'=>'ERROR', 'type' => 'not connection to data base' ));
    die("Connection Error: " . $conn->connect_error);
}

//write in DB
$sql = "INSERT INTO user (tabletId, name, dob, mobile, email, terms, promo, levels_scored, quiz_completed, user_quitted, date)
		VALUES ('".$tabletId."','".$name."', '".$dob."', '".$mobile."', '".$email."', '".$terms."', '".$promo."', '".$levels_scored."', '".$quiz_completed."', '".$user_quitted."', '".$date."')";
		
mysql_query($sql, $conn);
$last_insert=mysql_insert_id();

mysql_close($conn);

echo json_encode(array('status' => 'OK', 'msg' => 'email sent successfully'.$date));
?>

