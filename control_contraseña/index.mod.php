<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
class Mod extends Con
{

	public $AGE = null;
	public $EMP = null;
	public $USE = null;

	public function iLogg($app,$acc,$des){
		$sql = 'select * from f_la_add_log(
			\''.$this->EMP.'\',\''.$this->USE.'\',\''.$app.'\',\''.$acc.'\',\''.$des.'\'
		);';
		$this->sel($sql);
	}
	
	public function uUsuario($pas){
		$sql = 'update sec_usuarios set
			usu_passw = \''.$pas.'\'
		where emp_codigo = \''.$this->EMP.'\' and usu_login = \''.$this->USE.'\';';
		return $this->iud($sql);
	}

}