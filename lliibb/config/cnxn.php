<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
class Con{
	
	private const SERV = 'localhost';
	private const PORT = '5433';
	private const USER = 'postgres';
	private const PASS = '091914092bc';
	private const DBNM = 'score_credito';

	function __construct(){
		return $this->connect();
	}

	private function connect(){
		$connect = pg_connect(
			'host='.self::SERV.
			' port='.self::PORT.
			' user='.self::USER.
			' password='.self::PASS.
			' dbname='.self::DBNM
		)or die('<b>Error de conexion.</b>');
	}

	protected function sel($sql){
        $val = array();
        $c1 = 0;
        $c2 = 0;
        $res = pg_query($sql);
        if(!$res){
            die(print_r(pg_errormessage(), true));
        }
        while($r = pg_fetch_array($res,null,PGSQL_NUM)){
            foreach($r as $f){
                $val[$c1][$c2] = $f;
                $c2++;
            }
            $c2 = 0;
            $c1++;
        }
        $ctrl = sizeof($val);
        if($ctrl == 0){
            $val = false;
        }
        return $val;
    }

    protected function selVK($sql){
        $val = array();
        $res = pg_query($sql);
        if(!$res){
            die(print_r(pg_errormessage(), true));
        }
        $ctrl = false;
        while($r = pg_fetch_array($res,null,PGSQL_NUM)){
            foreach($r as $f){
                if($ctrl == false){
                    $val[$f] = [];
                    $ctrl = $f;
                }else{
                    array_push($val[$ctrl],$f);
                }
            }
            $ctrl = false;
        }
        $ctrl = sizeof($val);
        if($ctrl == 0){
            $val = false;
        }
        return $val;
    }

    protected function iud($sql){
    	$res = array();
        $resultado = pg_query($sql);
        if($resultado != false){
            $ar = pg_affected_rows($resultado);
        }else{
            $ar = 1;
        }
        if($ar > 0){
            $res = true;
        }else{
            $res = false;
        }
        return $res;
    }

    public function vInsert($tp,$vl)
    {
        $r = array();
        $tp = str_split($tp);
        $arr = [count($tp),count($vl)];
        if($arr[0] == $arr[1]){
            foreach ($tp as $key => $item){
                $v = ($item == 's' ? '\''.$vl[$key].'\'' : $vl[$key]);
                array_push($r,$v);
            }
            return implode(',',$r);
        }else{
            echo json_encode([false,'Valores no coinciden con sus tipos.('.$arr[0].')('.$arr[1].')']);
            die();
        }
    }

    public function vFormatString($tp,$vl)
    {
        $r = array();
        $vl = explode(',',$vl);
        foreach ($vl as $item){
            $v = ($tp == 's' ? '\''.$item.'\'' : $item);
            array_push($r,$v);
        }
        return implode(',',$r);
    }

    public function getRealIP() {
        if (!empty($_SERVER['HTTP_CLIENT_IP']))
            return $_SERVER['HTTP_CLIENT_IP'];
           
        if (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
            return $_SERVER['HTTP_X_FORWARDED_FOR'];
       
        return $_SERVER['REMOTE_ADDR'];
    }

    public function ilog($vs){
        $vals = $this->vInsert('ssssss',$vs);
        $sql = 'insert into ges_log(inserted_date,username,'
            .'application,creator,ip_user,action,description)'
            .'values(\''.Date('Y-m-d H:i:s').'\','.$vals.');';
        return $this->iud($sql);
    }

    public function uploadFile($ruta,$nombre,$files){
        $uploaded = [];
        $onlyName = null;
        foreach($files as $key){
            if ($key['error'] == 0) {
                $NombreOriginal = $key['name'];
                $onlyName = explode('.',$NombreOriginal);
                $ext = '.'.end($onlyName);
                array_pop($onlyName);
                $onlyName = implode('.',$onlyName);
                $Nombre = $nombre != false ? $nombre.$ext : $NombreOriginal;
                $temporal = $key['tmp_name'];
                $Destino = $ruta.$Nombre;
                move_uploaded_file($temporal, $Destino);
                chmod($Destino, 0755);
                if(is_file($Destino)){
                    array_push($uploaded,[true,$NombreOriginal,'@(-> Archivo <b>'.$NombreOriginal.'</b> procesado.',$onlyName,$Destino,$ext]);
                }else{
                    array_push($uploaded,[true,$NombreOriginal,'@(-> Archivo <b>'.$NombreOriginal.'</b> No se pudo subir correctamente.']);
                }
            }else{
                array_push($uploaded,
                    [false,'@(-> No se pudo subir el archivo <b>'.$NombreOriginal.'</b> debido al siguiente Error: '.$key['error']]
                );
            }
        }
        return $uploaded;
    }

    function getInfoExcel($archivo,$columnas,$hoja,$filaInicio,$camposFechas){
        $inputFileType = PHPExcel_IOFactory::identify($archivo);
        $objReader = PHPExcel_IOFactory::createReader($inputFileType);
    
        $objPHPExcel = $objReader->load($archivo);
        $sheet = $objPHPExcel->getSheet($hoja);//hoja
        $highestRow = $sheet->getHighestRow(); 
        $highestColumn = $sheet->getHighestColumn();
    
        $data = [];
        $cont = 0;
        for ($row = $filaInicio; $row <= $highestRow; $row++){
            $campos = array();
            foreach($columnas as $col){
                $txt = trim(str_replace('\'','"',$sheet->getCell($col.$row)->getValue()));
                if($txt != '' && $camposFechas != false){
                    for($i=0;$i<count($camposFechas);$i++){
                        $formato = $camposFechas[$i][0];
                        for ($e=1;$e<count($camposFechas[$i]);$e++){
                            if($col == $camposFechas[$i][$e]){
                                if(is_numeric($txt))
                                    $txt = date($formato, PHPExcel_Shared_Date::ExcelToPHP($txt));
                            }
                        }
                    }
                }
                array_push($campos,$txt);
            }
            array_push($data,$campos);
            ++$cont;
        }
        return $data;
    }

    public function ilogAlert($vs){
        $vals = $this->vInsert('sssss',$vs);
        $sql = 'insert into bry_log_alertas(ale_fecsis,ale_horsis,ale_usuari,
            ale_estado,ale_from,ale_to,ale_mensaj)
            values(\''.Date('Y-m-d').'\',\''.Date('H:i:s').'\','.$vals.');';
        return $this->iud($sql);
    }

    public function rp($v)
    {
        $cln = array('\'',' OR ','SELECT','UPDATE','DELETE','%',' AND ','<','>');
        foreach($v as $key => $item){
            if(!is_array($v[$key])){
                $v[$key] = str_ireplace($cln,'',$item);
            }else{
                $v[$key] = $this->rp($v[$key]);
            }
        }
        return $v;
    }

}