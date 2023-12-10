<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

try {
    $obj = new Server();

    foreach ($_POST['id'] as $deleteId) {

        $obj->connection()->query("DELETE FROM todo  WHERE id = '" . (int)$deleteId . "' ");
    }

    foreach ($_POST['id'] as $deleteItemId) {
        $obj->connection()->query("DELETE FROM todo_item  WHERE todo_id = '" . (int)$deleteItemId . "' ");
    }
} catch (Exception $e) {
    echo json_encode("FAILED");
}
