<?php

require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

$obj = new Server();


$id = $_POST['todo_id'];
$todo_id =(int)$id;

$list = array();
$result = $obj->connection()->query("SELECT * FROM todo_item WHERE todo_id = '" .$todo_id. "' AND is_done = 1");
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $list[] = $row;
    }
    echo json_encode($list);
}
