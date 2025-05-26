<?php

function conectar() {
    $conexion = mysqli_connect("localhost", "root", "1234", "daw");
    if (mysqli_connect_errno()) {
        printf("Error al conectar con la base de datos: %s\n", mysqli_connect_error());
        exit();
    }
    return $conexion;
}

function desconectar($conexion) {
    mysqli_close($conexion);
}

function obtenerTodosLosUsuarios() {
    $bbdd = conectar();
    $sql = "SELECT codigo, usuario, activo, admin, nombre, apellidos, domicilio, telefono FROM usuarios";
    $resultado = mysqli_query($bbdd, $sql);
    desconectar($bbdd);
    return $resultado;
}

function obtenerTodosLosPedidos() {
    $bbdd = conectar();
    $sql = "SELECT * FROM pedidos";
    $resultado = mysqli_query($bbdd, $sql);
    desconectar($bbdd);
    return $resultado;
}

function obtenerEstados() {
    $bbdd = conectar();
    $sql = "SELECT * FROM estados";
    $resultado = mysqli_query($bbdd, $sql);
    desconectar($bbdd);
    return $resultado;
}
