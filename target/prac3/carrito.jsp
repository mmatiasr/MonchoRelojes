<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Carrito - Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Raleway:wght@400;700&display=swap" rel="stylesheet">
  <link rel="icon" type="image/png" sizes="32x32" href="img/clock.png">
</head>
<body>
  <%
  String nombreUsuario = (String) session.getAttribute("nombreUsuario");
%>
  <header>
    <mi-header></mi-header>
    <% if (nombreUsuario != null && !nombreUsuario.isEmpty()) { %>
      <div style="position: fixed; top: 17px; left: 250px; color: white; font-family: 'Raleway', sans-serif; z-index: 1001; font-size: 23px;">
        ¡Bienvenido, <%= nombreUsuario %>!
      </div>
    <% } %>
  </header>

  <main class="container mt-5 pt-5">
    <h1 class="mb-4">Carrito de Compras</h1>
    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead>
          <tr>
            <th scope="col">ID Producto</th>
            <th scope="col">Nombre de Producto</th>
            <th scope="col"></th>
            <th scope="col">Nº elementos</th>
            <th scope="col">Precio Unitario</th>
          </tr>
        </thead>
        <tbody id="tabla-carrito"></tbody>
      </table>
    </div>
    
    </div>
    <div class="d-flex justify-content-end mt-3">
      <a class="btn btn-success" onclick="EnviarCarrito('ProcesarPedido.html', carrito)">Formalizar Pedido</a>
    </div>
    <p class="mt-3 text-end">* Debes estar autenticado para formalizar el pedido.</p>
  </main>

  <footer>
    <mi-footer></mi-footer>
  </footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/carrito.js"></script>
  <script src="js/libjson.js"></script>
  <script>
    window.addEventListener("load", function() {
      mostrarCarrito();
    });
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
