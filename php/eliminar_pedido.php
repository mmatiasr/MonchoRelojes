<?php
session_start();
require_once("libs/baseDatos.php");

if (!isset($_SESSION['admin']) || $_SESSION['admin'] !== true) {
    header("Location: index.php");
    exit();
}

$pedido_id = filter_input(INPUT_POST, 'pedido_id', FILTER_VALIDATE_INT);
if (!$pedido_id) {
    header("Location: pedidos.php");
    exit();
}

$conexion = conectar();

$delete_detalle = "DELETE FROM detalle WHERE codigo_pedido = ?";
$stmt1 = mysqli_prepare($conexion, $delete_detalle);
mysqli_stmt_bind_param($stmt1, "i", $pedido_id);
mysqli_stmt_execute($stmt1);
mysqli_stmt_close($stmt1);

$delete_pedido = "DELETE FROM pedidos WHERE codigo = ?";
$stmt2 = mysqli_prepare($conexion, $delete_pedido);
mysqli_stmt_bind_param($stmt2, "i", $pedido_id);
mysqli_stmt_execute($stmt2);
mysqli_stmt_close($stmt2);

desconectar($conexion);
header("Location: pedidos.php");
?>
