<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");
$obj = new Server();

$isDone = (int)$_POST['is_done'];

$id = (int)$_POST['id'];

$obj->connection()->query("UPDATE todo SET is_done='".$isDone."' WHERE id = '".$id."' ");
