<?php
/* Creado por: Bryan Alejandro Chamba Freire */
session_start();
if (isset($_SESSION['USE'])) {
    include '../../lliibb/config/cnxn.php';
    include '../../lliibb/config/vars.php';
    include '../index.mod.php';
    $db = new Mod();
    $db->EMP = $_SESSION['EMP'];
    $db->USE = $_SESSION['USE'];
    $db->AGE = $_SESSION['AGE'];

    $v = $db->rp($_GET);

    $cod = filter_input(INPUT_GET, 'F') ? $v['F'] : 0 ;
    $cod = is_numeric($cod) ? $cod : 0;

    $filePath = $db->sImpresion($cod);
    $filePath = $filePath[0][0];
    if (file_exists($filePath)) {
        header('Content-Type: application/pdf');
        header('Content-Disposition: inline; filename="solicitud.pdf"');
        readfile($filePath);
    } else {
        echo 'El archivo no existe.';
    }
} else { 
    echo '<h2>Usuario no autorizado!</h2>';
}
