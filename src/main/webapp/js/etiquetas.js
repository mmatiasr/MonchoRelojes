class MiHeader extends HTMLElement {
  constructor() {
    super();
    const shadow = this.attachShadow({ mode: 'open' });
    shadow.innerHTML = `
      <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Raleway:wght@400;700&display=swap" rel="stylesheet">
      <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        header {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          background-color: #004f39;
          color: white;
          font-family: 'Raleway', sans-serif;
          z-index: 1000;
        }
        nav {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 10px 20px;
        }
        .navbar-brand {
          font-family: 'Playfair Display', serif;
          font-size: 30px;
          text-decoration: none;
          color: white;
        }
        ul {
          list-style: none;
          display: flex;
          align-items: center;
        }
        li {
          position: relative;
          margin-left: 20px;
        }
        a {
          text-decoration: none;
          color: white;
          font-size: 16px;
          cursor: pointer;
        }
        .dropdown-menu {
          position: absolute;
          top: 100%;
          left: 0;
          background-color: #004f39;
          min-width: 150px;
          display: none;
          flex-direction: column;
          padding: 10px 0;
          border-radius: 4px;
        }
        li:hover > .dropdown-menu {
          display: flex;
        }
        .dropdown-menu li {
          padding: 5px 20px;
        }
        .dropdown-menu li a {
          font-size: 14px;
        }
        .icono-carrito {
          height: 50px;
          width: auto;
          filter: brightness(0) saturate(100%) invert(1);
        }
        .spacer {
          height: 70px;
        }
      </style>
      <header>
        <nav>
          <a class="navbar-brand" href="index.jsp">Moncho Relojes</a>
          <ul>
            <li><a href="index.jsp">Inicio</a></li>
            <li><a href="empresa.html">Empresa</a></li>
            <li><a href="contacto.html">Contacto</a></li>
            <li><a href="productos.jsp">Productos</a></li>
            <li>
              <a class="dropdown-toggle">Usuario</a>
              <ul class="dropdown-menu">
                <li><a href="perfil.jsp">Perfil</a></li>
                <li><a href="loginUsuario.jsp">Iniciar Sesión/Registrarse</a></li>
              </ul>
            </li>
            <li>
              <a href="carrito.html">
                <img class="icono-carrito" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAABT0lEQVRIS82VPUgCYRiAPaGGGgycIhp0zFGIBNEpaKq1BrGmgnYhCnRQKFobbCpdaq5JaKghCoKmICcHBxE0yK2met5BOC7vvpeuCw8ePHx/nvu+936sUMCHFXD/0L8KvmyrOeV85y9WZ1+BXSC9l+HGr2TUFhVoegTXsBqEIErTLoQhBm0/Erch12ma89H4ntq01LsJlog9+BC8UrvgJZDYCyRgC86VMsnLwx4cmgTbJFThGZIKwTQ5fZiEeeiYBFMk9EB+F+HJINkkfgYNWBnmmp7kExJ3oQbSwOu4JZiFDbjUCmQGMotPmIM3F4Pczi14h1n40Aok7w4yIA/gsYugxP9F+PGKMW2R9FuHC8P2DMMpTh7tuRrBBAVNiBskV8TXnDkagfLiR6dpBWXK96ECB45WXjH1B0fujggMYMYh8IqpBYGv4Ndz0M5gfAXfzt42GXJxg0gAAAAASUVORK5CYII=" alt="Carrito" style="height: 20px;">
              </a>
            </li>
          </ul>
        </nav>
      </header>
      <div class="spacer"></div>
    `;
  }
}
customElements.define('mi-header', MiHeader);

class MiFooter extends HTMLElement {
  constructor() {
    super();
    const shadow = this.attachShadow({ mode: 'open' });
    shadow.innerHTML = `
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;700&display=swap" rel="stylesheet">
      <script src="js/carrito.js"></script>
      <style>
        .bg {
          background-color: #004f39; 
        }
      </style>
      <footer class="bg text-white fixed-bottom text-center p-3">
        <p>Moncho Relojes</p>
        <a href="https://www.facebook.com" target="_blank">Facebook</a> |
        <a href="https://www.twitter.com" target="_blank">Twitter</a> |
        <a href="https://www.instagram.com" target="_blank">Instagram</a>
      </footer>
    `;
  }
}
customElements.define('mi-footer', MiFooter);
