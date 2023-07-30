<?php 
$env_file_path = realpath(__DIR__."/.env.prod");

  //Check .envenvironment file exists
  if(!is_file($env_file_path)){
      throw new ErrorException("Environment File is Missing.");
  }
  //Check .envenvironment file is readable
  if(!is_readable($env_file_path)){
      throw new ErrorException("Permission Denied for reading the ".($env_file_path).".");
  }
  //Check .envenvironment file is writable
  if(!is_writable($env_file_path)){
      throw new ErrorException("Permission Denied for writing on the ".($env_file_path).".");
  }
  $var_arrs = array();
    // Open the .en file using the reading mode
    $fopen = fopen($env_file_path, 'r');
    if($fopen){
        //Loop the lines of the file
        while (($line = fgets($fopen)) !== false){
            // Check if line is a comment
            $line_is_comment = (substr(trim($line),0 , 1) == '#') ? true: false;
            // If line is a comment or empty, then skip
            if($line_is_comment || empty(trim($line)))
                continue;
 
            // Split the line variable and succeeding comment on line if exists
            $line_no_comment = explode("#", $line, 2)[0];
            // Split the variable name and value
            $env_ex = preg_split('/(\s?)\=(\s?)/', $line_no_comment);
            $env_name = trim($env_ex[0]);
            $env_value = isset($env_ex[1]) ? trim($env_ex[1]) : "";
            $var_arrs[$env_name] = $env_value;
        }
        // Close the file
        fclose($fopen);
    }
    foreach($var_arrs as $name => $value){
      //Using putenv()
      putenv("{$name}={$value}");

      //Or, using $_ENV
      $_ENV[$name] = $value;

      // Or you can use both
  }

echo getenv('MYSQL_HOST');
//Ip de la pc servidor de base de datos
define("DB_HOST", getenv('MYSQL_HOST'));

//Nombre de la base de datos
define("DB_NAME",getenv('DB_NAME'));

//Usuario de la base de datos
define("DB_USERNAME", getenv('MYSQL_USER'));

//Contraseña del usuario de la base de datos
define("DB_PASSWORD", getenv('MYSQL_ROOT_PASSWORD'));
/*
//RASPERRY
//Ip de la pc servidor de base de datos
define("DB_HOST","localhost");

//Nombre de la base de datos
define("DB_NAME", "db_sistema");

//Usuario de la base de datos
define("DB_USERNAME", "user_super");

//Contraseña del usuario de la base de datos
define("DB_PASSWORD", "user_super");
//define("DB_PASSWORD", "");






*/
//definimos la codificación de los caracteres
define("DB_ENCODE","utf8");

//Definimos una constante como nombre del proyecto
define("PRO_NOMBRE","Abarrote");
?>