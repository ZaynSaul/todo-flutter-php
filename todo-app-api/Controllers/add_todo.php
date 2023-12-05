<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

try {
    $obj = new Server();
    $title = $_POST['title'];
    $user_id = $_POST['user_id'];

    $uid = (int)$user_id;

    $obj->connection()->query("INSERT INTO todo(title, user_id) VALUES ('" . $title . "', '" . $user_id . "') ");
} catch (Exception $e) {
    echo json_encode("FAILED");
}
