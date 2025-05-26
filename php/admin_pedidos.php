<?php
session_start();
require_once('libs/baseDatos.php');
$bbdd = conectar();

// Comprobamos si hay sesión y si es admin
if (!isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit();
}

// Obtenemos opciones para los desplegables
$usuarios = mysqli_query($bbdd, "SELECT codigo, usuario FROM usuarios");
$productos = mysqli_query($bbdd, "SELECT codigo, descripcion FROM productos");

// Recogemos filtros
$usuario = filter_input(INPUT_GET, 'usuario');
$producto = filter_input(INPUT_GET, 'producto');
$fecha = filter_input(INPUT_GET, 'fecha');
$comparador = filter_input(INPUT_GET, 'comparador'); // =, <=, >=
$operador = filter_input(INPUT_GET, 'operador'); // AND, OR

// Construimos consulta base
$sql = "SELECT p.codigo, p.fecha, p.importe, p.estado, u.usuario 
        FROM pedidos p JOIN usuarios u ON p.persona = u.codigo";

$condiciones = [];
$parametros = [];
$tipos = "";

// Añadimos condiciones según filtros
if ($usuario) {
    $condiciones[] = "u.codigo = ?";
    $parametros[] = $usuario;
    $tipos .= "i";
}
if ($producto) {
    $condiciones[] = "EXISTS (
        SELECT 1 FROM detalle d WHERE d.codigo_pedido = p.codigo AND d.codigo_producto = ?
    )";
    $parametros[] = $producto;
    $tipos .= "i";
}
if ($fecha && in_array($comparador, ['=', '>=', '<='])) {
    $condiciones[] = "p.fecha $comparador ?";
    $parametros[] = $fecha;
    $tipos .= "s";
}

if (!empty($condiciones)) {
    $sql .= " WHERE " . implode(" $operador ", $condiciones);
}
$sql .= " ORDER BY p.fecha DESC";

// Preparamos consulta
$stmt = mysqli_prepare($bbdd, $sql);
if (!empty($parametros)) {
    mysqli_stmt_bind_param($stmt, $tipos, ...$parametros);
}
mysqli_stmt_execute($stmt);
$resultado = mysqli_stmt_get_result($stmt);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
    <title>Administrar Pedidos</title>
</head>
<body>
    <ul>
        <li><a href="usuarios.php">Usuarios</a></li>
        <li><a href="admin_productos.php">Productos</a></li>
        <li><a href="admin_pedidos.php">Pedidos</a></li>
    </ul>
    <h2>Administrar Pedidos</h2>

    <form method="get">
        <label>Usuario:</label>
        <select name="usuario">
            <option value="">-- Todos --</option>
            <?php while ($u = mysqli_fetch_assoc($usuarios)) { ?>
                <option value="<?= $u['codigo'] ?>" <?= ($usuario == $u['codigo']) ? 'selected' : '' ?>>
                    <?= $u['usuario'] ?>
                </option>
            <?php } ?>
        </select>

        <label>Producto:</label>
        <select name="producto">
            <option value="">-- Todos --</option>
            <?php while ($p = mysqli_fetch_assoc($productos)) { ?>
                <option value="<?= $p['codigo'] ?>" <?= ($producto == $p['codigo']) ? 'selected' : '' ?>>
                    <?= $p['descripcion'] ?>
                </option>
            <?php } ?>
        </select>

        <label>Fecha:</label>
        <select name="comparador">
            <option value="=" <?= ($comparador == '=') ? 'selected' : '' ?>>=</option>
            <option value="<=" <?= ($comparador == '<=') ? 'selected' : '' ?>>≤</option>
            <option value=">=" <?= ($comparador == '>=') ? 'selected' : '' ?>>≥</option>
        </select>
        <input type="date" name="fecha" value="<?= $fecha ?>">

        <label>Operador:</label>
        <select name="operador">
            <option value="AND" <?= ($operador == 'AND') ? 'selected' : '' ?>>AND</option>
            <option value="OR" <?= ($operador == 'OR') ? 'selected' : '' ?>>OR</option>
        </select>

        <button type="submit">Filtrar</button>
        <a href="admin_pedidos.php" style="margin-left:10px; padding:6px 12px; background:#ccc; color:black; text-decoration:none; border:1px solid #999; border-radius:4px;">Resetear filtros</a>


    </form>

    <h3>Resultados:</h3>
    <table border="1">
    <tr>
        <th>Código</th>
        <th>Usuario</th>
        <th>Fecha</th>
        <th>Importe</th>
        <th>Estado</th>
        <th>Acción</th>
    </tr>
    <?php while ($row = mysqli_fetch_assoc($resultado)) { ?>
        <tr>
            <td><?= $row['codigo'] ?></td>
            <td><?= $row['usuario'] ?></td>
            <td><?= $row['fecha'] ?></td>
            <td><?= $row['importe'] ?> €</td>
            <td><?= $row['estado'] ?></td>
            <td><a href="admin_ver_pedido.php?id=<?= $row['codigo'] ?>">Modificar</a></td>
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
</html>

<?php
mysqli_stmt_close($stmt);
desconectar($bbdd);
?>
