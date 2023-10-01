<?php
require_once "../modelos/Usuario.php";
header("Content-Type: application/json");

$usuario=new Usuario();
require_once "./helper.php";
cors();
$data = json_decode(file_get_contents('php://input'), true);


$login=isset($data["login"])? limpiarCadena($data["login"]):"";
$clave=isset($data["clave"])? limpiarCadena($data["clave"]):"";

$idusuario=isset($data["idusuario"])? limpiarCadena($data["idusuario"]):"";
$nombre=isset($data["nombre"])? limpiarCadena($data["nombre"]):"";
$tipo_documento=isset($data["tipo_documento"])? limpiarCadena($data["tipo_documento"]):"";
$num_documento=isset($data["num_documento"])? limpiarCadena($data["num_documento"]):"";
$direccion=isset($data["direccion"])? limpiarCadena($data["direccion"]):"";
$telefono=isset($data["telefono"])? limpiarCadena($data["telefono"]):"";
$email=isset($data["email"])? limpiarCadena($data["email"]):"";
$cargo=isset($data["cargo"])? limpiarCadena($data["cargo"]):"";
$imagen=isset($_POST["imagen"])? limpiarCadena($_POST["imagen"]):"";

switch ($_GET["op"]){

	case 'mostrar':
		$rspta= $usuario->mostrar($idusuario);
 		//Codificar el resultado utilizando json
    // if($rspta && $rspta->imagen)
    //   $rspta->imagen  ='/files/usuarios/' . $rspta->imagen;
 		echo json_encode($rspta);
	break;

	case 'listar':
		$rspta=$usuario->listar();
 		//Vamos a declarar un array
 		$data= Array();

 		while ($reg=$rspta->fetch_object()){
      // if($reg && $reg->imagen)
      //   $reg->imagen  ='/files/usuarios/' . $reg->imagen;
      $reg->clave ='';
 			$data[]= $reg;
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;

	case 'permisos':
		//Obtenemos todos los permisos de la tabla permisos
		require_once "../modelos/Permiso.php";
		$permiso = new Permiso();
		$rspta = $permiso->listar();

		//Obtener los permisos asignados al usuario
		$id=$_GET['id'];
		$marcados = $usuario->listarmarcados($id);
		//Declaramos el array para almacenar todos los permisos marcados
		$valores=array();

		//Almacenar los permisos asignados al usuario en el array
		while ($per = $marcados->fetch_object())
			{
				array_push($valores, $per->idpermiso);
			}
      $resultado = array();
		//Mostramos la lista de permisos en la vista y si están o no marcados
		while ($reg = $rspta->fetch_object())
				{
					$sw=in_array($reg->idpermiso,$valores)? true :false;
          if ($sw) {
          $myObj["idpermiso"] = $reg->idpermiso;
          $myObj["nombre"] = $reg->nombre;
          array_push($resultado, $myObj);
          }
				}
        echo json_encode($resultado);

	break;

	case 'verificar':

    $logina=isset($data["email"])? limpiarCadena($data["email"]):"";
    $clavea=isset($data["password"])? limpiarCadena($data["password"]):"";
    
    $clavehash=hash("SHA256",$clavea);

		$rspta=$usuario->verificar($logina, $clavehash);

		$fetch=$rspta->fetch_object();
    // if($fetch && $fetch->imagen)
    //   $fetch->imagen  ='/files/usuarios/' . $fetch->imagen;

	  echo json_encode($fetch);
	break;
}
?>