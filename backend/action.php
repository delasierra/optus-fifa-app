<?php
/**
 * Created by PhpStorm.
 * User: csierra
 * Date: 21/3/18
 * Time: 16:14
 */

// Prevent caching.
// header('Cache-Control: no-cache, must-revalidate');
// header('Expires: Mon, 01 Jan 1996 00:00:00 GMT');
// The JSON standard MIME header.
// header('Content-type: application/json');

//vars
$tabletId=$_POST["tabletId"];
$name=$_POST["name"];
$dob=$_POST["dob"];
$mobile=$_POST["mobile"];
$email=$_POST["email"];
$terms=$_POST["terms"];
$promo=$_POST["promo"];
$levels_scored=$_POST["levels_scored"];
$quiz_completed=$_POST["quiz_completed"];
$user_quitted=$_POST["user_quitted"];
$date=$_POST["date"];

include 'AppService.php';
$app_service = new AppService;

$results = $app_service->saveUserData($tabletId, $name, $dob, $mobile, $email, $terms, $promo, $levels_scored, $quiz_completed, $user_quitted, $date);
if ($results > 0){
  $response['status'] = 'OK';
  $response['msg'] = 'data saved correctly';
}else{
  $response['status'] = 'FAIL';
  $response['msg'] = 'no code or type data';
}
echo json_encode($response);
