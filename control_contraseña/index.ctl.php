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
	case 'UUSU':
		$v = $db->rp($_POST);
		$pas = sha1(filter_input(INPUT_POST,'d1'));
		$u = $db->uUsuario($pas);
		if($u){
			$r = [true, '¡Contraseña actualizada; Tendra que usar la nueva contraseña en los siguientes inicios de sesión!'];
			//$db->iLogg('control_contraseña','update','Cambio de contraseña');
		}else{
			$r[1] = '¡Antigua contraseña no valida!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);