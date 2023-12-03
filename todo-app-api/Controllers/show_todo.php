<?php

require_once '../Config/server.php';
header("Access-Control-Allow-Origin: *");

$obj = new Server();
$list = array();

$user_id = $_POST['user_id'];

$result = $obj->connection()->query("SELECT * FROM todo WHERE user_id = '" . $user_id . "'  ORDER BY id DESC");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}

