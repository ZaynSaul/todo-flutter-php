<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

$obj = new Server();

$id = (int)$_POST['id'];
$title = $_POST['title'];
$description = $_POST['description'];

$obj->connection()->query("UPDATE todo_item SET title='".$title."', description= '".$description."' WHERE id = '".$id."' ");
