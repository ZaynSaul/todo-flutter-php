<?php

require_once '../Config/server.php';
header("Access-Control-Allow-Origin: *");

$obj = new Server();
$list = array();

$todo_id = $_POST['todo_id'];

$t_id = (int)$todo_id;

$result = $obj->connection()->query("SELECT * FROM todo_item WHERE todo_id = '" . $t_id . "'  ORDER BY id DESC");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}


