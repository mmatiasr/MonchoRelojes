package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class CancelarPedido extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer codigo = (Integer) session.getAttribute("codigo");

        if (codigo == null || codigo <= 0) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }

        int codigoPedido = Integer.parseInt(request.getParameter("codigoPedido"));
        AccesoBD bd = AccesoBD.getInstance();

        boolean cancelado = bd.cancelarPedido(codigo, codigoPedido);

        if (cancelado) {
            session.setAttribute("mensaje", "Pedido cancelado correctamente.");
        } else {
            session.setAttribute("mensaje", "El pedido no pudo cancelarse (ya fue enviado o no existe).");
        }

        response.sendRedirect("perfil.jsp");
    }
}
