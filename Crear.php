<?php

 $DB_HOST = 'localhost';
 $DB_USER = 'root';
 $DB_PASS = '';
 $DB_NAME = 'memorytest';
 
 try{
  $DB_con = new PDO("mysql:host={$DB_HOST};dbname={$DB_NAME}",$DB_USER,$DB_PASS);
  $DB_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
 }
 catch(PDOException $e){
  echo $e->getMessage();
 }
?>

<html>
<body>
<form method="post" enctype="multipart/form-data" class="form-horizontal">   
 <table class="table table-bordered table-responsive">
    <tr>
     <td><label class="control-label">Crear secuencia</label></td>
        <td><input class="input-group" type="file" name="user_image" accept="image/*" /></td>
    </tr>
    <tr>
        <td colspan="2"><button type="submit" name="btnsave" class="btn btn-default">
        <span class="glyphicon glyphicon-save"></span> &nbsp; Guardar
        </button>
        </td>
    </tr>   
    </table>
</body>
</html>
    
</form>

<?php
error_reporting( ~E_NOTICE ); 
 require_once 'dbconfig.php';// dbconfig.php es donde va conexión a la base de datos
			//Igual lo puse hasta arriba del código por si las dudas-
 
 if(isset($_POST['btnsave']))//Es el nombre del botón guardar del HTML.
 {
  $imgFile = $_FILES['user_image']['name'];
  $tmp_dir = $_FILES['user_image']['tmp_name'];
  $imgSize = $_FILES['user_image']['size'];
  
 }else if(empty($imgFile)){
   $errMSG = "Por favor selecciona una imagen.";
  }
  else
  {
   $upload_dir = 'user_images/'; // Subir desde directorio
 
   $imgExt = strtolower(pathinfo($imgFile,PATHINFO_EXTENSION)); // Para obtener la imagen
  
   $valid_extensions = array('jpeg', 'jpg', 'png'); // Para validar las extensiones del archivo(de la imagen)
  
	$pic = rand(1000,1000000).".".$imgExt;
  
	if(in_array($imgExt, $valid_extensions)){

		// La imagen debe de pesar menos de 5MB eso quiere decir el código de acontinuación.
		if($imgSize < 5000000)    {
		 move_uploaded_file($tmp_dir,$upload_dir.$pic);
		}
		else{
		 $errMSG = "La imagen es muy pesada.";
	    }
		
	}else{
		 $errMSG = "Solo se pueden subir archivos: JPG, JPEG, PNG.";  

	}

  if(!isset($errMSG))
  {
   $stmt = $DB_con->prepare('');//Dentro del parentesís va la consulta pa inertar dentro (INSERT INTO ('') VALUE('') )de la tabla de imagenes.
   
   if($stmt->execute())
   {
    $successMSG = "Nuevo registro insertado con éxito ...";
    header("refresh:5;index.html");//No sé si el index tiene ese nombre exactamente sino lo cambias por el nombre del archivo.
   }
   else
   {
    $errMSG = "error al insertar ....";
   }
  }
 }

?>