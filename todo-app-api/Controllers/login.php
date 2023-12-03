<?php

require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

$obj = new Server();


$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email = '" . $email . "'";

$query = mysqli_query($obj->connection(), $sql);
$data = mysqli_fetch_array($query);

$count = mysqli_num_rows($query);

if ($count == 1 && password_verify($password, $data['password'])) {

    $userData = $data;
    echo json_encode($userData);
} else {
    echo json_encode("ERROR");
}
