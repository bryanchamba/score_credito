<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
session_start();
(!isset($_SESSION['EMP']) || !isset($_SESSION['USE']))?die('Usuario no autorizado'):'';
include '../../lliibb/config/vars.php';
include BKC.SLH.CONEXION;
include THS.DIR_MODEL;
$cls = new Disp();
$cls->EMP = $_SESSION['EMP'];
$cls->AGE = $_SESSION['AGE'];
$tca = $cls->inputSelectCaja();
$age = $cls->inputSelectAgencias();
$cuf = $cls->inputSelectCuartoFrio();
$tcl = $cls->inputSelectClaseExportacion();
//array_unshift($tcl,['ALL','Todos']);
$r = [
	['',$tca],
    '',//bonches por caja
    '1',//numero de cajas
    ['',$age],
    ['',$cuf],
	['A',$tcl]
];
if(filter_input(INPUT_POST,'d1')){
	$select = $cls->sCajas(filter_input(INPUT_POST,'d1'),filter_input(INPUT_POST,'d2'));
    unset($r);
    if($select != false){
        // foreach ($select as $key => $item) {
        //     $tmp = $cls->sAliasFromDet($item[1],$item[3],$item[5],$item[19]);
        //     array_push($select[$key], $tmp[0][0]);
        // }
        $r['CAB'] = $select;

    }else{
        $r['CAB'] = [];
    }
}
echo json_encode($r);