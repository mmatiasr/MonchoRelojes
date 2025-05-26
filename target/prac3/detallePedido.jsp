<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8"%>
<%
    String codigoStr = request.getParameter("codigo");
    int codigoPedido = Integer.parseInt(codigoStr);

    AccesoBD bd = AccesoBD.getInstance();
    List<DetallePedidoBD> productos = bd.obtenerDetallePedido(codigoPedido);
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Detalle del Pedido <%= codigoPedido %></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <h2>Detalle del Pedido #<%= codigoPedido %></h2>

    <% if (productos.isEmpty()) { %>
      <div class="alert alert-warning mt-4">Este pedido no tiene productos registrados.</div>
    <% } else { %>
      <table class="table table-bordered mt-4">
        <thead>
          <tr>
            <th>Código Producto</th>
            <th>Descripción</th>
            <th>Unidades</th>
            <th>Precio Unitario (€)</th>
            <th>Total (€)</th>
          </tr>
        </thead>
        <tbody>
          <% float total = 0;
             for (DetallePedidoBD d : productos) {
               float subtotal = d.getUnidades() * d.getPrecioUnitario();
               total += subtotal;
          %>
          <tr>
            <td><%= d.getCodigoProducto() %></td>
            <td><%= d.getDescripcion() %></td>
            <td><%= d.getUnidades() %></td>
            <td><%= String.format("%.2f", d.getPrecioUnitario()) %></td>
            <td><%= String.format("%.2f", subtotal) %></td>
          </tr>
          <% } %>
        </tbody>
        <tfoot>
          <tr>
            <th colspan="4" class="text-end">Total Pedido</th>
            <th><%= String.format("%.2f", total) %> €</th>
          </tr>
        </tfoot>
      </table>
    <% } %>

    <a href="perfil.jsp" class="btn btn-secondary mt-3">Volver al perfil</a>
  </main>

  <footer><mi-footer></mi-footer></footer>
</body>
</html>
