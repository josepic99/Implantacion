<?php 
/* No se puede acceder a esta parte sin haber iniciado sesión 
Aqui debería ir un comprovador de inicion de sesión */
//if (sesion inactiva){ redirigir a pagina principal}? pendiente

/*Obtiene variables iniciales*/
$nombre = $_SESSION['logged_in_user_name'];

/* imprime metadatos y las primeras etiquetas del html*/
echo '
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/Styles.css">

    <link rel="shortcut icon" href="img/logoS.ico" type="image/x-ico">
    <title>Memory Test | Main Page</title>
    <meta property="og:image" content="img/logoS.jpg">
    <meta property="og:title" content="Memory Test | main">
    <meta name="author" content="Los_Olvidados">
    <meta name="robots" content="index">
</head>
';
/* Impresión de cabecera */

echo '<body>
<header class="header">
    <nav class="navbar navbar-expand-md navbar-dark">
            <figure class="logo a.navbar-brand">
                <a href="index.html">
                    <img src="img/logoS.jpg"  
                    alt="logo" 
                    onmousedown="return false" 
                    onkeydown="return false" 
                    oncopy="return false" 
                    oncontextmenu="return false">
                </a>
            </figure>
            <div class="container">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#barra">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="barra">
                    <ul class="navbar-nav ml-auto">
                        <!-- Si se inició sesión como PACIENTE
							<li class="nav-item">
								<a class="nav-link" href="prueba.php">Prueba de memoria</a>
							</li>
                        -->
                        <!-- Si se inició sesión como INVESTIGADOR
                            <li class="nav-item">
                                <a class="nav-link" href="pacientes.php">Pacientes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="secuencias.php">Tiras de imagenes</a>
                            </li> 
                        -->
                        <li class="nav-item">
                            <a class="nav-link" href="#">'.$nombre.'</a>
                        </li>
                    </ul>
                </div>
            </div>
    </nav>
</header>';

/*Aquí comienza la página de cuenta. Debe cargar los datos de la cuenta */
echo '<br><br><br><br><br><br><br>';
print "Inicio de sesión exitoso";
echo'<a href="logout.php">Cerrar Sesión</a>';
echo '<br><br><br><br><br><br><br>';

/* Pie y cierre de página, y referencias a scripts */
echo '
<br>
<footer class="footer">
    <div class="container">
        <div class="row justify-content-md-end">
            <h5 style="font-size: 10px">
                    App de tira de imagenes © 2020
            </h5>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body></html>';

?>