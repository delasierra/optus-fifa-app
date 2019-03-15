<?php
include 'DB.php';

class AppService{
    public function saveUserData($tabletId, $name, $dob, $mobile, $email, $terms, $promo, $levels_scored, $quiz_completed, $user_quitted, $date)
    {

        $db = new DB;
        $db->connectDB();

        $sql = "INSERT INTO user ( tabletId, name, dob, mobile, email, terms, promo, levels_scored, quiz_completed, user_quitted, date )
          
             VALUES ('" . $tabletId . "', '" . $name . "', '" . $dob . "', '" . $mobile . "', '" . $email . "', '" . $terms . "', '" . $promo . "', '" . $levels_scored . "', '" . $quiz_completed . "', '" . $user_quitted . "', '" . $date . "')";

        $db->mysqli->query($sql);
        $result = mysqli_insert_id($db->mysqli);
        $db->disconnectDB();

        return $result;
    }
}


