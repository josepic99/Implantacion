<?php

/*CONEXION */
$dbhost = "localhost";
$dbuser = "modificador"; //Usuario con permisos de busqueda, inserción y consulta de tablas.
$dbpass = "thegame"; 
$dbname = "memoryTest"; //nombre de la base de datos

//$conexion = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname); conexion procedimental
$conexion = new mysqli($dbhost, $dbuser, $dbpass, $dbname); //conexion orientada a objetos
if(!$conexion)
{
    die("No hay conexion con la base de datos: ".mysqli_connect_error());
}
echo "Conexion exitosa con la base de datos<br>";

/* REGISTRO */
//guardar variables.
    $nombre = $_POST['nombre'];
    $institucion = $_POST['institucion'];
    $password = $_POST['password']; 
    $correo = $_POST['correo'];

    /***Funsion de apollo */
    function correoDisponible($comprobarCorreo,$con){
        $solicitud="SELECT `correo` FROM investigador_login WHERE `correo` LIKE '".$comprobarCorreo."'";
        //$query = mysqli_query($conexion, $solicitud);
        if ($result = $con->query($solicitud)) {
            // determinar el número de filas del resultado 
            $row_cnt = $result->num_rows;
            if($row_cnt == 1){
                echo '<p class="error">Ya existe ese correo en la base de datos</p>'; //cambiar texto
                $result->close();
                return false;
            } else {
                $result->close();
                return true;
            }
        }else{
            echo "error al buscar el correo en la base de datos";
        }       
    }
//comprobar que correo y el usuario no estén en uso  
    
    if (correoDisponible($correo,$conexion)){
         //encriptar contraseña
        $password_hash = password_hash($password, PASSWORD_BCRYPT); //encriptado con Bcrypt 
        //password en la base de datos tiene solo una S.

        $query = "INSERT INTO investigador_login (`nombre`, `institucion`, `correo`, `pasword`,`ultimaConexion`) VALUES ('".$nombre."', '".$institucion."','".$correo."', AES_ENCRYPT('".$password_hash."','".$dbpass."'), NOW())"; 
        $sePudo = $conexion->query($query); //esto es un valor booleano
        
        if ($sePudo) {
            echo '<p class="success">Registro exitoso!</p>';
        } else {
            echo '<p class="error">Algo ha salido mal durante la insercion de los datos en la base de datos, intentelo de nuevo!</p>';
        }
    }else{
        echo '<p class="error">Eliga uno diferente</p>';
    }
    $conexion->close();
?>