<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión - Tienda Online</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="icon" type="image/png" sizes="32x32" href="img/clock.png">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <%
      String mensaje = (String) session.getAttribute("mensaje");
      if (mensaje != null) {
    %>
      <div class="alert alert-danger text-center" role="alert">
        <%= mensaje %>
      </div>
    <%
        session.removeAttribute("mensaje");
      }
    %>

    <%
      Integer codigo = (Integer) session.getAttribute("codigo");
      if (codigo == null || codigo <= 0) {
    %>
    <div class="row justify-content-center">
      <div class="col-md-6">
        <h2 class="text-center mb-4">Iniciar Sesión o Registrarse</h2>
        <form method="post" action="login.html">
          <input type="hidden" name="url" value="loginUsuario.jsp">
          <div class="mb-3">
            <label for="usuario" class="form-label">Usuario</label>
            <input type="text" class="form-control" name="usuario" required>
          </div>
          <div class="mb-3">
            <label for="clave" class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="clave" required>
          </div>
          
          <button type="submit" class="btn btn-primary w-100">Entrar</button>
        </form>
        <p class="mt-3 text-center">
            ¿No tienes cuenta? <a href="registroUsuario.jsp">Regístrate aquí</a>
          </p>
          
      </div>
    </div>
    <%
      } else {
        response.sendRedirect("perfil.jsp");
      }
    %>
  </main>

  <footer><mi-footer></mi-footer></footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
