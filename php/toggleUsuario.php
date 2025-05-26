<?php
session_start();
require_once("libs/baseDatos.php");

if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

$codigo = filter_input(INPUT_POST, 'codigo', FILTER_VALIDATE_INT);
if ($codigo) {
    $conexion = conectar();
    $sql = "UPDATE usuarios SET activo = NOT activo WHERE codigo=?";
    $stmt = mysqli_prepare($conexion, $sql);
    mysqli_stmt_bind_param($stmt, "i", $codigo);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
    desconectar($conexion);
}

header("Location: usuarios.php");
exit();
