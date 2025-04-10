<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Moncho Relojes</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Raleway:wght@400;700&display=swap" rel="stylesheet">
  <link rel="icon" type="image/png" sizes="32x32" href="img/clock.png">

</head>
<body>
  <header>
    <mi-header></mi-header>
  </header>
  

  <main class="container mt-5 pt-5">
    <section id="inicio">
      <h1 class="mb-4">Bienvenido a Moncho Relojes</h1>
      <p>
        Bienvenidos a Moncho Relojes, una empresa con amplia trayectoria en el mundo del arte relojero. Nos dedicamos a la venta y distribución de relojes de alta gama, combinando tradición, innovación y precisión en cada uno de nuestros productos. En Moncho Relojes encontrarás una cuidada selección de modelos exclusivos y de las marcas más prestigiosas del sector, pensados para aquellos que buscan calidad, estilo y distinción.
      </p>
      <p>
        Nuestra actividad se centra en ofrecer una experiencia de compra excepcional, acompañada de un servicio personalizado que garantiza la satisfacción de nuestros clientes. Desde el diseño atemporal de piezas clásicas hasta las tendencias más vanguardistas, en Moncho Relojes nos apasiona el detalle y la excelencia en cada reloj que ponemos a tu disposición.
      </p>
      <p>
        Descubre con nosotros la elegancia y precisión que marcan la diferencia. ¡Bienvenido a la experiencia Moncho Relojes!
      </p>
    </section>

    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
        <button type="button"  data-bs-slide-to="0" class="active" aria-current="true" ></button>
        <button type="button"  data-bs-slide-to="1" ></button>
        <button type="button"  data-bs-slide-to="2" ></button>
      </div>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="img/relojero1.jpg" class="d-block w-100" alt="Imagen 1">
        </div>
        <div class="carousel-item">
          <img src="img/relojero2.jpg" class="d-block w-100" alt="Imagen 2">
        </div>
        <div class="carousel-item">
          <img src="img/relojero3.jpg" class="d-block w-100" alt="Imagen 3">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Anterior</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Siguiente</span>
      </button>
    </div>
    
  </main>

  <footer>
    <mi-footer></mi-footer>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/etiquetas.js"></script>  
  <script src="js/carrito.js"></script>
  <script src="js/libjson.js"></script>
  <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>  
</body>
</html>
