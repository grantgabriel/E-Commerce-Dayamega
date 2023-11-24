<?php
    if (!isset($_SESSION)) {
        session_start();
    }

    $host = 'localhost';
    $user = 'root';
    $pass = '';
    $database = 'e-commerce-dayamega';

    $connect = mysqli_connect($host, $user, $pass, $database);

    if ($connect->connect_error) {
        die("Koneksi Gagal".$connect->connect_error);
    }
?>