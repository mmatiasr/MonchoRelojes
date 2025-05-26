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
        if (usuario == null || usuario.trim().isEmpty() ||
            clave1 == null || clave1.trim().isEmpty() ||
            clave2 == null || clave2.trim().isEmpty() ||
            nombre == null || nombre.trim().isEmpty() ||
            apellidos == null || apellidos.trim().isEmpty() ||
            domicilio == null || domicilio.trim().isEmpty() ||
            telefono == null || telefono.trim().isEmpty() ||
            poblacion == null || poblacion.trim().isEmpty() ||
            provincia == null || provincia.trim().isEmpty() ||
            cp == null || cp.trim().isEmpty()) {

            session.setAttribute("mensaje", "Error: Todos los campos son obligatorios.");
            response.sendRedirect(url);
            return;
        }
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
