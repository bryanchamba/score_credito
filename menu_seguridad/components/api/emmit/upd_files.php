<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(!filter_input(INPUT_POST,'COOP')){
        echo json_encode(['response'=>false,'descripcion'=>'No se encuentra cooperativa']);
    }else{
        if(!filter_input(INPUT_POST,'VS')){
            echo json_encode(['response'=>false,'descripcion'=>'No se encuentra versión']);
        }else{
            $coop = filter_input(INPUT_POST,'COOP');
            $vs = filter_input(INPUT_POST,'VS');

            $zip = new ZipArchive;
            if ($zip->open(__DIR__.'\datatxt\temp\temp_'.$nameFile.'.zip', ZipArchive::CREATE) === TRUE){
                $zip->addFile(__DIR__.'\datatxt\temp\\temp_'.$nameFile.'.txt', 'cedulas.txt');
                $zip->close();
                echo json_encode(['response'=>true,'descripcion'=>'Acceso concedido',
                'contenido'=>'http://pla.vipgti.com/REST/datatxt/temp/temp_'.$nameFile.'.zip',
                'name_file'=>'temp_'.$nameFile.'.zip','name_file_extract'=>'cedulas.txt']);
            }else{
                echo json_encode(['response'=>false,'descripcion'=>'Ocurrio un error no se pudo crear archivo ZIP!']);
            }
            unlink(__DIR__.'\datatxt\temp\temp_1_'.$nameFile.'.txt');
            unlink(__DIR__.'\datatxt\temp\temp_2_'.$nameFile.'.txt');
            unlink(__DIR__.'\datatxt\temp\\temp_'.$nameFile.'.txt');
        }
    }
    header('HTTP/1.1 200 OK');
}else{
    header('HTTP/1.1 404 ERROR');
}