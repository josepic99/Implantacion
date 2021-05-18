<?php

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
                            <a class="nav-link" href="#">Acceder</a>
                        </li>
                    </ul>
                </div>
            </div>
    </nav>
</header>';
    /*CONEXION */
    $dbhost = "localhost";
    $dbuser = "buscador"; //Usuario limitado a select
    $dbpass = "thegame"; //Esta contraseña se la puse a todos los usuarios
    $dbname = "memoryTest"; //nombre de la base de datos

    $conexion = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
    if(!$conexion)
    {
        die("No hay conexion con la base de datos: ".mysqli_connect_error());
    }

    /*OBTENCION DE VARIABLES */
    $nombre = $_POST["username"]; //Puede ingresar el correo electronico o el nombre de usuario
    $password = $_POST["password"]; 

	//primero busca con investigador
    $query = mysqli_query($conexion,"SELECT * FROM investigador_login 
                                            WHERE  correo = '".$nombre."' "); //probar cifrado AES
    $numero_filas = mysqli_num_rows($query);

    if ($numero_filas == 1)
    {
        mysqli_free_result($query); //MYSQLI_USE_RESULT obliga a limpiar la varialbe antes de usarla de nuevo
        
        $query = mysqli_query($conexion,"SELECT idInvestigador_login, AES_DECRYPT(`pasword`,'thegame') as pasword FROM `investigador_login` 
                                            WHERE correo = '".$nombre."' ");
        $consulta = mysqli_fetch_assoc($query);
        $passwordDB = $consulta['pasword']; //es pasword con una sola S porque así quedo en la base de datos xd
        
        
        if (password_verify($password, $passwordDB)) {
                $_SESSION['user_id'] = $consulta['idInvestigador_login']; //setear la id de sesion con id de investigador
                echo '<p class="success">Login exitoso!</p>';
                mysqli_free_result($query);
                mysqli_close($conexion);
                //header("Location: cuenta.php");
        } else {
            mysqli_free_result($query);
            mysqli_close($conexion);
                echo '<p class="error">La contraseña y el usuario no coinciden</p>';

        }     	
			
    } else { //Si no lo encuentra entonces busca en la tabla pacientes
        mysqli_free_result($query); //MYSQLI_USE_RESULT obliga a limpiar la varialbe antes de usarla de nuevo
        
        $query = mysqli_query($conexion,"SELECT idPaciente_login, AES_DECRYPT(`pasword`,'thegame') FROM `paciente_login` 
                                            WHERE correo = '".$nombre."' ");
        $consulta = mysqli_fetch_assoc($query);
        $passwordDB = $consulta['pasword']; //es pasword con una sola S porque así quedo en la base de datos xd
        
        if (password_verify($password, $passwordDB)) {
                $_SESSION['user_id'] = $consulta['idPaciente_login']; //setear la id de sesion con id de investigador
                echo '<p class="success">Login exitoso!</p>';
                echo $_SESSION['user_id']; //borrar cuando todo funcione, esto solo es para comprobar.
                mysqli_free_result($query);
                mysqli_close($conexion);
                //header("Location: cuenta.php");
        } else if($numero_filas==0)  //en caso de que ninguna coincida
		{
            echo '<p class="error">Contraseña incorrecta</p>';
		}
    }
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
