<?php

/**
 * Created by PhpStorm.
 * User: csierra
 * Date: 21/3/18
 * Time: 16:16
 */
class DB
{
    public $mysqli;

    public function connectDB(){
        $servername = "vmsh43.ha-node.net";
        $username = "optusspo_yb";
        $password = "5MLtZOSKlw2s"; // user optusspo_yb
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