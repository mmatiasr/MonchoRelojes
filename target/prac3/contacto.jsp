<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Contacto - Moncho Relojes</title>
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
    <h1 class="mb-4">Contacto</h1>
    <div class="row">
      <div class="col-md-6">
        <h2>Formulario de Contacto</h2>
        <form>
          <div class="mb-3">
            <label for="nombre" class="form-label">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Correo Electrónico:</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          <div class="mb-3">
            <label for="mensaje" class="form-label">Mensaje:</label>
            <textarea class="form-control" id="mensaje" name="mensaje" rows="5" required></textarea>
          </div>
          <button type="submit" class="btn btn-primary">Enviar Mensaje</button>
        </form>
      </div>
      <div class="col-md-6">
        <h2>Ubicación</h2>
        <div class="mb-3">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3959.828655225092!2d-0.42718532324919956!3d39.5125614715992!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd60450d03d31e81%3A0xb2d49176f911a805!2sETSE%20-%20Escola%20T%C3%A8cnica%20Superior%20d&#39;Enginyeria%20(Universitat%20de%20Val%C3%A8ncia)!5e1!3m2!1sen!2ses!4v1740583612423!5m2!1sen!2ses" 
            width="600" height="250" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
        <h2>Datos de Contacto</h2>
        <p><strong>Teléfono:</strong> +34 123 456 789</p>
        <p><strong>Horario de Atención:</strong> Lunes a Viernes, 9:00 - 18:00</p>
        <p>
          <strong>Redes Sociales:</strong><br>
          <a href="https://www.facebook.com" target="_blank">Facebook</a> |
          <a href="https://www.twitter.com" target="_blank">Twitter</a> |
          <a href="https://www.instagram.com" target="_blank">Instagram</a>
        </p>
      </div>
    </div>
  </main>

  <footer>
    <mi-footer></mi-footer>
  </footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
