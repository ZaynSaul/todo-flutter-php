<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

$obj = new Server();

$name = $_POST['name'];
$email = strtolower($_POST['email']);
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email = '" . $email . "'";

$query = mysqli_query($obj->connection(), $sql);

$userData = array();
$count = mysqli_num_rows($query);


if ($count == 1) {
    echo json_encode("TAKEN");
} else {

    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    $full_name = ucwords($name);

    $insert = "INSERT INTO users(name, email, password) VALUES ('" . $full_name . "', '" . $email . "', '" . $password_hash . "') ";
    $result = mysqli_query($obj->connection(), $insert);
    if ($result) {
        $sql = "SELECT * FROM users WHERE email = '" . $email . "'";

        $query = mysqli_query($obj->connection(), $sql);

        $data = mysqli_fetch_array($query);

        $userData = $data;
        echo json_encode($userData);
    }else {
        echo json_encode("FAILED");
    }
}
