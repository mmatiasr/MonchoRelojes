<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    List<Producto> carrito = (List<Producto>) sesion.getAttribute("carritoJSON");
    Integer codigo = (Integer) sesion.getAttribute("codigo");

    if (codigo == null || codigo <= 0) {
        response.sendRedirect("loginUsuario.jsp");
        return;
    }

    AccesoBD con = AccesoBD.getInstance();
    UsuarioBD usuario = con.obtenerUsuarioPorCodigo(codigo);
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Resumen del Pedido</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <h2 class="mb-4 text-center">Resumen del Pedido</h2>

    <!-- Mostrar productos del carrito -->
    <div class="table-responsive mb-5">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>Imagen</th>
            <th>Descripción</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
          </tr>
        </thead>
        <tbody>
          <% 
            float total = 0;
            for (Producto p : carrito) {
                float subtotal = p.getPrecio() * p.getCantidad();
                total += subtotal;
          %>
          <tr>
            <td><img src="<%= request.getContextPath() %>/<%= p.getImagen().replaceFirst("^\\./", "img/") %>" alt="Imagen" width="80"></td>
            <td><%= p.getDescripcion() %></td>
            <td><%= String.format("%.2f", p.getPrecio()) %> €</td>
            <td><%= p.getCantidad() %></td>
            <td><%= String.format("%.2f", subtotal) %> €</td>
          </tr>
          <% } %>
        </tbody>
        <tfoot>
          <tr class="table-light">
            <th colspan="4" class="text-end">Total:</th>
            <th><%= String.format("%.2f", total) %> €</th>
          </tr>
        </tfoot>
      </table>
    </div>

    <h4 class="mb-3">Datos de Envío</h4>
    <form method="post" action="Tramitacion.html">
      <div class="mb-3">
        <label class="form-label">Nombre</label>
        <input type="text" class="form-control" name="nombre" value="<%= usuario.getNombre() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Apellidos</label>
        <input type="text" class="form-control" name="apellidos" value="<%= usuario.getApellidos() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Dirección</label>
        <input type="text" class="form-control" name="direccion" value="<%= usuario.getDireccion() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Código Postal</label>
        <input type="text" class="form-control" name="cp" value="<%= usuario.getCp() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Población</label>
        <input type="text" class="form-control" name="poblacion" value="<%= usuario.getPoblacion() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Provincia</label>
        <input type="text" class="form-control" name="provincia" value="<%= usuario.getProvincia() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Método de Pago</label>
        <select class="form-select" name="metodoPago" required>
          <option value="Tarjeta de crédito">Tarjeta de crédito</option>
          <option value="Contra reembolso">Contra reembolso</option>
          <option value="Transferencia bancaria">Transferencia bancaria</option>
        </select>
      </div>

      <!-- Botones -->
      <div class="d-flex justify-content-between">
        <a href="productos.jsp" class="btn btn-secondary">Cancelar Pedido</a>
        <button type="submit" class="btn btn-success">Confirmar Pedido</button>
      </div>
    </form>

  </main>

  <footer><mi-footer></mi-footer></footer>
  <div style="height: 100px;"></div>
  <script src="js/etiquetas.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
