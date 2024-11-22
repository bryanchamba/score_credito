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
	case 'S-DAT-CLI':
		$v = $db->rp($_POST);
		$s = $db->sTblCli($v['d1']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'S-DAT-PRO':
		$v = $db->rp($_POST);
		$s = $db->sTblPro($v['d1']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'S-DAT-PROD':
		$v = $db->rp($_POST);
		$s = $db->sTblProDet($v['d1'],$v['d2']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'S-DAT-CAN':
		$v = $db->rp($_POST);
		$s = $db->sTblCan($v['d1']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'S-DAT-CAND':
		$v = $db->rp($_POST);
		$s = $db->sTblCanDet($v['d1'],$v['d2']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'S-DAT-JUR':
		$v = $db->rp($_POST);
		$s = $db->sTblJur($v['d1']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,'NO-DATA'];
		}
		break;
	case 'I-DD':
		$v = $db->rp($_POST);
		$ruta = '../files/diligencias/';
		$nombre = 'diligencia'.$v['d1'].'-'.$ftcode;
		$file = $db->uploadFile($ruta,$nombre,$_FILES);
		$i = $db->iDebDil([$v['d1'],$v['d2'],$v['d4'],$v['d3'],$v['d5'],$file[0][4]]);
		if($i){
			$r = [true,'Diligencia guardada'];
		}else{
			$r = [false,'¡No se pudo ingresar registro!'];
		}
		break;
	case 'S-TCLI':
		$v = $db->rp($_POST);
		$s = $db->sTot($v['d1']);
		if($s != false){
			$r = [true,$s];
		}else{
			$r = [false,[[0]]];
		}
		break;
	
	
	default:
		$r = [false,'Default'];
		break;
}
echo json_encode($r);