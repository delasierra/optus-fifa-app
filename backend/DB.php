<?php
class DB
{
    public $mysqli;

    public function connectDB(){
        $servername = "xxxx";
        $username = "xxxxxx";
        $password = "xxxxxx"; //
        $dbname = "optusspo_fifa-app";

        //        global $mysqli;
        $this->mysqli = new mysqli($servername, $username, $password, $dbname);

        if (mysqli_connect_errno()) {
            printf("Connect failed: %s\n", mysqli_connect_error());
            exit();
        }
    }

    public function disconnectDB()
    {
        //        global $mysqli;
        $this->mysqli->close();
    }
}
