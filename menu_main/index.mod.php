<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
class Mod extends Con
{

	public $AGE = null;
	public $EMP = null;
	public $USE = null;

	public function sInfo(){
		$sql = 'select 
			e.emp_descri,
			a.age_descri
			from tbl_agencias a, tbl_empresas e where a.emp_codigo = e.emp_codigo and 
			a.emp_codigo = '.$this->EMP.' and a.age_codigo = '.$this->AGE.';';
		return $this->sel($sql);
	}

}