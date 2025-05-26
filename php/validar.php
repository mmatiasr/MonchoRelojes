<?php
session_start();
require_once("libs/baseDatos.php");

$usuario = filter_input(INPUT_POST, 'usuario', FILTER_SANITIZE_STRING);
$clave = filter_input(INPUT_POST, 'clave', FILTER_SANITIZE_STRING);

if ($usuario && $clave) {
    $conexion = conectar();

    $consulta = "SELECT codigo, clave, admin FROM usuarios WHERE usuario=? AND activo=1";
    $stmt = mysqli_prepare($conexion, $consulta);
    mysqli_stmt_bind_param($stmt, "s", $usuario);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $codigo, $claveHash, $esAdmin);
    
    if (mysqli_stmt_fetch($stmt)) {

        if (hash('sha256', $clave) === $claveHash) {
            if ($esAdmin == 1) {
                $_SESSION['admin_id'] = $codigo;
                header("Location: dashboard.php");
                exit();
            } else {
                $_SESSION['error'] = "Acceso denegado: no eres administrador.";
            }
        } else {
            $_SESSION['error'] = "Usuario o contraseña incorrectos.";
        }
    } else {
        $_SESSION['error'] = "Usuario no encontrado o desactivado.";
    }

    mysqli_stmt_close($stmt);
    desconectar($conexion);
} else {
    $_SESSION['error'] = "Usuario o clave vacíos.";
}

header("Location: index.php");
exit();
