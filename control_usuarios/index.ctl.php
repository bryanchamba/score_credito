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
	case 'DUSU':
		$v = $db->rp($_POST);
		if($v['d1'] == $db->USE){
			$r[1] = '¡No puede eliminar su propio usuario!';
		}else{
			$d = $db->dUsuario($v['d1']);
			if($d){
				$r = [true, './'];
			}else{
				$r[1] = '¡No se pudo eliminar el registro!';
			}
		}
		break;
	case 'IUSU':
		$v = $db->rp($_POST);
		$v['d2'] = sha1(filter_input(INPUT_POST,'d2'));
		$i = $db->iUsuario($v);
		if($i != false){
			$r = [true, './'];
		}else{
			$r[1] = '¡No se pudo insertar el registro!';
		}
		break;
	case 'UUSU':
		$v = $db->rp($_POST);
		$u = $db->uUsuario($v['d1'],$v['d2']);
		if($u){
			$r = [true, './'];
		}else{
			$r[1] = '¡No se pud actualizar registro!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);