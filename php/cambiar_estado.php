<?php
session_start();
require_once("libs/baseDatos.php");

if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

$pedido_id = filter_input(INPUT_POST, 'pedido_id', FILTER_VALIDATE_INT);
$nuevo_estado = filter_input(INPUT_POST, 'nuevo_estado', FILTER_VALIDATE_INT);

if (!$pedido_id || !$nuevo_estado) {
    header("Location: admin_pedidos.php");
    exit();
}

$conexion = conectar();

if ($nuevo_estado == 4) {
    // Paso 1: leer todos los productos del pedido
    $sql = "SELECT codigo_producto, unidades FROM detalle WHERE codigo_pedido = ?";
    $stmt = mysqli_prepare($conexion, $sql);
    mysqli_stmt_bind_param($stmt, "i", $pedido_id);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $codigo_prod, $unidades);

    $productos = [];
    while (mysqli_stmt_fetch($stmt)) {
        $productos[] = ['codigo' => $codigo_prod, 'unidades' => $unidades];
    }
    mysqli_stmt_close($stmt);

    // Paso 2: actualizar stock una vez ya tenemos todos los datos
    foreach ($productos as $p) {
        $update = mysqli_prepare($conexion, "UPDATE productos SET existencias = existencias + ? WHERE codigo = ?");
        mysqli_stmt_bind_param($update, "ii", $p['unidades'], $p['codigo']);
        mysqli_stmt_execute($update);
        mysqli_stmt_close($update);
    }
}

// Cambiar estado del pedido
$updateEstado = "UPDATE pedidos SET estado = ? WHERE codigo = ?";
$stmt = mysqli_prepare($conexion, $updateEstado);
mysqli_stmt_bind_param($stmt, "ii", $nuevo_estado, $pedido_id);
mysqli_stmt_execute($stmt);
mysqli_stmt_close($stmt);

desconectar($conexion);
header("Location: admin_pedidos.php");
exit();
