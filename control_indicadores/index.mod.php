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
			'.$this->EMP.',\''.$this->USE.'\',\''.$app.'\',\''.$acc.'\',\''.$des.'\'
		);';
		$this->sel($sql);
	}

	public function sMatrices(){
		$sql = 'select 
				mat_codigo,
				mat_descri
			from sco_matrices 
			where emp_codigo = '.$this->EMP.'
			order by mat_codigo;';
		return $this->sel($sql);
	}
	
	public function sIndicadores(){
		$sql = 'select 
				tdo_codigo,
				tdo_descri
			from sco_indicadores 
			order by tdo_codigo;';
		return $this->sel($sql);
	}
	
	public function sEstCivil(){
		$sql = 'select 
				eci_codigo,
				eci_descri
			from tbl_est_civil 
			order by eci_codigo;';
		return $this->sel($sql);
	}
	
	public function sProvincias(){
		$sql = 'select 
				pro_codigo,
				pro_descri
			from tbl_provincias 
			order by pro_codigo;';
		return $this->sel($sql);
	}
	
	public function sInfoCliente($cod){
		$sql = 'select 
			cli_codigo,
			tdo_codigo,
			cli_identi,
			cli_nrosoc,
			cli_apelli,
			cli_nombre,
			cli_fecnac,
			cli_genero,
			eci_codigo,
			pro_codigo,
			can_codigo,
			cli_dirdom,
			cli_secdom,
			cli_telefo,
			cli_celula,
			cli_dirtra,
			cli_sectra,
			cli_teltra 
		from sco_clientes 
		where emp_codigo = '.$this->EMP.' and cli_codigo = '.$cod.';';
		return $this->sel($sql);
	}
	
	public function srhCliente($ide){
		$w = is_numeric($ide) ? ' and cli_identi like \''.$ide.'%\' ' : ' and cli_apelli||\' \'||cli_nombre like \'%'.$ide.'%\' ';
		$sql = 'select cli_codigo||\' | \'||cli_identi||\' - \'||cli_apelli||\' \'||cli_nombre from sco_clientes where emp_codigo = '.$this->EMP.' '.$w.' limit 5;';
		return $this->sel($sql);
	}
	
	public function srhActEco($act){
		$sql = 'select aec_codigo||\' | \'||aec_auxcod||\' - \'||aec_descri from tbl_act_economica 
			where aec_auxcod like \'%'.$act.'%\' or aec_descri like \'%'.$act.'%\' limit 5;';
		return $this->sel($sql);
	}

	public function sCountCli(){
		$sql = 'select count(cli_codigo)
			from sco_clientes
			where emp_codigo = '.$this->EMP.';';
		$nro = $this->sel($sql);
		return $nro[0][0];
	}
	
	public function sClientes($bus,$lmt,$oft){
		$w = $bus[0] != '' ? (!is_numeric($bus) ? ' and cli_apelli||\' \'||cli_nombre like \'%'.$bus[0].'%\' ' : ' and cli_identi like \'%'.$bus[0].'%\' ') : '';
		$sql = 'select cli_identi,
				cli_apelli,
				cli_nombre,
				cli_fecnac,
				cli_genero,
				eci_codigo,
				cli_celula,
				null,
				null,
				null,
				null,
				cli_codigo
			from sco_clientes 
			where emp_codigo = '.$this->EMP.' '.$w.'
			order by cli_apelli
			limit '.$lmt.' offset '.$oft.';';
		return $this->sel($sql);
	}

	public function sAuxSolicitud($age,$cod){
		$sql = 'select 
			sol_estado,sol_reccre,sol_marimp,sol_monto,mat_codigo,sol_cuota,sol_derecr
			from sco_solicitudes 
			where sol_auxest = \'A\' and 
			emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.';';
		return $this->sel($sql);
	}
	
	public function sSolicitud($age,$cod){
		$sql = 'select c.cli_apelli||\' \'||c.cli_nombre,
			a.aec_descri,a.aec_codigo,
			s.mat_codigo,s.sol_fecha,
			s.sol_monto,s.sol_intere,s.sol_plazo,s.sol_cuota,
			s.sol_listas,s.sol_vincul,s.sol_inspec,s.sol_estado
			from sco_solicitudes s, sco_clientes c, tbl_act_economica a
			where s.emp_codigo = c.emp_codigo and s.cli_codigo = c.cli_codigo and 
			s.aec_codigo = a.aec_codigo and sol_auxest = \'A\' and 
			s.emp_codigo = '.$this->EMP.' and s.age_codigo = '.$age.' and s.sol_codigo = '.$cod.';';
		return $this->sel($sql);
	}

	public function sDetSol_1($age,$cod){
		$sql = 'select tma_codigo,tma_descri,tma_cobpat
			from sco_sol_tit_matrices
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.'
			order by tma_codigo;';
		return $this->sel($sql);
	}

	public function sTotDetSol_1_cobpat($age,$cod,$tma,$mat){
		$w = $mat == 2 ? ' and tm.dma_codigo = 3 ' : '';
		$sql = 'select tm.dma_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and mid_signo = \'+\'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and mid_signo = \'-\'),0))
			from sco_sol_det_matrices tm 
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and tma_codigo = '.$tma.$w.';';
		return $this->sel($sql);
	}
	
	public function sDetSol_2($age,$cod,$tma){
		$sql = 'select dma_codigo,dma_descri,dma_show
			from sco_sol_det_matrices
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and tma_codigo = '.$tma.'
			order by dma_codigo;';
		return $this->sel($sql);
	}
	
	public function sDetSol_3($age,$cod,$tma,$dma){
		$sql = 'select dmi_codigo,dmi_descri,dmi_show
			from sco_sol_det_matri_items
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.'
			order by dmi_codigo;';
		return $this->sel($sql);
	}
	
	public function sTotDetSol_3($age,$cod,$tma,$dma){
		$sql = 'select 
			coalesce((select sum(mid_valor)
			from sco_sol_det_matri_items_det
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.' and mid_signo = \'+\'),0)
			-
			coalesce((select sum(mid_valor)
			from sco_sol_det_matri_items_det
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.' and mid_signo = \'-\'),0);';
		return $this->sel($sql);
	}
	
	public function sDetSol_4($age,$cod,$tma,$dma,$dmi){
		$sql = 'select mid_codigo,mid_descri,mid_valor,mid_signo
			from sco_sol_det_matri_items_det
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.' and dmi_codigo = '.$dmi.'
			order by mid_codigo;';
		return $this->sel($sql);
	}
	
	public function sTotDetSol_4($age,$cod,$tma,$dma,$dmi){
		$sql = 'select 
			coalesce((select sum(mid_valor)
			from sco_sol_det_matri_items_det
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.' and dmi_codigo = '.$dmi.' and mid_signo = \'+\'),0)
			-
			coalesce((select sum(mid_valor)
			from sco_sol_det_matri_items_det
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and 
			tma_codigo = '.$tma.' and dma_codigo = '.$dma.' and dmi_codigo = '.$dmi.' and mid_signo = \'-\'),0)';
		return $this->sel($sql);
	}

	public function sDet5cSol_1($mat){
		$sql = 'select ind_codigo,ind_descri,ind_valpor
			from sco_indicadores
			where emp_codigo = '.$this->EMP.' and mat_codigo = '.$mat.'
			order by ind_codigo;';
		return $this->sel($sql);
	}
	
	public function sDet5cSol_2($mat,$ind){
		$sql = 'select cvi_codigo,cvi_descri,cvi_valpor
			from sco_cab_var_indicadores
			where emp_codigo = '.$this->EMP.' and mat_codigo = '.$mat.' and ind_codigo = '.$ind.' and cvi_tomar is null
			order by cvi_codigo;';
		return $this->sel($sql);
	}

	public function uPorIndicador($vls){
		$sql = 'update sco_cab_var_indicadores set 
			cvi_valpor = \''.$vls['d4'].'\' 
			where emp_codigo = '.$this->EMP.' and 
			mat_codigo = '.$vls['d1'].' and 
			ind_codigo = '.$vls['d2'].' and 
			cvi_codigo = '.$vls['d3'].';';
		return $this->iud($sql);
	}
	
	public function uPor5c($vls){
		$sql = 'update sco_indicadores set 
			ind_valpor = \''.$vls['d3'].'\' 
			where emp_codigo = '.$this->EMP.' and 
			mat_codigo = '.$vls['d1'].' and 
			ind_codigo = '.$vls['d2'].';';
		return $this->iud($sql);
	}
	
	public function sDet5cSol_3($mat,$ind,$cvi){
		$sql = 'select dvi_codigo,dvi_descri,dvi_valor
			from sco_det_var_indicadores
			where emp_codigo = '.$this->EMP.' and mat_codigo = '.$mat.' and 
			ind_codigo = '.$ind.' and cvi_codigo = '.$cvi.'
			order by dvi_codigo;';
		return $this->sel($sql);
	}
	
	public function sDet5cSol_3_rep($age,$cod,$ind,$cvi){
		$sql = 'select dvi_codigo,dvi_descri,dvi_valor
			from sco_sol_det_var_indicadores
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and ind_codigo = '.$ind.' and cvi_codigo = '.$cvi.' and dvi_select = \'A\'
			order by dvi_codigo;';
		return $this->sel($sql);
	}

	private function sCodCli(){
		$sql = 'select coalesce(max(cli_codigo), 0) + 1 from sco_clientes 
			where emp_codigo = '.$this->EMP.';';
		$cod = $this->sel($sql);
		return $cod[0][0];
	}

	public function iCarSolicitud($vls){
		$sql = 'select * from f_car_solicitud(
			'.$this->EMP.'::smallint,
			'.$this->AGE.'::smallint,
			'.$vls[0].'::smallint,
			'.$vls[1].'::smallint
		);';
		return $this->sel($sql);
	}
	
	public function sCantones($pro){
		$sql = 'select can_codigo,can_descri from tbl_cantones where pro_codigo = '.$pro.' order by can_descri;';
		return $this->sel($sql);
	}

	public function uDetIndicador($vls){
		$sql = 'update sco_det_var_indicadores set 
			dvi_valor = \''.$vls['d5'].'\' 
			where emp_codigo = '.$this->EMP.' and 
			mat_codigo = '.$vls['d1'].' and 
			ind_codigo = '.$vls['d2'].' and 
			cvi_codigo = '.$vls['d3'].' and 
			dvi_codigo = '.$vls['d4'].';';
		return $this->iud($sql);
	}

	private function sCodSolItmDet($vls){
		$sql = 'select coalesce(max(mid_codigo),0)+1 from sco_sol_det_matri_items_det 
			where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls[0].' and 
			sol_codigo = '.$vls[1].' and 
			tma_codigo = '.$vls[2].' and 
			dma_codigo = '.$vls[3].' and 
			dmi_codigo = '.$vls[4].';';
		$cod = $this->sel($sql);
		return $cod[0][0];
	}
	
	public function iSolItmDet($vls){
		$cod = $this->sCodSolItmDet($vls);
		$sql = 'insert into sco_sol_det_matri_items_det values(
			'.$this->EMP.',
			'.$vls[0].',
			'.$vls[1].',
			'.$vls[2].',
			'.$vls[3].',
			'.$vls[4].',
			'.$cod.',
			\''.$vls[5].'\',
			'.$vls[6].',
			\''.$vls[7].'\');';
		return $this->iud($sql);
	}
	
	public function dSolItmDet($vls){
		$sql = 'delete from sco_sol_det_matri_items_det where
			emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls[0].' and 
			sol_codigo = '.$vls[1].' and 
			tma_codigo = '.$vls[2].' and 
			dma_codigo = '.$vls[3].' and 
			dmi_codigo = '.$vls[4].' and 
			mid_codigo = '.$vls[5].';';
		return $this->iud($sql);
	}
	
	public function uSolValDet5c($vls){
		$sql = 'update sco_sol_det_var_indicadores set 
		dvi_select = null 
		where emp_codigo = '.$this->EMP.' and 
		age_codigo = '.$vls[0].' and 
		sol_codigo = '.$vls[1].' and 
		ind_codigo = '.$vls[2].' and 
		cvi_codigo = '.$vls[3].';
		update sco_sol_det_var_indicadores set 
			dvi_select = \'A\' 
			where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls[0].' and 
			sol_codigo = '.$vls[1].' and 
			ind_codigo = '.$vls[2].' and 
			cvi_codigo = '.$vls[3].' and 
			dvi_codigo = '.$vls[4].';';
		return $this->iud($sql);
	}
	
	public function uSolCal5c($age,$cod){
		$sql = 'select * from f_cal_solicitud('.$this->EMP.'::smallint,'.$age.'::smallint,'.$cod.'::smallint);';
		return $this->sel($sql);
	}


	public function sCapPago($age,$cod,$mat,$tma){
		$w = $mat == 1 ? ' and tm.dma_codigo in (1,2) ' : '';
		$sql = 'select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = \'+\'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = \'-\'),0)) 
			from sco_sol_det_matri_items tm 
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and tma_codigo = '.$tma.$w.';';
		return $this->sel($sql);
	}

	public function uMargenImprev($age,$cod,$val){
		$sql = 'update sco_solicitudes set sol_marimp = '.$val.'
		where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.';';
		return $this->iud($sql);
	}
	
	public function uRecoCredito($age,$cod,$rec,$des){
		$sql = 'update sco_solicitudes set sol_reccre = \''.$rec.'\',sol_derecr = \''.$des.'\'
		where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.';';
		return $this->iud($sql);
	}
	
	public function uDesRecoCredito($age,$cod,$des){
		$sql = 'update sco_solicitudes set sol_derecr = \''.$des.'\'
		where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.';';
		return $this->iud($sql);
	}
	
	public function sEmpAge($age){
		$sql = 'select e.emp_descri,a.age_descri from tbl_agencias a, tbl_empresas e
		where a.emp_codigo = e.emp_codigo and a.emp_codigo = '.$this->EMP.' and a.age_codigo = '.$age.';';
		return $this->sel($sql);
	}
	
	public function sdatSolicitud($age,$cod){
		$sql = 'select c.cli_nrosoc,
			c.cli_apelli||\' \'||c.cli_nombre,
			c.cli_dirdom,
			c.cli_secdom,
			c.cli_edad,
			c.cli_dirtra,
			c.cli_sectra,
			c.cli_identi,
			c.cli_teltra,
			c.cli_genero,
			c.eci_codigo,
			c.cli_telefo,
			c.cli_celula,
			e.eci_descri,
			ca.can_descri,
			p.pro_descri,
			s.sol_listas,
			s.sol_vincul,
			s.sol_inspec,
			null,
			null,
			s.sol_estado,
			s.sol_reccre,
			s.sol_derecr,
			s.mat_codigo,
			s.sol_monto,
			s.sol_intere,
			s.sol_plazo,
			s.sol_cuota,
			s.sol_marimp
		from sco_solicitudes s, sco_clientes c, tbl_est_civil e, tbl_provincias p, tbl_cantones ca
		where s.emp_codigo = c.emp_codigo and 
			s.cli_codigo = c.cli_codigo and
			c.eci_codigo = e.eci_codigo and
			c.pro_codigo = p.pro_codigo and
			c.pro_codigo = ca.pro_codigo and
			c.can_codigo = ca.can_codigo and
			s.emp_codigo = '.$this->EMP.' and 
			s.age_codigo = '.$age.' and 
			s.sol_codigo = '.$cod.';';
		return $this->sel($sql);
	}

}