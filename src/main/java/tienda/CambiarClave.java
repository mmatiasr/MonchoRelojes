package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class CambiarClave extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer codigo = (Integer) session.getAttribute("codigo");

        if (codigo == null || codigo <= 0) {
            response.sendRedirect("loginUsuario.jsp");
            return;
        }

        String claveActual = request.getParameter("claveActual");
        String nuevaClave = request.getParameter("nuevaClave");
        String confirmarClave = request.getParameter("confirmarClave");

        AccesoBD bd = AccesoBD.getInstance();

        UsuarioBD usuario = bd.obtenerUsuarioPorCodigo(codigo);
        String claveActualHash = Encriptador.sha256(claveActual);

        if (bd.comprobarUsuarioBD(usuario.getUsuario(), claveActualHash) != codigo) {
            session.setAttribute("mensaje", "La contraseña actual es incorrecta.");
            response.sendRedirect("perfil.jsp");
            return;
        }
        

        if (!nuevaClave.equals(confirmarClave)) {
            session.setAttribute("mensaje", "Las nuevas contraseñas no coinciden.");
            response.sendRedirect("perfil.jsp");
            return;
        }

        String nuevaClaveHash = Encriptador.sha256(nuevaClave);
        boolean cambiado = bd.actualizarClaveUsuario(codigo, nuevaClaveHash);

        if (cambiado) {
            session.setAttribute("mensaje", "Contraseña cambiada correctamente.");
        } else {
            session.setAttribute("mensaje", "Error al cambiar la contraseña.");
        }

        response.sendRedirect("perfil.jsp");
    }
}
