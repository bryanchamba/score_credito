<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
class Mod extends Con
{

	public function iLogg($emp,$use,$app,$acc,$des){
		// $sql = 'select * from f_la_add_log(
		// 	\''.$emp.'\',\''.$use.'\',\''.$app.'\',\''.$acc.'\',\''.$des.'\'
		// );';
		// $this->sel($sql);
	}

	public function sLogin($u,$p){
		$sql = 'select usu_login,emp_codigo,age_codigo,usu_estado from sec_usuarios where usu_login = \''.$u.'\' and usu_passw = \''.$p.'\';';
		return $this->sel($sql);
	}

}