package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class Registro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String clave1 = request.getParameter("clave1");
        String clave2 = request.getParameter("clave2");
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
        if (clave1 == null || clave2 == null || !clave1.equals(clave2)) {
            session.setAttribute("mensaje", "Error: Las contraseñas no coinciden o están vacías.");
            response.sendRedirect(url);
            return;
        }
        
        String claveSegura = Encriptador.sha256(clave1);
        boolean creado = con.crearNuevoUsuario(usuario, claveSegura, nombre, apellidos, domicilio, telefono,poblacion, provincia, cp);


        if (creado) {
            response.sendRedirect("loginUsuario.jsp");
        } else {
            session.setAttribute("mensaje", "Error: el usuario ya existe o hubo un problema.");
            response.sendRedirect(url);
        }
    }
}
