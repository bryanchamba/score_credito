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

	public function sEmpresa(){
		$sql = 'select 
				emp_codigo,
				emp_descri
			from tbl_empresas
			order by emp_codigo;';
		return $this->sel($sql);
	}
	
	public function uEmpresa($cod,$des){
		$sql = 'update tbl_empresas set emp_descri = \''.$des.'\'
			where emp_codigo = \''.$cod.'\';';
		return $this->iud($sql);
	}

}