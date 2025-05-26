<?php session_start(); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <link rel="stylesheet" href="css/admin.css">

    <meta charset="UTF-8">
    <title>Login Administración</title>
</head>
<body>
    <h2>Login - Administración</h2>
    <form method="post" action="validar.php">
        <label>Usuario:</label>
        <input type="text" name="usuario" required><br><br>
        <label>Contraseña:</label>
        <input type="password" name="clave" required><br><br>
        <button type="submit">Entrar</button>
    </form>
    <?php
    if (isset($_SESSION['error'])) {
        echo "<p style='color:red'>" . $_SESSION['error'] . "</p>";
        unset($_SESSION['error']);
    }
    ?>
</body>
</html>
