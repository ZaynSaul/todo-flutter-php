<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

try {
    $obj = new Server();


    $id = (int)$_POST['id'];

    $sql = "SELECT * FROM todo_item  WHERE todo_id = '" . $id . "' AND is_done = 1";

    $query = mysqli_query($obj->connection(), $sql);

    $count = mysqli_num_rows($query);

    if ($count > 0) {
        $obj->connection()->query("DELETE FROM todo_item  WHERE todo_id = '" . $id . "' AND is_done = 1 ");
    }
} catch (Exception $e) {
    echo json_encode("FAILED");
}
