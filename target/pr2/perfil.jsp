<%@ page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<%
  Integer codigo = (Integer) session.getAttribute("codigo");
  if (codigo == null || codigo <= 0) {
    response.sendRedirect("loginUsuario.jsp");
    return;
  }

  AccesoBD bd = AccesoBD.getInstance();
  UsuarioBD usuario = bd.obtenerUsuarioPorCodigo(codigo);
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Perfil de Usuario - Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="icon" type="image/png" sizes="32x32" href="img/clock.png">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <h2 class="mt-4">Mi Perfil</h2>
    <form>
      <div class="mb-3">
        <label class="form-label">Usuario</label>
        <input type="text" class="form-control" value="<%= usuario.getUsuario() %>" disabled>
      </div>
      <div class="mb-3">
        <label class="form-label">Nombre</label>
        <input type="text" class="form-control" value="<%= usuario.getNombre() %>" disabled>
      </div>
      <div class="mb-3">
        <label class="form-label">Apellidos</label>
        <input type="text" class="form-control" value="<%= usuario.getApellidos() %>" disabled>
      </div>
      <div class="mb-3">
        <label class="form-label">Dirección</label>
        <input type="text" class="form-control" value="<%= usuario.getDireccion() %>" disabled>
      </div>
      <div class="mb-3">
        <label class="form-label">Teléfono</label>
        <input type="text" class="form-control" value="<%= usuario.getTelefono() %>" disabled>
      </div>
    </form>

    <form method="post" action="logout.html" class="d-inline">
        <input type="hidden" name="url" value="index.jsp">
        <button type="submit" class="btn btn-danger btn-sm">Cerrar sesión</button>
      </form>
      
  </main>

  <footer><mi-footer></mi-footer></footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/carrito.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
