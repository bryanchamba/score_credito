<?php
// $key = sha1(md5('BRYAN1996CHAMBA'));
// echo $key;
// die();

if(filter_input(INPUT_POST,'COOP')){
    include '../../../lliibb/config/cnxn.php';
    include '../../../lliibb/config/vars.php';
    include '../../index.mod.php';
    $db = new Mod();

    $coop = filter_input(INPUT_POST,'COOP');
    $vs = filter_input(INPUT_POST,'VS');
    
    $post = array('COOP'=>$coop,'VS'=>$vs);
    $fields_string = http_build_query($post);
    $curl = curl_init();
    //function parameteres
    //curl_setopt($curl, CURLOPT_URL,'http://localhost/VIPG/REST/fileIds.php');
    curl_setopt($curl, CURLOPT_URL,'http://194.163.161.250/REST/fileIds.php');
    curl_setopt($curl, CURLOPT_POST,1);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $post);
    $response = curl_exec($curl);// respuesta generada
    $err = curl_error($curl); // muestra errores en caso de existir
    curl_close($curl); // termina la sesión 
    if ($err) {
        echo 'cURL Error #:' . $err; // mostramos el error
    } else {
        if($response != false){
            $response = json_decode($response);
            if($response->response){
                echo $response->descripcion;
                echo '<br>';
                $copy = copy($response->contenido, $response->name_file);
                if ($copy) {
                    echo "Archivo copiado correctamente!";
                    echo '<br>';
                    $zipArchive = new ZipArchive();
                    $result = $zipArchive->open($response->name_file);
                    if ($result === true) {
                        $zipArchive ->extractTo("./");
                        $zipArchive ->close();
                        
                        $tbl = 'tbl_temp_cedulas';
                        $tmp = $db->sel('select tablename from pg_tables where tablename = \''.$tbl.'\';');
                        if($tmp != false){
                            $db->iud('drop table '.$tbl.';');
                        }
                        $db->iud('create table '.$tbl.'(
                            cedula text
                        );');
                        $db->iud('create index ind_'.$tbl.' ON '.$tbl.' (cedula);');
                        $db->iud('copy '.$tbl.' FROM \''.__DIR__.'\\'.$response->name_file_extract.'\' WITH csv delimiter \'}\';');
                        echo 'Datos cargados correctamente.';
                        echo '<br>';
                        unlink($response->name_file);
                        unlink($response->name_file_extract);
                        $select = $db->sel('select emp_codigo, cli_codigo, icl_ruc from la_perfil_c_resumen where pco_feccod = '.$coop.' group by emp_codigo,cli_codigo,icl_ruc');
                        $procesados = 0;
                        if($select != false){
                            foreach ($select as $item) {
                                $lista = $db->sel('select cedula from '.$tbl.' where cedula = \''.$item[2].'\' limit 1;');
                                if($lista != false){
                                    $db->iud('update la_perfil_c_resumen set efi_liscon = \'S\' where emp_codigo = \''.$item[0].'\' and cli_codigo = \''.$item[1].'\' and pco_feccod = '.$coop.';');
                                }
                                ++$procesados;
                            }
                        }
                        echo 'Información procesada y actualizada correctamente('.$procesados.').';
                        echo '<br>';
                        //$db->iud('drop table '.$tbl.';');
                    } else {
                        echo "Error! El archivo no se pudo descomprimir";
                    }
                } else {
                    echo "Error! El archivo no se copió…";
                }
            }else{
                echo $response->descripcion;
            }
        }
    }
}else{
    echo '¡No se encuentra fecha de corte!';
}
