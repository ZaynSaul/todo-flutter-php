<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

try {
    $obj = new Server();

    $id = (int)$_POST['id'];

    $obj->connection()->query("DELETE FROM todo  WHERE id = '" . $id . "' ");
} catch (Exception $e) {
    echo json_encode("FAILED");
}
