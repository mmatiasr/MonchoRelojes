<?php
session_start();
require_once('libs/baseDatos.php');
    if (!isset($_SESSION['admin_id'])) {
        header("Location: index.php");
        exit();
    }

$conexion = conectar();
$mensaje = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $descripcion = trim(filter_input(INPUT_POST, 'descripcion'));
    $precio = filter_input(INPUT_POST, 'precio', FILTER_VALIDATE_FLOAT);
    $existencias = filter_input(INPUT_POST, 'existencias', FILTER_VALIDATE_INT);
    $imagen = trim(filter_input(INPUT_POST, 'imagen'));

    if ($descripcion && $precio !== false && $existencias !== false && $imagen) { //////////////
        $sql = mysqli_prepare($conexion, "INSERT INTO productos (descripcion, precio, existencias, imagen) VALUES (?, ?, ?, ?)");
        mysqli_stmt_bind_param($sql, "sdis", $descripcion, $precio, $existencias, $imagen);
        mysqli_stmt_execute($sql);

        $_SESSION['mensaje'] = "Producto añadido correctamente.";
        header("Location: admin_productos.php");
        exit;
    } else {
        $mensaje = "Todos los campos son obligatorios y deben ser válidos.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
</head>

<h2>Añadir Nuevo Producto</h2>

<?php if ($mensaje): ?>
    <p style="color:red;"><?= $mensaje ?></p>
<?php endif; ?>

<form method="post">
    <p>Descripción: <input type="text" name="descripcion" required></p>
    <p>Precio: <input type="number" step="0.01" name="precio" required></p>
    <p>Existencias: <input type="number" name="existencias" required></p>
    <p>Imagen (nombre del archivo): <input type="text" name="imagen" required></p>
    <button type="submit">Añadir Producto</button>
</form>

<a href="admin_productos.php">← Volver</a>

<?php desconectar($conexion); ?>
