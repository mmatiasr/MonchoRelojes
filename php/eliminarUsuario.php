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

    // comprobar si tiene pedidos
    $sqlCheck = "SELECT COUNT(*) FROM pedidos WHERE persona=?";
    $stmtCheck = mysqli_prepare($conexion, $sqlCheck);
    mysqli_stmt_bind_param($stmtCheck, "i", $codigo);
    mysqli_stmt_execute($stmtCheck);
    mysqli_stmt_bind_result($stmtCheck, $num);
    mysqli_stmt_fetch($stmtCheck);
    mysqli_stmt_close($stmtCheck);

    if ($num == 0) {
        $sqlDelete = "DELETE FROM usuarios WHERE codigo=?";
        $stmtDel = mysqli_prepare($conexion, $sqlDelete);
        mysqli_stmt_bind_param($stmtDel, "i", $codigo);
        mysqli_stmt_execute($stmtDel);
        mysqli_stmt_close($stmtDel);
    }
    else {
        $_SESSION['error'] = "No se puede eliminar el usuario porque tiene pedidos asociados.";
    }

    desconectar($conexion);
}

header("Location: usuarios.php");
exit();
