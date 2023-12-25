<?php

require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");
try {
    $obj = new Server();
    $title = ucfirst(trim($_POST['title']));
    $description = trim($_POST['description']);
    $todo_id = $_POST['todo_id'];

    $t_id = (int)$todo_id;



    $obj->connection()->query("INSERT INTO todo_item(title, description, todo_id) VALUES ('" . $title . "', '" . $description . "', '" . $t_id . "') ");
} catch (Exception $e) {
    echo json_encode("FAILED");
}

