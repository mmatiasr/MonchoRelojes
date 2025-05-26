<%@ page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    Integer codigoPedido = (Integer) sesion.getAttribute("codigoPedido");

    if (codigoPedido == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Pedido Finalizado - Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <script src="js/carrito.js"></script>
</head>
<body onload="vaciarCarrito();">

  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5 text-center">
    <h1 class="mb-4">¡Pedido realizado con éxito!</h1>
    <h3 class="mb-4">Número de pedido: <span class="text-success"><%= codigoPedido %></span></h3>
    
    <p class="lead">Muchas gracias por confiar en Moncho Relojes. Recibirás tu pedido en los próximos días.</p>

    <a href="index.jsp" class="btn btn-primary mt-4">Volver al inicio</a>
  </main>

  <footer><mi-footer></mi-footer></footer>

  <script>
    function vaciarCarrito() {
      localStorage.removeItem("mi-carrito-almacenado");
    }
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
