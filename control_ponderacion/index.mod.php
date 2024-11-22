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

	public function sPonderacion(){
		$sql = 'select 
				pon_estado,
				pon_estdes,
				pon_minval,
				pon_maxval,
				pon_color
			from sco_ponderaciones
			where emp_codigo = '.$this->EMP.' and pon_ponder = \'S\' and mat_codigo = 1
			order by pon_minval;';
		return $this->sel($sql);
	}
	
	public function uPonderacion($est,$val,$mm){
		$upd = $mm == 'MIN' ? ' pon_minval = '.$val.' ' : ' pon_maxval = '.$val.' ';
		$sql = 'update sco_ponderaciones set '.$upd.'
			where emp_codigo = '.$this->EMP.' and pon_estado = \''.$est.'\';';
		return $this->iud($sql);
	}

}