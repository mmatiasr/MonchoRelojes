<?php
session_start();
require_once("libs/baseDatos.php");

if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

$conexion = conectar();

// Obtener pedidos y productos
$sql = "SELECT p.codigo AS pedido_id, p.fecha, p.importe, p.estado, u.usuario,
               pr.descripcion, d.unidades, d.precio_unitario, pr.codigo AS prod_id
        FROM pedidos p
        JOIN usuarios u ON p.persona = u.codigo
        JOIN detalle d ON p.codigo = d.codigo_pedido
        JOIN productos pr ON d.codigo_producto = pr.codigo
        ORDER BY p.codigo DESC";

$resultado = mysqli_query($conexion, $sql);

$pedidos = [];
while ($fila = mysqli_fetch_assoc($resultado)) {
    $id = $fila['pedido_id'];
    if (!isset($pedidos[$id])) {
        $pedidos[$id] = [
            'fecha' => $fila['fecha'],
            'importe' => $fila['importe'],
            'estado' => $fila['estado'],
            'usuario' => $fila['usuario'],
            'productos' => []
        ];
    }
    $pedidos[$id]['productos'][] = [
        'descripcion' => $fila['descripcion'],
        'unidades' => $fila['unidades'],
        'precio' => $fila['precio_unitario']
    ];
}
mysqli_free_result($resultado);
desconectar($conexion);
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Pedidos</title>
</head>
<body>
    <h2>Gestión de Pedidos</h2>
    <a href="admin.php">Volver al panel</a><br><br>

    <?php foreach ($pedidos as $id => $pedido): ?>
        <div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">
            <strong>Pedido #<?= $id ?></strong><br>
            Usuario: <?= $pedido['usuario'] ?> - Fecha: <?= $pedido['fecha'] ?><br>
            Estado actual: <?= $pedido['estado'] ?><br>
            Importe: <?= number_format($pedido['importe'], 2) ?> €<br>

            <form method="post" action="cambiar_estado.php" style="display:inline;">
                <input type="hidden" name="pedido_id" value="<?= $id ?>">
                <select name="nuevo_estado" required>
                    <option value="">Cambiar a...</option>
                    <option value="1">Procesando</option>
                    <option value="2">Enviado</option>
                    <option value="3">Entregado</option>
                    <option value="4">Cancelado</option>
                </select>
                <button type="submit">Actualizar estado</button>
            </form>

            <?php if ($pedido['estado'] == 4): ?>
                <form method="post" action="eliminar_pedido.php" style="display:inline;">
                    <input type="hidden" name="pedido_id" value="<?= $id ?>">
                    <button type="submit" onclick="return confirm('¿Eliminar pedido cancelado?')">Eliminar</button>
                </form>
            <?php endif; ?>

            <h4>Productos:</h4>
            <ul>
                <?php foreach ($pedido['productos'] as $p): ?>
                    <li><?= $p['descripcion'] ?> - <?= $p['unidades'] ?> uds. x <?= number_format($p['precio'], 2) ?>€</li>
                <?php endforeach; ?>
            </ul>
        </div>
    <?php endforeach; ?>
</body>
</html>
