<?php

class Server
{

    private $hostName = "localhost";
    private $usrName = "root";
    private $pass = "";
    private $dbName = "todoappdb";

    public function connection()
    {

        $server = new mysqli($this->hostName, $this->usrName, $this->pass, $this->dbName);

        if ($server->connect_errno) {
            printf('failed database connection' . $server->connect_errno);
            exit();
        }
        return $server;
    }
}
