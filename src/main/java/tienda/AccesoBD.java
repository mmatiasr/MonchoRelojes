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
			String DB_URL = "jdbc:mariadb://localhost:3306/daw";
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
		String query = "SELECT codigo,descripcion,precio,existencias,imagen FROM productos";
        PreparedStatement s = conexionBD.prepareStatement(query);
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

public int comprobarUsuarioBD(String usuario, String claveHash) {
    abrirConexionBD();
    int codigo = -1;

    try {
        String con = "SELECT codigo FROM usuarios WHERE usuario=? AND clave=?";
        PreparedStatement s = conexionBD.prepareStatement(con);
        s.setString(1, usuario);
        s.setString(2, claveHash);

        ResultSet resultado = s.executeQuery();

        if (resultado.next()) {
            codigo = resultado.getInt("codigo");
        }
    } catch (Exception e) {
        System.err.println("Error verificando usuario/clave");
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

        if (rs.next()) return false; 

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
            usuario.setCp(rs.getString("cp"));                 
            usuario.setPoblacion(rs.getString("poblacion"));   
            usuario.setProvincia(rs.getString("provincia"));
        }
    } catch (Exception e) {
        System.err.println("Error al obtener datos del usuario");
        e.printStackTrace();
    }

    return usuario;
}
public Connection getConexion() {
    abrirConexionBD();
    return conexionBD;
}

public int obtenerExistencias(int codigoProducto) {
    abrirConexionBD();
    int existencias = 0;

    try {
        String query = "SELECT existencias FROM productos WHERE codigo = ?";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setInt(1, codigoProducto);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            existencias = rs.getInt("existencias");
        }
    } catch (Exception e) {
        System.err.println("Error al obtener existencias del producto con código " + codigoProducto);
        e.printStackTrace();
    }

    return existencias;
}
public List<PedidoBD> obtenerPedidosUsuario(int codigoUsuario) {
    abrirConexionBD();
    List<PedidoBD> pedidos = new ArrayList<>();

    try {
        String query = "SELECT codigo, fecha, importe, estado FROM pedidos WHERE persona=? ORDER BY fecha DESC";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setInt(1, codigoUsuario);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            PedidoBD pedido = new PedidoBD();
            pedido.setCodigo(rs.getInt("codigo"));
            pedido.setFecha(rs.getDate("fecha"));
            pedido.setImporte(rs.getFloat("importe"));
            pedido.setEstado(rs.getInt("estado"));
            pedidos.add(pedido);
        }
    } catch (Exception e) {
        System.err.println("Error obteniendo pedidos del usuario");
        e.printStackTrace();
    }
    return pedidos;
}
public List<DetallePedidoBD> obtenerDetallePedido(int codigoPedido) {
    abrirConexionBD();
    List<DetallePedidoBD> detalles = new ArrayList<>();

    try {
        String query = "SELECT d.codigo_producto, p.descripcion, d.unidades, d.precio_unitario " +
                       "FROM detalle d JOIN productos p ON d.codigo_producto = p.codigo " +
                       "WHERE d.codigo_pedido = ?";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setInt(1, codigoPedido);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            DetallePedidoBD detalle = new DetallePedidoBD();
            detalle.setCodigoProducto(rs.getInt("codigo_producto"));
            detalle.setDescripcion(rs.getString("descripcion"));
            detalle.setUnidades(rs.getInt("unidades"));
            detalle.setPrecioUnitario(rs.getFloat("precio_unitario"));
            detalles.add(detalle);
        }
    } catch (Exception e) {
        System.err.println("Error obteniendo detalle del pedido");
        e.printStackTrace();
    }

    return detalles;
}

public boolean actualizarUsuario(int codigo, String nombre, String apellidos, String direccion,
                                 String telefono, String cp, String poblacion, String provincia) {
    abrirConexionBD();

    try {
        String sql = "UPDATE usuarios SET nombre=?, apellidos=?, domicilio=?, telefono=?, cp=?, poblacion=?, provincia=? WHERE codigo=?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, nombre);
        ps.setString(2, apellidos);
        ps.setString(3, direccion);
        ps.setString(4, telefono);
        ps.setString(5, cp);
        ps.setString(6, poblacion);
        ps.setString(7, provincia);
        ps.setInt(8, codigo);

        int filas = ps.executeUpdate();
        return filas > 0;

    } catch (Exception e) {
        System.err.println("Error al actualizar usuario:");
        e.printStackTrace();
        return false;
    }
}

public boolean cancelarPedido(int codigoUsuario, int codigoPedido) {
    abrirConexionBD();

    try {
        String check = "SELECT estado FROM pedidos WHERE codigo=? AND persona=?";
        PreparedStatement ps = conexionBD.prepareStatement(check);
        ps.setInt(1, codigoPedido);
        ps.setInt(2, codigoUsuario);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int estado = rs.getInt("estado");
            if (estado != 1) return false; 
        } else {
            return false; 
        }

        String update = "UPDATE pedidos SET estado = 4 WHERE codigo = ?";
        PreparedStatement upd = conexionBD.prepareStatement(update);
        upd.setInt(1, codigoPedido);
        return upd.executeUpdate() > 0;

    } catch (Exception e) {
        System.err.println("Error cancelando pedido:");
        e.printStackTrace();
        return false;
    }
}
public List<ProductoBD> obtenerProductosPorNombre(String texto) {
    abrirConexionBD();
    List<ProductoBD> productos = new ArrayList<>();

    try {
        String query = "SELECT codigo, descripcion, precio, existencias, imagen FROM productos WHERE descripcion LIKE ?";
        PreparedStatement ps = conexionBD.prepareStatement(query);
        ps.setString(1, "%" + texto + "%");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            ProductoBD producto = new ProductoBD();
            producto.setCodigo(rs.getInt("codigo"));
            producto.setDescripcion(rs.getString("descripcion"));
            producto.setPrecio(rs.getFloat("precio"));
            producto.setStock(rs.getInt("existencias"));
            producto.setImagen(rs.getString("imagen"));
            productos.add(producto);
        }

    } catch (Exception e) {
        System.err.println("Error buscando productos por nombre:");
        e.printStackTrace();
    }

    return productos;
}

public boolean actualizarClaveUsuario(int codigo, String nuevaClaveHash) {
    abrirConexionBD();

    try {
        String sql = "UPDATE usuarios SET clave=? WHERE codigo=?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setString(1, nuevaClaveHash);
        ps.setInt(2, codigo);

        int filas = ps.executeUpdate();
        return filas > 0;

    } catch (Exception e) {
        System.err.println("Error al actualizar la clave:");
        e.printStackTrace();
        return false;
    }
}


}