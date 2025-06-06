<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Productos - Tienda Online</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/styleProductos.css">
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

  <main class="container mt-5 pt-5 mb-8">
    <h2 class="my-4">Productos</h2>
    <form method="get" action="productos.jsp" class="mb-4 d-flex">
      <input type="text" name="filtro" class="form-control me-2" placeholder="Buscar producto..." value="<%= request.getParameter("filtro") != null ? request.getParameter("filtro") : "" %>">
      <button type="submit" class="btn btn-outline-primary">Buscar</button>
    </form>
    
    <div class="row">
      <%
      AccesoBD con = AccesoBD.getInstance();
      String filtro = request.getParameter("filtro");
      List<ProductoBD> productos;
      
      if (filtro != null && !filtro.trim().isEmpty()) {
          productos = con.obtenerProductosPorNombre(filtro.trim());
      } else {
          productos = con.obtenerProductosBD();
      }      
        for (ProductoBD producto : productos) {
          int codigo = producto.getCodigo();
          String descripcion = producto.getDescripcion();
          float precio = producto.getPrecio();
          int existencias = producto.getStock();
          String imagen = producto.getImagen();
      %>
      <div class="col-md-4 mb-4">
        <div class="card">
          <div class="wrapper">
            <div class="card-image">
              <img src="<%= request.getContextPath() %>/img/<%= imagen %>" alt="<%= descripcion %>" class="img-fluid">

            </div>
            <div class="info">
              <div class="content">
                <p class="title"><%= descripcion %></p>
                <p class="title price"><%= String.format("%.2f", precio) %>€</p>
              </div>
              <% if (existencias > 0) { %>
                <button class="card-btn"
                        onclick="anadirCarrito(<%= codigo %>, '<%= descripcion %>', 'img/<%= imagen %>', <%= precio %>, <%= existencias %>)">
                  Añadir al carrito
                </button>
              <% } else { %>
                <p class="text-muted">Agotado</p>
              <% } %>
            </div>
          </div>
        </div>
      </div>
      <% } %>
    </div>
  </main>

  <footer>
    <mi-footer></mi-footer>
  </footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="js/carrito.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
