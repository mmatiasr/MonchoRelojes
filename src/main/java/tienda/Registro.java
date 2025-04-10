package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String domicilio = request.getParameter("domicilio");
        String telefono = request.getParameter("telefono");
        String poblacion = request.getParameter("poblacion");
        String provincia = request.getParameter("provincia");
        String cp = request.getParameter("cp");

        String url = request.getParameter("url");

        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        boolean creado = con.crearNuevoUsuario(usuario, clave, nombre, apellidos, domicilio, telefono,poblacion, provincia, cp);


        if (creado) {
            response.sendRedirect("loginUsuario.jsp");
        } else {
            session.setAttribute("mensaje", "Error: el usuario ya existe o hubo un problema.");
            response.sendRedirect(url);
        }
    }
}
