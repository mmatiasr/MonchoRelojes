package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ActualizarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer codigo = (Integer) session.getAttribute("codigo");

        if (codigo == null || codigo <= 0) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String cp = request.getParameter("cp");
        String poblacion = request.getParameter("poblacion");
        String provincia = request.getParameter("provincia");

        AccesoBD bd = AccesoBD.getInstance();
        if (!telefono.matches("\\d{9}") || !cp.matches("\\d{5}")) {
            session.setAttribute("mensaje", "Teléfono o código postal con formato incorrecto.");
            response.sendRedirect("perfil.jsp");
            return;
        }
        boolean actualizado = bd.actualizarUsuario(codigo, nombre, apellidos, direccion, telefono, cp, poblacion, provincia);

        if (actualizado) {
            session.setAttribute("mensaje", "Datos actualizados correctamente.");
        } else {
            session.setAttribute("mensaje", "No se pudieron actualizar los datos.");
        }

        response.sendRedirect("perfil.jsp");
    }
}
