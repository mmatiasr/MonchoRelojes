<%@ page language="java" contentType="text/html;charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8"%>
<%
    Integer codigo = (Integer) session.getAttribute("codigo");
    if (codigo == null || codigo <= 0) {
        response.sendRedirect("loginUsuario.jsp");
        return;
    }

    AccesoBD bd = AccesoBD.getInstance();
    UsuarioBD usuario = bd.obtenerUsuarioPorCodigo(codigo);
    List<PedidoBD> pedidos = bd.obtenerPedidosUsuario(codigo);
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Perfil de Usuario - Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <header><mi-header></mi-header></header>

  <main class="container mt-5 pt-5">
    <h2 class="mt-4">Mi Perfil</h2>

    <form method="post" action="ActualizarUsuario.html">
      <!-- Datos que NO se pueden cambiar -->
      <div class="mb-3">
        <label class="form-label">Usuario</label>
        <input type="text" class="form-control" name="usuario" value="<%= usuario.getUsuario() %>" readonly>
      </div>

      <!-- Datos que SÍ puede cambiar -->
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
        <label class="form-label">Teléfono</label>
        <input type="text" class="form-control" name="telefono" value="<%= usuario.getTelefono() %>">
      </div>
      <div class="mb-3">
        <label class="form-label">Código Postal</label>
        <input type="text" class="form-control" name="cp" value="<%= usuario.getCp() %>">
      </div>
      <div class="mb-3">
        <label class="form-label">Población</label>
        <input type="text" class="form-control" name="poblacion" value="<%= usuario.getPoblacion() %>" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Provincia</label>
        <input type="text" class="form-control" name="provincia" value="<%= usuario.getProvincia() %>" required>
      </div>

      <!-- Botón para guardar cambios -->
      <div class="text-center">
        <button type="submit" class="btn btn-success mt-3">Guardar Cambios</button>
      </div>
    </form>

    <h3 class="mt-5 mb-3">Pedidos Realizados</h3>

    <% if (pedidos.isEmpty()) { %>
      <div class="alert alert-info">No has realizado ningún pedido todavía.</div>
    <% } else { %>
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Código Pedido</th>
              <th>Fecha</th>
              <th>Importe (€)</th>
              <th>Estado</th>
              <th>Acción</th>
            </tr>
          </thead>
          <tbody>
            <% for (PedidoBD pedido : pedidos) { %>
              <tr>
                <td><%= pedido.getCodigo() %></td>
                <td><%= pedido.getFecha() %></td>
                <td><%= String.format("%.2f", pedido.getImporte()) %></td>
                <td>
                  <% 
                    String estadoTexto = "";
                    switch (pedido.getEstado()) {
                      case 1: estadoTexto = "Procesando"; break;
                      case 2: estadoTexto = "Enviado"; break;
                      case 3: estadoTexto = "Entregado"; break;
                      case 4: estadoTexto = "Cancelado"; break;
                      default: estadoTexto = "Desconocido"; break;
                    }
                  %>
                  <%= estadoTexto %>
                </td>
                <td>
                  <a href="detallePedido.jsp?codigo=<%= pedido.getCodigo() %>" class="btn btn-info btn-sm mb-1">Ver Detalle</a>
          
                  <% if (pedido.getEstado() == 1) { %>
                    <form method="post" action="CancelarPedido.html" class="d-inline">
                      <input type="hidden" name="codigoPedido" value="<%= pedido.getCodigo() %>">
                      <button type="submit" class="btn btn-danger btn-sm"
                              onclick="return confirm('¿Seguro que deseas cancelar este pedido?');">
                        Cancelar
                      </button>
                    </form>
                  <% } %>
                </td>
              </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    <% } %>

    <form method="post" action="logout.html" class="d-inline">
      <input type="hidden" name="url" value="loginUsuario.jsp">
      <button type="submit" class="btn btn-danger btn-sm mt-3">Cerrar sesión</button>
    </form>
  </main>

  <footer><mi-footer></mi-footer></footer>
  <div style="height: 100px;"></div>

  <script src="js/etiquetas.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
