package tienda;

public class DetallePedidoBD {
    private int codigoProducto;
    private String descripcion;
    private int unidades;
    private float precioUnitario;

    public int getCodigoProducto() { 
        return codigoProducto; 
    }
    public void setCodigoProducto(int codigoProducto) { 
        this.codigoProducto = codigoProducto; 
    }

    public String getDescripcion() { 
        return descripcion; 
    }
    public void setDescripcion(String descripcion) { 
        this.descripcion = descripcion; 
    }

    public int getUnidades() { 
        return unidades; 
    }
    public void setUnidades(int unidades) { 
        this.unidades = unidades; 
    }

    public float getPrecioUnitario() { 
        return precioUnitario; 
    }
    public void setPrecioUnitario(float precioUnitario) { 
        this.precioUnitario = precioUnitario; 
    }
}
