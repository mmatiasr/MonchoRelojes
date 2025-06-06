<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Empresa - Moncho Relojes</title>
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
    <section id="empresa">
      <h1 class="mb-4">Nuestra Empresa</h1>

      <h2>Historia</h2>
      <p>
        Moncho Relojes nació hace más de 30 años, fruto de una pasión innata por la relojería y el compromiso con la excelencia. 
        Desde nuestros inicios, hemos trabajado para ofrecer relojes de alta gama que combinan tradición y modernidad, ganándonos 
        la confianza de una clientela exigente en todo el mundo.
      </p>

      <h2>Actividad Detallada</h2>
      <p>
        Nos especializamos en la venta y distribución de relojes de lujo, ofreciendo una cuidada selección de modelos exclusivos 
        y de las marcas más prestigiosas del sector. Nuestro catálogo abarca desde piezas clásicas y atemporales hasta diseños vanguardistas 
        que marcan tendencia.
      </p>

      <h2>Controles de Calidad</h2>
      <p>
        Cada reloj que distribuimos pasa por rigurosos controles de calidad, asegurando precisión, durabilidad y un acabado impecable. 
        Nuestro equipo de expertos revisa cada detalle para garantizar que nuestros productos cumplan con los estándares más altos de la industria.
      </p>

      <h2>Organización</h2>
      <p>
        Contamos con un equipo de profesionales altamente capacitados, que abarca desde expertos en ventas hasta técnicos especializados 
        en el mantenimiento y reparación de relojes. Nuestra estructura organizativa nos permite ofrecer un servicio personalizado y eficiente, 
        asegurando la satisfacción de nuestros clientes en cada etapa del proceso de compra.
      </p>
    </section>
  </main>

  <footer>
    <mi-footer></mi-footer>
  </footer>
  <div style="height: 200px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
