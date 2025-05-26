<?php
session_start();
require_once('libs/baseDatos.php');
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}


$conexion = conectar();
$productos = mysqli_query($conexion, "SELECT * FROM productos");
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
    <title>Administrar Productos</title>
</head>
<ul>
        <li><a href="usuarios.php">Usuarios</a></li>
        <li><a href="admin_productos.php">Productos</a></li>
        <li><a href="admin_pedidos.php">Pedidos</a></li>
    </ul>
<h2>Gestión de Productos</h2>
<?php if (isset($_SESSION['mensaje'])): ?>
    <p style="color: green; font-weight: bold;">
        <?= htmlspecialchars($_SESSION['mensaje']) ?>
    </p>
    <?php unset($_SESSION['mensaje']); ?>
<?php endif; ?>

<a href="admin_nuevo_producto.php">+ Añadir nuevo producto</a>
<table border="1">
    <tr>
        <th>Código</th><th>Descripción</th><th>Precio</th><th>Existencias</th><th>Acciones</th>
    </tr>
    <?php while ($p = mysqli_fetch_assoc($productos)) { ?>
        <tr>
            <td><?= $p['codigo'] ?></td>
            <td><?= $p['descripcion'] ?></td>
            <td><?= $p['precio'] ?></td>
            <td><?= $p['existencias'] ?></td>
            <td>
                <a href="admin_modificar_producto.php?codigo=<?= $p['codigo'] ?>">Modificar</a>
                |
                <a href="admin_eliminar_producto.php?codigo=<?= $p['codigo'] ?>" 
                   onclick="return confirm('¿Estás seguro de eliminar este producto?')">Eliminar</a>
            </td>
        </tr>
    <?php } ?>
</table>
<form method="post" action="dashboard.php">
    <button type="submit">Volver al panel</button>
  </form>
<form method="post" action="logout.php">
    <button type="submit">Cerrar sesión</button>
  </form>
<?php desconectar($conexion); ?>

