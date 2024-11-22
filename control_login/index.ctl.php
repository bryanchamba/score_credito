<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
include '../lliibb/config/vars.php';
include CONEXION;
include DIR_MODEL;
$db = new Mod();
$host = $db->getRealIP();
$r = [false,''];
switch(filter_input(INPUT_POST,'OPC')){
	case 'SLG':
		$v = $db->rp($_POST);
		$p = sha1(filter_input(INPUT_POST,'d2'));
		$s = $db->sLogin($v['d1'],$p);
		if($s != false){
			if($s[0][3] == 'A'){
				session_start();
				$_SESSION['USE'] = $s[0][0];
				$_SESSION['EMP'] = $s[0][1];
				$_SESSION['AGE'] = $s[0][2];
				$r = [true, '¡Acceso concedido!','../menu_main'];
				$db->iLogg($s[0][1],$s[0][0],'control_login','access','');
			}else{
				$r[1] = '¡Usuario se encuentra <b>inactivo</b>!';
			}
		}else{
			$r[1] = '¡Usuario o contraseña incorrectos!';
		}
		break;
	
	default:
		$echo = [false,'Default'];
		break;
}
echo json_encode($r);