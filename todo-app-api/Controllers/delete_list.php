<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

try {
    $obj = new Server();

    $id = $_POST['id'];

    $sql = "SELECT * FROM todo_item  WHERE todo_id = '" . $id . "'";

    $query = mysqli_query($obj->connection(), $sql);

    $count = mysqli_num_rows($query);


    $obj->connection()->query("DELETE FROM todo  WHERE id = '" . (int)$id . "' ");
    if ($count > 0) {

        $obj->connection()->query("DELETE FROM todo_item  WHERE todo_id = '" . (int)$id . "' ");
    }else {
        echo json_encode("ERROR");
    }
} catch (Exception $e) {
    echo json_encode("FAILED");
}
