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

	public function sAgencias(){
		$sql = 'select 
				age_codigo,
				age_descri
			from tbl_agencias
			where emp_codigo = '.$this->EMP.'
			order by emp_codigo;';
		return $this->sel($sql);
	}
	
	public function uAgencia($cod,$des){
		$sql = 'update tbl_agencias set age_descri = \''.$des.'\'
			where emp_codigo = '.$this->EMP.' and age_codigo = \''.$cod.'\';';
		return $this->iud($sql);
	}

}