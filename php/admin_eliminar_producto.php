<?php
session_start();
require_once('libs/baseDatos.php');
    if (!isset($_SESSION['admin_id'])) {
        header("Location: index.php");
        exit();
    }

$conexion = conectar();
$codigo = filter_input(INPUT_GET, 'codigo', FILTER_VALIDATE_INT);

// Verificamos si aparece en algún pedido
$res = mysqli_query($conexion, "SELECT COUNT(*) AS total FROM detalle WHERE codigo_producto = $codigo");
$data = mysqli_fetch_assoc($res);

if ($data['total'] > 0) {
    $_SESSION['mensaje'] = "No se puede eliminar: el producto aparece en pedidos.";
} else {
    mysqli_query($conexion, "DELETE FROM productos WHERE codigo = $codigo");
    $_SESSION['mensaje'] = "Producto eliminado correctamente.";
}

header("Location: admin_productos.php");
exit;
