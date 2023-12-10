<?php
require_once '../Config/server.php';
header("Access-Control-Allow-Origin: *");
try {
    $obj = new Server();

    $profilName = $_POST['profileName'];
    $profilData = $_POST['profileData'];
    $id = $_POST['user_id'];

    $path = "../uploads/$profilName";

    $user_id = (int)$id;

    $obj->connection()->query("UPDATE users SET profile='" . $path . "' WHERE id = '" . $user_id . "' ");

    file_put_contents($path, base64_decode($profilData));
} catch (Exception $e) {
    echo json_encode("FAILED");
}
