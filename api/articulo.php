<?php 
require_once "../modelos/Articulo.php";
require_once "../modelos/Ingreso.php";
header("Content-Type: application/json");

require_once "./helper.php";


cors();
$ingreso=new Ingreso();
$articulo=new Articulo();
$data = json_decode(file_get_contents('php://input'), true);

$idarticulo=isset($data["idarticulo"])? limpiarCadena($data["idarticulo"]):"";
$idcategoria=isset($data["idcategoria"])? limpiarCadena($data["idcategoria"]):"";
$codigo=isset($data["codigo"])? limpiarCadena($data["codigo"]):"";
$nombre=isset($data["nombre"])? limpiarCadena($data["nombre"]):"";
$stock=isset($data["stock"])? limpiarCadena($data["stock"]):"1";
$descripcion=isset($data["descripcion"])? limpiarCadena($data["descripcion"]):"";
$imagen=isset($data["imagen"])? limpiarCadena($data["imagen"]):"";




switch ($_GET["op"]){

	case 'mostrar':
		$rspta=$articulo->mostrar($idarticulo);
 		//Codificar el resultado utilizando json
 		echo json_encode($rspta);
  break;

  case 'mostrarcode':
  $rspta=$articulo->mostrarcode($codigo);
  //Codificar el resultado utilizando json
  echo json_encode($rspta);
	break;
  
  case 'mostrar_ingreso_by_code':
    $rspta=$articulo->mostrar_ingreso_by_code($codigo);
    //Codificar el resultado utilizando json
    echo json_encode($rspta);
    break;

	case 'listar':
		$rspta=$articulo->listar();
 		//Vamos a declarar un array
 		$data= Array();

 		while ($reg=$rspta->fetch_object()){
      $data[] = $reg; 
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;

	case "selectCategoria":
		require_once "../modelos/Categoria.php";
		$categoria = new Categoria();

		$rspta = $categoria->select();
		while ($row = $rspta->fetch_object())
    $test[] = $row; 
    echo json_encode($test);
	break;

  case 'listarArticulosVenta':
		require_once "../modelos/Articulo.php";
		$articulo=new Articulo();

		$rspta=$articulo->listarActivosVenta();
 		//Vamos a declarar un array
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
      $data[] = $reg; 
 		}

 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;

  case 'guardaryeditar':
		if (empty($idingreso)){
			$rspta=$ingreso->insertar("1","1","1","1","1","12/02/1990","0","0",$data["idarticulo"],$data["cantidad"],$data["precio_compra"],$data["precio_venta"]);

			$myObj["message"] =  $rspta ? "Ingreso registrado" : "No se pudieron registrar todos los datos del ingreso";

      echo json_encode($myObj);

		}
		else {
		}
	break;
}
?>