<?php
require_once '../Config/server.php';
header("Access-Control-Allow-Origin: *");

$obj = new Server();

$title = $_POST['title'];
$id = (int)$_POST['id'];

$obj->connection()->query("UPDATE todo SET title='" . $title . "' WHERE id = '" . $id . "' ");

