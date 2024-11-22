<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
session_start();
(!isset($_SESSION['EMP']) || !isset($_SESSION['USE']))?die('Usuario no autorizado'):'';
include '../lliibb/config/vars.php';
include CONEXION;
include DIR_MODEL;
$db = new Mod();
$db->EMP = $_SESSION['EMP'];
$db->AGE = $_SESSION['AGE'];
$db->USE = $_SESSION['USE'];
$fecha = Date('Y-m-d');
$hora = Date('h:i:s');
$host = $db->getRealIP();
$usu = $_SESSION['USE'];
$ftcode = Date('YmdHis');
$r = [false,''];
switch(filter_input(INPUT_POST,'OPC')){
	// case 1:
	// 	$v = $db->rp($_POST);
	// 	$s = $db->srhCliente($v['d1']);
	// 	if($s){
	// 		$r = [true, $s];
	// 	}else{
	// 		$r[1] = [['NO-DATA']];
	// 	}
	// 	break;
	
	case 100:
		$v = $db->rp($_POST);
		$u = $db->uDetIndicador($v);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 101:
		$v = $db->rp($_POST);
		$u = $db->uPorIndicador($v);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 102:
		$v = $db->rp($_POST);
		$u = $db->uPor5c($v);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);