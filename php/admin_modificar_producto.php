<?php
session_start();
require_once('libs/baseDatos.php');
    if (!isset($_SESSION['admin_id'])) {
        header("Location: index.php");
        exit();
    }

$conexion = conectar();
$codigo = filter_input(INPUT_GET, 'codigo', FILTER_VALIDATE_INT);

if (!$codigo) {
    echo "Producto inválido.";
    exit;
}

$res = mysqli_query($conexion, "SELECT * FROM productos WHERE codigo = $codigo");
$producto = mysqli_fetch_assoc($res);

if (!$producto) {
    echo "Producto no encontrado.";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $precio = filter_input(INPUT_POST, 'precio', FILTER_VALIDATE_FLOAT);
    $existencias = filter_input(INPUT_POST, 'existencias', FILTER_VALIDATE_INT);

    $update = mysqli_prepare($conexion, "UPDATE productos SET precio=?, existencias=? WHERE codigo=?");
    mysqli_stmt_bind_param($update, "dii", $precio, $existencias, $codigo);
    mysqli_stmt_execute($update);

    $_SESSION['mensaje'] = "Producto actualizado.";
    header("Location: admin_productos.php");
    exit;
}
?>
<link rel="stylesheet" href="css/admin.css">

<h2>Modificar Producto</h2>
<form method="post">
    <p><b>Código:</b> <?= $producto['codigo'] ?></p>
    <p><b>Descripción:</b> <?= htmlspecialchars($producto['descripcion']) ?></p>
    <p>Precio: <input type="number" step="0.01" name="precio" value="<?= $producto['precio'] ?>"></p>
    <p>Existencias: <input type="number" name="existencias" value="<?= $producto['existencias'] ?>"></p>
    <button type="submit">Guardar</button>
</form>
<a href="admin_productos.php">← Volver</a>
<?php desconectar($conexion); ?>
