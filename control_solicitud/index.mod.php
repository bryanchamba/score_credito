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

	public function sMatriz(){
		$sql = 'select 
				mat_codigo,
				mat_descri
			from sco_matrices 
			where emp_codigo = '.$this->EMP.'
			order by mat_codigo;';
		return $this->sel($sql);
	}
	
	public function srhDatCliente($ide){
		$sql = 'select cli_apelli||\' \'||cli_nombre,cli_edad,cli_nrosoc from sco_clientes 
			where emp_codigo = '.$this->EMP.' and cli_codigo = '.$ide.';';
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
	
	public function sImpresiones($age,$cod){
		$sql = 'select lim_usuari,to_char(lim_fecsis,\'YYYY-MM-DD HH24:MI:SS\'),lim_ipaddr,lim_codigo from sco_log_impresiones 
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.'
			order by lim_fecsis;';
		return $this->sel($sql);
	}
	
	public function sImpresion($cod){
		$sql = 'select lim_filpdf from sco_log_impresiones 
			where lim_codigo = '.$cod.';';
		return $this->sel($sql);
	}

	public function sCountSol(){
		$sql = 'select count(sol_codigo)
			from sco_solicitudes
			where sol_auxest = \'A\' and emp_codigo = '.$this->EMP.';';
		$nro = $this->sel($sql);
		return $nro[0][0];
	}
	
	public function sSolicitudes($bus,$lmt,$oft){
		$w = $bus[0] != '' ? (is_numeric($bus[0]) ? ' and c.cli_identi like \''.$bus[0].'%\' ' : ' and c.cli_apelli||\' \'||c.cli_nombre ilike \'%'.$bus[0].'%\' ') : '';
		$w .= $bus[1] != '' ? ' and s.sol_fecha >= \''.$bus[1].'\' ' : '';
		$w .= $bus[2] != '' ? ' and s.sol_fecha <= \''.$bus[2].'\' ' : '';
		$w .= $bus[3] != 'ALL' ? ' and s.sol_estado = \''.$bus[3].'\' ' : '';
		$sql = 'select m.mat_descri,s.sol_fecha,c.cli_apelli||\' \'||c.cli_nombre,a.aec_descri,
			s.sol_monto,s.sol_listas,s.sol_vincul,s.sol_inspec,s.sol_estado,
			s.sol_usuari,
			(select count(lim_codigo) from sco_log_impresiones where emp_codigo = s.emp_codigo and 
			age_codigo = s.age_codigo and sol_codigo = s.sol_codigo) as impresiones,
			null,null,null,
			s.age_codigo,s.sol_codigo
			from sco_solicitudes s, sco_matrices m, sco_clientes c, tbl_act_economica a
			where s.emp_codigo = m.emp_codigo and s.mat_codigo = m.mat_codigo and 
			s.emp_codigo = c.emp_codigo and s.cli_codigo = c.cli_codigo and 
			s.aec_codigo = a.aec_codigo and sol_auxest = \'A\' and 
			s.emp_codigo = '.$this->EMP.' '.$w.'
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
		$sql = 'select c.cli_apelli||\' \'||c.cli_nombre||\' | EDAD: \'||c.cli_edad::character varying,
			a.aec_descri,a.aec_codigo,
			s.mat_codigo,s.sol_fecha,
			s.sol_monto,s.sol_intere,s.sol_plazo,s.sol_cuota,
			s.sol_listas,s.sol_vincul,s.sol_inspec,s.sol_estado
			from sco_solicitudes s, sco_sol_clientes c, tbl_act_economica a
			where s.emp_codigo = c.emp_codigo and s.cli_codigo = c.cli_codigo and s.scl_codigo = c.scl_codigo and 
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

	public function sDet5cSol_1($age,$cod){
		$sql = 'select ind_codigo,ind_descri
			from sco_sol_indicadores
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.'
			order by ind_codigo;';
		return $this->sel($sql);
	}
	
	public function sDet5cSol_2($age,$cod,$ind){
		$sql = 'select cvi_codigo,cvi_descri
			from sco_sol_cab_var_indicadores
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and ind_codigo = '.$ind.'
			order by cvi_codigo;';
		return $this->sel($sql);
	}
	
	public function sDet5cSol_3($age,$cod,$ind,$cvi){
		$sql = 'select dvi_codigo,dvi_descri,dvi_select,dvi_valor
			from sco_sol_det_var_indicadores
			where emp_codigo = '.$this->EMP.' and age_codigo = '.$age.' and sol_codigo = '.$cod.' and ind_codigo = '.$ind.' and cvi_codigo = '.$cvi.'
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
	
	public function iSolicitud($vls){
		$sql = 'select * from f_sol_create_sol(
			'.$this->EMP.':: smallint,
			'.$this->AGE.':: smallint,
			'.$vls[0].':: int,
			'.$vls[1].':: smallint,
			'.$vls[2].':: smallint,
			\''.$vls[3].'\':: date,
			'.$vls[4].':: numeric(12,2),
			'.$vls[5].':: numeric(12,2),
			'.$vls[6].':: smallint,
			'.$vls[7].':: numeric(12,2),
			\''.$vls[8].'\':: char(2),
			\''.$vls[9].'\':: char(2),
			\''.$vls[10].'\':: char(2),
			\''.$this->USE.'\':: varchar(25)
		);';
		return $this->sel($sql);
	}

	public function uSolicitud($vls){
		$sql = 'update sco_solicitudes set
			aec_codigo = '.$vls['d2'].',
			sol_monto = '.$vls['d5'].',
			sol_intere = '.$vls['d6'].',
			sol_plazo = '.$vls['d7'].',
			sol_cuota = '.$vls['d8'].',
			sol_listas = \''.$vls['d9'].'\',
			sol_vincul = \''.$vls['d10'].'\',
			sol_inspec = \''.$vls['d11'].'\'
		where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls['d0'].' and 
			sol_codigo = '.$vls['d1'].';';
		return $this->iud($sql);
	}
	
	public function dSolicitud($vls){
		$sql = 'update sco_solicitudes set
			sol_auxest = \'I\'
		where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls['d1'].' and 
			sol_codigo = '.$vls['d2'].';';
		return $this->iud($sql);
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
	
	public function uSolValDet($vls){
		$sql = 'update sco_sol_det_matri_items_det set 
			mid_valor = '.$vls[6].' 
			where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls[0].' and 
			sol_codigo = '.$vls[1].' and 
			tma_codigo = '.$vls[2].' and 
			dma_codigo = '.$vls[3].' and 
			dmi_codigo = '.$vls[4].' and 
			mid_codigo = '.$vls[5].';';
		return $this->iud($sql);
	}
	
	public function uSolSigDet($vls){
		$sql = 'update sco_sol_det_matri_items_det set 
			mid_signo = \''.$vls[6].'\' 
			where emp_codigo = '.$this->EMP.' and 
			age_codigo = '.$vls[0].' and 
			sol_codigo = '.$vls[1].' and 
			tma_codigo = '.$vls[2].' and 
			dma_codigo = '.$vls[3].' and 
			dmi_codigo = '.$vls[4].' and 
			mid_codigo = '.$vls[5].';';
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


	public function sCapPago($age,$cod){
		$sql = 'select * from f_cal_saldo('.$this->EMP.'::smallint,'.$age.'::smallint,'.$cod.'::smallint);';
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
			e.eci_descri,
			c.cli_telefo,
			c.cli_celula,
			ae.aec_descri,
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
		from sco_solicitudes s, sco_sol_clientes c, tbl_est_civil e, tbl_provincias p, tbl_cantones ca, tbl_act_economica ae
		where s.emp_codigo = c.emp_codigo and
			s.cli_codigo = c.cli_codigo and
			s.scl_codigo = c.scl_codigo and
			c.eci_codigo = e.eci_codigo and
			c.pro_codigo = p.pro_codigo and
			c.pro_codigo = ca.pro_codigo and
			c.can_codigo = ca.can_codigo and
			s.aec_codigo = ae.aec_codigo and
			s.emp_codigo = '.$this->EMP.' and
			s.age_codigo = '.$age.' and
			s.sol_codigo = '.$cod.';';
		return $this->sel($sql);
	}

	public function iLogImpresion($age,$cod,$fil,$ip){
		$sql = 'insert into sco_log_impresiones(
				emp_codigo,age_codigo,sol_codigo,lim_filpdf,lim_ipaddr,lim_fecsis,lim_usuari
			) 
			values(
				'.$this->EMP.',
				'.$age.',
				'.$cod.',
				\''.$fil.'\',
				\''.$ip.'\',
				current_timestamp,
				\''.$this->USE.'\'
			);';
		$this->iud($sql);
	}

}