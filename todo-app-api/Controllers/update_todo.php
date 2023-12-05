<?php
require_once '../Config/server.php';
header("Access-Control-Allow-Origin: *");
try {
    $obj = new Server();

    $title = $_POST['title'];
    $id = $_POST['id'];

    $todo_id = (int)$id;
    $obj->connection()->query("UPDATE todo SET title='" . $title . "' WHERE id = '" . $todo_id . "' ");
} catch (Exception $e) {
    echo json_encode("FAILED");
}
