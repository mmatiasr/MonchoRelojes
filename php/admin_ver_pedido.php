<?php
session_start();
require_once('libs/baseDatos.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}
$conexion = conectar();
$pedido_id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if (!$pedido_id) {
    header("Location: admin_pedidos.php");
    exit();
}

// Cargamos info del pedido y productos
$sql = "SELECT p.fecha, p.importe, p.estado, u.usuario,
               pr.descripcion, d.unidades, d.precio_unitario
        FROM pedidos p
        JOIN usuarios u ON p.persona = u.codigo
        JOIN detalle d ON p.codigo = d.codigo_pedido
        JOIN productos pr ON d.codigo_producto = pr.codigo
        WHERE p.codigo = ?";

$stmt = mysqli_prepare($conexion, $sql);
mysqli_stmt_bind_param($stmt, "i", $pedido_id);
mysqli_stmt_execute($stmt);
$resultado = mysqli_stmt_get_result($stmt);

$pedido = null;
$productos = [];

while ($row = mysqli_fetch_assoc($resultado)) {
    if (!$pedido) {
        $pedido = [
            'fecha' => $row['fecha'],
            'importe' => $row['importe'],
            'estado' => $row['estado'],
            'usuario' => $row['usuario'],
        ];
    }
    $productos[] = [
        'descripcion' => $row['descripcion'],
        'unidades' => $row['unidades'],
        'precio' => $row['precio_unitario']
    ];
}

mysqli_stmt_close($stmt);
desconectar($conexion);

if (!$pedido) {
    echo "Pedido no encontrado.";
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
</head>
<h2>Pedido #<?= $pedido_id ?></h2>
<p>Usuario: <?= $pedido['usuario'] ?></p>
<p>Fecha: <?= $pedido['fecha'] ?></p>
<p>Importe: <?= number_format($pedido['importe'], 2) ?> €</p>
<p>Estado actual: <?= $pedido['estado'] ?></p>

<h3>Productos:</h3>
<ul>
    <?php foreach ($productos as $p): ?>
        <li><?= $p['descripcion'] ?> - <?= $p['unidades'] ?> uds. x <?= number_format($p['precio'], 2) ?> €</li>
    <?php endforeach; ?>
</ul>

<form method="post" action="cambiar_estado.php">
    <input type="hidden" name="pedido_id" value="<?= $pedido_id ?>">
    <label>Cambiar estado:</label>
    <select name="nuevo_estado" required>
        <option value="">-- Selecciona --</option>
        <option value="1" <?= $pedido['estado'] == 1 ? 'selected' : '' ?>>Procesando</option>
        <option value="2" <?= $pedido['estado'] == 2 ? 'selected' : '' ?>>Enviado</option>
        <option value="3" <?= $pedido['estado'] == 3 ? 'selected' : '' ?>>Entregado</option>
        <option value="4" <?= $pedido['estado'] == 4 ? 'selected' : '' ?>>Cancelado</option>
    </select>
    <button type="submit">Actualizar</button>
</form>

<?php if ($pedido['estado'] == 4): ?>
    <form method="post" action="eliminar_pedido.php" style="margin-top: 10px;">
        <input type="hidden" name="pedido_id" value="<?= $pedido_id ?>">
        <button type="submit" onclick="return confirm('¿Eliminar pedido cancelado?')">Eliminar Pedido</button>
    </form>
<?php endif; ?>

<br><a href="admin_pedidos.php">← Volver</a>
