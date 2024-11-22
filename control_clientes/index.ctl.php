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
	
	case 100:
		$v = $db->rp($_POST);
		$v['npt_edad'] = $edad = date_diff(date_create($v['npt_fecha_nacimento']), date_create(date('Y-m-d')))->y;
		$i = $db->iCliente($v);
		if($i){
			$r = [true, '¡Registro guardado!'];
		}else{
			$r[1] = '¡No se pudo guardar registro!';
		}
		break;
	case 101:
		$v = $db->rp($_POST);
		$s = $db->sCantones($v['d1']);
		if($s != false){
			$r = [true, $s];
		}else{
			$r[1] = [['','¡NO-DATA!']];
		}
		break;
	case 102:
		$v = $db->rp($_POST);
		$v['npt_edad'] = $edad = date_diff(date_create($v['npt_fecha_nacimento']), date_create(date('Y-m-d')))->y;
		$u = $db->uCliente($v);
		if($u){
			$r = [true, '¡Registro actualizado!'];
		}else{
			$r[1] = ['¡No se pudo actualizar registro!'];
		}
		break;
		case 103:
			require '../lliibb/librerias/PHPExcel/Classes/PHPExcel.php';
            $ruta = './files/';
            $nombre = 'clientes' . $ftcode;
            $file = $db->uploadFile($ruta, $nombre, $_FILES);
            if ($file[0][0]) {
                $columnas = ['A', 'B', 'C', 'D', 'E','F','G','H','I','J','K','L','M','N','O','P','Q','R'];
                $data = $db->getInfoExcel($ruta . $nombre . '.xlsx', $columnas, 0, 2, false);
                $count = 0;
				foreach ($data as $item) {
					$i = $db->iClienteMasive($item);
					if ($i) {
						$count++;
					}
				}
				$r = [true, '¡Registros guardados (' . $count . ')!'];
            } else {
                $r = $file[0];
            }
            break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);