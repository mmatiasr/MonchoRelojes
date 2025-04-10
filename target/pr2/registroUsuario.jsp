<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro - Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <%
      String mensaje = (String) session.getAttribute("mensaje");
      if (mensaje != null) {
    %>
    <div class="alert alert-danger text-center"><%= mensaje %></div>
    <%
        session.removeAttribute("mensaje");
      }
    %>

    <h2 class="text-center mb-4">Registrarse en Moncho Relojes</h2>
    <form method="post" action="registro.html">
      <input type="hidden" name="url" value="registroUsuario.jsp">

      <div class="mb-3">
        <label class="form-label">Nombre de Usuario</label>
        <input type="text" class="form-control" name="usuario" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Contraseña</label>
        <input type="password" class="form-control" name="clave" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Nombre</label>
        <input type="text" class="form-control" name="nombre">
      </div>
      <div class="mb-3">
        <label class="form-label">Apellidos</label>
        <input type="text" class="form-control" name="apellidos">
      </div>
      <div class="mb-3">
        <label class="form-label">Dirección</label>
        <input type="text" class="form-control" name="domicilio">
      </div>
      <div class="mb-3">
        <label class="form-label">Teléfono</label>
        <input type="text" class="form-control" name="telefono">
      </div>
      <div class="mb-3">
        <label class="form-label">Población</label>
        <input type="text" class="form-control" name="poblacion">
      </div>
      <div class="mb-3">
        <label class="form-label">Provincia</label>
        <input type="text" class="form-control" name="provincia">
      </div>
      <div class="mb-3">
        <label class="form-label">Código Postal</label>
        <input type="text" class="form-control" name="cp">
      </div>
      

      <button type="submit" class="btn btn-primary w-100">Registrarse</button>
    </form>
  </main>

  <footer class="bg text-black bottom text-center p-3">
     
    <p>Moncho Relojes</p>
    <a href="https://www.facebook.com" target="_blank">Facebook</a> |
    <a href="https://www.twitter.com" target="_blank">Twitter</a> |
    <a href="https://www.instagram.com" target="_blank">Instagram</a>
  </footer>
  
  <script src="js/etiquetas.js"></script>
  <script src="js/carrito.js"></script>
  <script src="js/libjson.js"></script>
</body>
</html>
