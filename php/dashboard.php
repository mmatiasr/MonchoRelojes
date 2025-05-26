<?php session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
    <title>Panel Administración</title>
</head>
<body>
    <ul>
        <li><a href="usuarios.php">Usuarios</a></li>
        <li><a href="admin_productos.php">Productos</a></li>
        <li><a href="admin_pedidos.php">Pedidos</a></li>
    </ul>
    <form method="post" action="logout.php">
        <button type="submit">Cerrar sesión</button>
    </form>


</body>
</html>
