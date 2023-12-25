<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");
try {
    $obj = new Server();

    $id = (int)$_POST['id'];
    $title = ucfirst(trim($_POST['title']));
    $description = ucfirst(trim($_POST['description']));

    $obj->connection()->query("UPDATE todo_item SET title='" . $title . "', description= '" . $description . "' WHERE id = '" . $id . "' ");
} catch (Exception $e) {
    echo json_encode("FAILED");
}
