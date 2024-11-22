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

	public function sUsuarios(){
		$sql = 'select 
				u.usu_login,
				d.dus_apelli||\' \'||d.dus_nombre,
				u.usu_estado
			from sec_usuarios u, tbl_dat_usuarios d
		where u.emp_codigo = d.emp_codigo and 
			u.dus_codigo = d.dus_codigo and 
			u.emp_codigo = \''.$this->EMP.'\' 
			order by u.usu_login;';
		return $this->sel($sql);
	}

	public function dUsuario($cod){
		$sql = 'delete from sec_usuarios
			where emp_codigo = \''.$this->EMP.'\' and usu_login = \''.$cod.'\';';
		return $this->iud($sql);
	}
	
	public function iUsuario($vls){
		$sql = 'select * from f_add_usuario(
			'.$this->EMP.'::smallint,
			'.$this->AGE.'::smallint,
			\''.$vls['d1'].'\'::character varying,
			\''.$vls['d2'].'\'::character varying,
			\''.$vls['d3'].'\'::character varying,
			\''.$vls['d4'].'\'::character varying,
			\''.$vls['d5'].'\'::character varying,
			\''.$vls['d6'].'\'::character varying,
			\''.$this->USE.'\'::character varying
		);';
		return $this->sel($sql);
	}
	
	public function uUsuario($cod,$act){
		$sql = 'update sec_usuarios set
				usu_estado = \''.$act.'\'
			where emp_codigo = \''.$this->EMP.'\' and usu_login = \''.$cod.'\';';
		return $this->iud($sql);
	}

}