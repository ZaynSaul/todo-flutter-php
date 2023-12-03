<?php
require_once '../Config/server.php';

header("Access-Control-Allow-Origin: *");

$obj = new Server();

$email = $_POST['email'];
$password = $_POST['password'];
$new_password = $_POST['new_password'];

$sql = "SELECT * FROM users WHERE email = '" . $email . "'";

$query = mysqli_query($obj->connection(), $sql);

$userData = array();
$count = mysqli_num_rows($query);
$data = mysqli_fetch_array($query);

if ($new_password === $password) {
    echo json_encode("THE_SAME");
} else {

    $password_hash = password_hash($new_password, PASSWORD_DEFAULT);


    $update = "UPDATE users SET password='".$password_hash."' WHERE email = '".$email."' ";
    $result = mysqli_query($obj->connection(), $update);
    if ($result) {
        
        echo json_encode("password_updated");
    }else {
        echo json_encode("FAILED");
    }
}
