package tienda;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/Tramitacion.html")
public class Tramitacion extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        @SuppressWarnings("unchecked")
        List<Producto> carrito = (List<Producto>) sesion.getAttribute("carritoJSON");
        Integer codigoUsuario = (Integer) sesion.getAttribute("codigo");

        if (codigoUsuario == null || codigoUsuario <= 0 || carrito == null || carrito.isEmpty()) {
            response.sendRedirect("productos.jsp");
            return;
        }

        AccesoBD con = AccesoBD.getInstance();
        Connection conexion = con.getConexion();

        try {
            conexion.setAutoCommit(false); 
            float importeTotal = 0;
            for (Producto p : carrito) {
                importeTotal += p.getPrecio() * p.getCantidad();
            }

            String sqlPedido = "INSERT INTO pedidos (persona, fecha, importe, estado) VALUES (?, CURRENT_DATE(), ?, ?)";
            PreparedStatement psPedido = conexion.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, codigoUsuario);
            psPedido.setFloat(2, importeTotal);
            psPedido.setInt(3, 1); 
            psPedido.executeUpdate();

            ResultSet rs = psPedido.getGeneratedKeys();
            int codigoPedido = 0;
            if (rs.next()) {
                codigoPedido = rs.getInt(1);
            }

            for (Producto p : carrito) {
                String sqlDetalle = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?, ?, ?, ?)";
                PreparedStatement psDetalle = conexion.prepareStatement(sqlDetalle);
                psDetalle.setInt(1, codigoPedido);
                psDetalle.setInt(2, p.getCodigo());
                psDetalle.setInt(3, p.getCantidad());
                psDetalle.setFloat(4, p.getPrecio());
                psDetalle.executeUpdate();

                String sqlUpdate = "UPDATE productos SET existencias = existencias - ? WHERE codigo = ?";
                PreparedStatement psUpdate = conexion.prepareStatement(sqlUpdate);
                psUpdate.setInt(1, p.getCantidad());
                psUpdate.setInt(2, p.getCodigo());
                psUpdate.executeUpdate();
            }

            conexion.commit(); 

            sesion.setAttribute("codigoPedido", codigoPedido);

            sesion.removeAttribute("carritoJSON");

            response.sendRedirect("pedidoFinalizado.jsp");

        } catch (Exception e) {
            try {
                conexion.rollback(); 
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("productos.jsp"); 
        } finally {
            try {
                conexion.setAutoCommit(true); 
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
