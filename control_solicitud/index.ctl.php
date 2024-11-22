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
	case 1:
		$v = $db->rp($_POST);
		$s = $db->srhCliente($v['d1']);
		if($s){
			$r = [true, $s];
		}else{
			$r[1] = [['NO-DATA']];
		}
		break;
	case 2:
		$v = $db->rp($_POST);
		$s = $db->srhDatCliente($v['d1']);
		$r = [true, $s];
		break;
	case 3:
		$v = $db->rp($_POST);
		$s = $db->srhActEco($v['d1']);
		if($s){
			$r = [true, $s];
		}else{
			$r[1] = [['NO-DATA']];
		}
		break;
	case 4:
		$v = $db->rp($_POST);
		$s = $db->sImpresiones($v['d1'],$v['d2']);
		if($s){
			$r = [true, $s];
		}else{
			$r[1] = [['NO-DATA','','','-1']];
		}
		break;
	
	case 100:
		$v = $db->rp($_POST);
		$i = $db->iSolicitud([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5'],$v['d6'],$v['d7'],$v['d8'],$v['d9'],$v['d10'],$v['d11']]);
		$r = json_decode($i[0][0],true);
		break;
	case 101:
		$v = $db->rp($_POST);
		$u = $db->uSolValDet([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5'],$v['d6'],$v['d7']]);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 102:
		$v = $db->rp($_POST);
		$u = $db->uSolValDet5c([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5']]);
		if($u){
			$db->uSolCal5c($v['d1'],$v['d2']);
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 103:
		$v = $db->rp($_POST);
		$u = $db->uSolSigDet([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5'],$v['d6'],$v['d7']]);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 104:
		$v = $db->rp($_POST);
		$u = $db->iSolItmDet([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5'],$v['d100'],$v['d101'],$v['d102']]);
		if($u){
			$r = [true, '¡Registro insertado!'];
		}else{
			$r[1] = '¡No se pudo insertar registro!';
		}
		break;
	case 105:
		$v = $db->rp($_POST);
		$u = $db->dSolItmDet([$v['d1'],$v['d2'],$v['d3'],$v['d4'],$v['d5'],$v['d6']]);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 106:
		$v = $db->rp($_POST);
		$u = $db->uMargenImprev($v['d1'],$v['d2'],$v['d3']);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 107:
		$v = $db->rp($_POST);
		$u = $db->uRecoCredito($v['d1'],$v['d2'],$v['d3'],$v['d4']);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 108:
		$v = $db->rp($_POST);
		$u = $db->uDesRecoCredito($v['d1'],$v['d2'],$v['d3']);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 109:
		$v = $db->rp($_POST);
		$u = $db->uSolicitud($v);
		if($u){
			$db->uSolCal5c($v['d0'],$v['d1']);
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = '¡No se pudo actualizar registro!';
		}
		break;
	case 110:
		$v = $db->rp($_POST);
		$u = $db->dSolicitud($v);
		if($u){
			$r = [true, '¡Registro eliminado!'];
		}else{
			$r[1] = '¡No se pudo eliminar registro!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);