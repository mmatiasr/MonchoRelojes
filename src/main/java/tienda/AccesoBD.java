package tienda;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public final class AccesoBD {
	private static AccesoBD instanciaUnica = null;
	private Connection conexionBD = null;

	public static AccesoBD getInstance(){
		if (instanciaUnica == null){
			instanciaUnica = new AccesoBD();
		}
		return instanciaUnica;
	}

	private AccesoBD() {
		abrirConexionBD();
	}

	public void abrirConexionBD() {
		if (conexionBD == null)
		{
			String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
			// daw es el nombre de la base de datos que hemos creado con anterioridad.
			String DB_URL = "jdbc:mariadb://localhost:3306/daw";
			// El usuario root y su clave son los que se puso al instalar MariaDB.
			String USER = "root";
			String PASS = "1234";
			try {
				Class.forName(JDBC_DRIVER);
				conexionBD = DriverManager.getConnection(DB_URL,USER,PASS);
			}
			catch(Exception e) {
				System.err.println("No se ha podido conectar a la base de datos");
				System.err.println(e.getMessage());
                e.printStackTrace();
			}
		}
	}

	public boolean comprobarAcceso() {
		abrirConexionBD();
		return (conexionBD != null);
	}

	public List<ProductoBD> obtenerProductosBD() {
	abrirConexionBD();
	ArrayList<ProductoBD> productos = new ArrayList<>();

	try {
		String query = "SELECT codigo,descripcion,precio,existencias,imagen FROM productos"; // Hay que tener en cuenta las columnas de la tabla de productos
		PreparedStatement s = conexionBD.prepareStatement(query);
		s.setInt(1, 1); // Cambia el valor de la categoría según sea necesario
		ResultSet resultado = s.executeQuery();
		while(resultado.next()){
			ProductoBD producto = new ProductoBD();
			producto.setCodigo(resultado.getInt("codigo"));
			producto.setDescripcion(resultado.getString("descripcion"));
			producto.setPrecio(resultado.getFloat("precio"));
			producto.setStock(resultado.getInt("existencias"));
			producto.setImagen(resultado.getString("imagen"));
			productos.add(producto);
		}
	} catch(Exception e) {
		System.err.println("Error ejecutando la consulta a la base de datos");
		System.err.println(e.getMessage());
	}
	
	return productos;
	
}

public int comprobarUsuarioBD(String usuario, String clave) {
    abrirConexionBD();
    int codigo = -1;

    try {
        String con = "SELECT codigo FROM usuarios WHERE usuario=? AND clave=?";
        PreparedStatement s = conexionBD.prepareStatement(con);
        s.setString(1, usuario);
        s.setString(2, clave);

        ResultSet resultado = s.executeQuery();

        if (resultado.next()) {
            codigo = resultado.getInt("codigo");
        }
    } catch (Exception e) {
        System.err.println("Error verificando usuario/clave");
        System.err.println(e.getMessage());
        e.printStackTrace();
    }

    return codigo;
}
public boolean crearNuevoUsuario(String usuario, String clave, String nombre,
                                 String apellidos, String direccion, String telefono,
                                 String poblacion, String provincia, String cp) {
    abrirConexionBD();

    try {
        String check = "SELECT codigo FROM usuarios WHERE usuario=?";
        PreparedStatement ps = conexionBD.prepareStatement(check);
        ps.setString(1, usuario);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) return false; // Ya existe

        String insert = "INSERT INTO usuarios (usuario, clave, nombre, apellidos, domicilio, telefono, poblacion, provincia, cp, activo, admin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, 0)";
        PreparedStatement ins = conexionBD.prepareStatement(insert);
        ins.setString(1, usuario);
        ins.setString(2, clave);
        ins.setString(3, nombre);
        ins.setString(4, apellidos);
        ins.setString(5, direccion);
        ins.setString(6, telefono);
        ins.setString(7, poblacion);
        ins.setString(8, provincia);
        ins.setString(9, cp);

        ins.executeUpdate();
        return true;

    } catch (Exception e) {
        System.err.println("Error en crearNuevoUsuario:");
        e.printStackTrace();
        return false;
    }
}


public UsuarioBD obtenerUsuarioPorCodigo(int codigo) {
    abrirConexionBD();
    UsuarioBD usuario = null;

    try {
        String query = "SELECT * FROM usuarios WHERE codigo=?";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setInt(1, codigo);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            usuario = new UsuarioBD();
            usuario.setCodigo(rs.getInt("codigo"));
            usuario.setUsuario(rs.getString("usuario"));
            usuario.setNombre(rs.getString("nombre"));
            usuario.setApellidos(rs.getString("apellidos"));
            usuario.setDireccion(rs.getString("domicilio"));
            usuario.setTelefono(rs.getInt("telefono"));
        }
    } catch (Exception e) {
        System.err.println("Error al obtener datos del usuario");
        e.printStackTrace();
    }

    return usuario;
}

}