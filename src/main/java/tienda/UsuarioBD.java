package tienda;

public class UsuarioBD {
    private int codigo;
    private String usuario;
    private String nombre;
    private String apellidos;
    private String direccion;
    private int telefono;
    private String cp; 
    private String poblacion; 
    private String provincia; 

    public int getCodigo() 
    { 
        return codigo; 
    }
    public void setCodigo(int codigo) 
    { 
        this.codigo = codigo; 
    }

    public String getUsuario() 
    { 
        return usuario; 
    
    }
    public void setUsuario(String usuario) 
    { 
        this.usuario = usuario; 
    }

    public String getNombre() 
    {
        return nombre; 
    }

    public void setNombre(String nombre) 
    { 
        this.nombre = nombre; 
    }

    public String getApellidos() 
    { 
        return apellidos; 
    }

    public void setApellidos(String apellidos) 
    { 
        this.apellidos = apellidos; 
    }

    public String getDireccion() 
    { 
        return direccion; 
    
    }
    public void setDireccion(String direccion) 
    { 
        this.direccion = direccion; 
    }

    public int getTelefono() 
    { 
        return telefono; 
    }
    public void setTelefono(int telefono) 
    { 
        this.telefono = telefono;
    }

    public String getCp() { 
        return cp; 
    }
    
    public void setCp(String cp) { 
        this.cp = cp; 
    }

    public String getPoblacion() { 
        return poblacion; 
    }
    
    public void setPoblacion(String poblacion) { 
        this.poblacion = poblacion; 
    }

    public String getProvincia() { 
        return provincia; 
    }
    
    public void setProvincia(String provincia) { 
        this.provincia = provincia; 
    }
}
