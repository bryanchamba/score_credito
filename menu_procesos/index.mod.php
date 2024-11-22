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
			emp_descri, 
			show_msm
			from la_empresa where emp_codigo = \''.$this->EMP.'\';';
		return $this->sel($sql);
	}

	public function uInfo(){
		$sql = 'update la_empresa set show_msm = \'N\' where emp_codigo = \''.$this->EMP.'\';';
		return $this->sel($sql);
	}

}