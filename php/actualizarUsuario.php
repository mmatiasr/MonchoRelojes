<?php
session_start();
require_once("libs/baseDatos.php");

if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

$codigo = filter_input(INPUT_POST, 'codigo', FILTER_VALIDATE_INT);
$nombre = filter_input(INPUT_POST, 'nombre');
$apellidos = filter_input(INPUT_POST, 'apellidos');
$direccion = filter_input(INPUT_POST, 'direccion');
$telefono = filter_input(INPUT_POST, 'telefono');

if ($codigo && $nombre && $apellidos) {
    $conexion = conectar();
    $sql = "UPDATE usuarios SET nombre=?, apellidos=?, domicilio=?, telefono=? WHERE codigo=?";
    $stmt = mysqli_prepare($conexion, $sql);
    mysqli_stmt_bind_param($stmt, "ssssi", $nombre, $apellidos, $direccion, $telefono, $codigo);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
    desconectar($conexion);
}

header("Location: usuarios.php");
exit();
