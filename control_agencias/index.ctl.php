<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
session_start();
(!isset($_SESSION['EMP']) || !isset($_SESSION['USE']) || !isset($_SESSION['AGE']))?die('Usuario no autorizado'):'';
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
	case 'UEMP':
		$v = $db->rp($_POST);
		$u = $db->uAgencia($v['d1'],$v['d2']);
		if($u){
			$r = [true, './'];
			//$db->iLogg('control_empresa','update',$v['d3'].' => '.$v['d2']);
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);