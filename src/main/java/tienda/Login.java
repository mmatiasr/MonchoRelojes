package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recogemos parámetros del formulario
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String url = request.getParameter("url");

        // Creamos (o recuperamos) la sesión
        HttpSession session = request.getSession(true);

        // Obtenemos conexión con la base de datos
        AccesoBD con = AccesoBD.getInstance();

        if (usuario != null && clave != null) {
            int codigo = con.comprobarUsuarioBD(usuario, clave);
            if (codigo > 0) {
                // Usuario válido → guardamos su código
                session.setAttribute("codigo", codigo);
            } else {
                // Usuario incorrecto → mostramos mensaje de error
                session.setAttribute("mensaje", "Usuario y/o clave incorrectos");
            }
        }

        // Volvemos a la página original (loginUsuario.jsp)
        request.getRequestDispatcher(url).forward(request, response);
    }
}
