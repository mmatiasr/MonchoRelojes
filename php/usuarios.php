<?php
session_start();
require_once("libs/baseDatos.php");

// Solo admins
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

$conexion = conectar();
$consulta = "SELECT u.codigo, u.usuario, u.nombre, u.apellidos, u.domicilio, u.telefono, u.activo FROM usuarios u WHERE admin=0";
$resultado = mysqli_query($conexion, $consulta);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
    <title>Administrar Usuarios</title>
</head>
<body>
    <ul>
        <li><a href="usuarios.php">Usuarios</a></li>
        <li><a href="admin_productos.php">Productos</a></li>
        <li><a href="admin_pedidos.php">Pedidos</a></li>
    </ul>
<h2>Listado de Usuarios</h2>
<table border="1">
    <tr>
        <th>Usuario</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>

    <?php while ($fila = mysqli_fetch_assoc($resultado)) { ?>
    <tr>
        <form method="post" action="actualizarUsuario.php">
            <td><input type="hidden" name="codigo" value="<?= $fila['codigo'] ?>">
                <?= htmlspecialchars($fila['usuario']) ?></td>
            <td><input type="text" name="nombre" value="<?= $fila['nombre'] ?>"></td>
            <td><input type="text" name="apellidos" value="<?= $fila['apellidos'] ?>"></td>
            <td><input type="text" name="direccion" value="<?= $fila['domicilio'] ?>"></td>
            <td><input type="text" name="telefono" value="<?= $fila['telefono'] ?>"></td>
            <td><?= $fila['activo'] ? "Activo" : "Inactivo" ?></td>
            <td>
                <button type="submit">Guardar</button>
        </form>

        <form method="post" action="toggleUsuario.php" style="display:inline">
            <input type="hidden" name="codigo" value="<?= $fila['codigo'] ?>">
            <button type="submit"><?= $fila['activo'] ? "Desactivar" : "Activar" ?></button>
        </form>

        <form method="post" action="eliminarUsuario.php" style="display:inline">
            <input type="hidden" name="codigo" value="<?= $fila['codigo'] ?>">
            <button type="submit" onclick="return confirm('¿Seguro que deseas eliminar este usuario?')">Eliminar</button>
        </form>
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
</body>
<?php
if (isset($_SESSION['error'])) {
    echo "<p style='color:red'>" . htmlspecialchars($_SESSION['error']) . "</p>";
    unset($_SESSION['error']);
}

if (isset($_SESSION['mensaje'])) {
    echo "<p style='color:green'>" . htmlspecialchars($_SESSION['mensaje']) . "</p>";
    unset($_SESSION['mensaje']);
}
?>

</html>

<?php
mysqli_free_result($resultado);
desconectar($conexion);
?>
