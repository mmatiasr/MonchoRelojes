class ProductoCarrito {
    constructor(codigo, descripcion, imagen, cantidad, precio, existencias) {
      this.codigo = codigo;             
      this.descripcion = descripcion;   
      this.imagen = imagen;             
      this.cantidad = cantidad;         
      this.precio = precio;            
      this.existencias = existencias;   
    }
  }
  
  let carrito = null;
  
  function cargarCarrito() {
    if (carrito === null) {
      carrito = JSON.parse(localStorage.getItem("mi-carrito-almacenado"));
      if (carrito === null) {
        carrito = []; 
      }
    }
  }
  
  function guardarCarrito() {
    localStorage.setItem("mi-carrito-almacenado", JSON.stringify(carrito));
  }
  

  function anadirCarrito(codigo, descripcion, imagen, precio, existencias) {
    cargarCarrito();
    
    let productoExistente = carrito.find(prod => prod.codigo === codigo);
    if (productoExistente) {
      if (productoExistente.cantidad < existencias) {
        productoExistente.cantidad++;
        alert("Se ha incrementado la cantidad del producto en el carrito.");
      } else {
        alert("No hay suficientes existencias disponibles.");
      }
    } else {
      let nuevoProducto = new ProductoCarrito(codigo, descripcion, imagen, 1, precio, existencias);
      carrito.push(nuevoProducto);
      alert("Producto añadido al carrito.");
    }
    
    guardarCarrito();
    
    if(document.getElementById("tabla-carrito")){
      mostrarCarrito();
    }
  }
  
  function eliminarProducto(codigo) {
    cargarCarrito();
    carrito = carrito.filter(prod => prod.codigo !== codigo);
    guardarCarrito();
    alert("Producto eliminado del carrito.");
    location.reload(); 
  }
  
  function modificarCantidad(codigo, nuevaCantidad) {
    cargarCarrito();
    let producto = carrito.find(prod => prod.codigo === codigo);
    if (producto) {
      if (nuevaCantidad <= 0) {
        eliminarProducto(codigo);
      } else if (nuevaCantidad <= producto.existencias) {
        producto.cantidad = nuevaCantidad;
        alert("Cantidad modificada.");
      } else {
        alert("La cantidad solicitada excede las existencias.");
      }
      guardarCarrito();
      location.reload();
    }
  }
  

  function mostrarCarrito() {
    cargarCarrito();
    let contenido = "";
    let total = 0;
    carrito.forEach(prod => {
      let subtotal = prod.precio * prod.cantidad;
      contenido += `
        <tr>
          <td>${prod.codigo}</td>
          <td>${prod.descripcion}</td>
          <td><img src="${prod.imagen}" alt="${prod.descripcion}" style="width:50px;"></td>
          <td>${prod.cantidad}</td>
          <td>${prod.precio.toFixed(2)} €</td>
          <td>${subtotal.toFixed(2)} €</td>
          <td>
            <button onclick="modificarCantidad(${prod.codigo}, ${prod.cantidad - 1})">-</button>
            <button onclick="modificarCantidad(${prod.codigo}, ${prod.cantidad + 1})">+</button>
            <button onclick="eliminarProducto(${prod.codigo})">Eliminar</button>
          </td>
        </tr>
      `;
      total += subtotal;
    });
    contenido += `<tr><td colspan="5"><strong>Total</strong></td><td colspan="2"><strong>${total.toFixed(2)} €</strong></td></tr>`;
    document.getElementById("tabla-carrito").innerHTML = contenido;
  }
  

  function generarTicket() {
    cargarCarrito();
    let ticketHTML = "<h2>Ticket de Compra</h2><table border='1' style='width:100%; text-align:left;'><tr><th>Código</th><th>Descripción</th><th>Cantidad</th><th>Precio</th><th>Subtotal</th></tr>";
    let total = 0;
    carrito.forEach(prod => {
      let subtotal = prod.precio * prod.cantidad;
      ticketHTML += `<tr>
        <td>${prod.codigo}</td>
        <td>${prod.descripcion}</td>
        <td>${prod.cantidad}</td>
        <td>${prod.precio.toFixed(2)} €</td>
        <td>${subtotal.toFixed(2)} €</td>
      </tr>`;
      total += subtotal;
    });
    ticketHTML += `<tr>
        <td colspan="4"><strong>Total</strong></td>
        <td><strong>${total.toFixed(2)} €</strong></td>
      </tr></table>`;
    document.getElementById("ticket-compra").innerHTML = ticketHTML;
  }
  
  function eliminarCarrito() {
    carrito = []; 
    guardarCarrito(); 
    alert("El carrito ha sido vaciado.");
    location.reload();
  }
  
  function ejemploModificacion() {
    cargarCarrito();
    guardarCarrito();
  }

function eliminarCarritoyMostrarTicket(){
    eliminarCarrito();
    generarTicket();
  }

  window.anadirCarrito = anadirCarrito;

  