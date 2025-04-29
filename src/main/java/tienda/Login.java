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

        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String url = request.getParameter("url");

        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        if (usuario != null && clave != null) {
            // Convertir la clave en SHA-256
            String claveHash = Encriptador.sha256(clave);

            int codigo = con.comprobarUsuarioBD(usuario, claveHash);
            if (codigo > 0) {
                session.setAttribute("codigo", codigo);
            } else {
                session.setAttribute("mensaje", "Usuario y/o clave incorrectos");
            }
        }

        request.getRequestDispatcher(url).forward(request, response);
    }
}
