<?php
/* Creado por: Bryan Alejandro Chamba Freire */
session_start();
include '../../lliibb/librerias/dompdf/autoload.inc.php';
use Dompdf\Dompdf;
use Dompdf\Options;
if(isset($_SESSION['USE'])){ 
    ob_start();
    include '../../lliibb/config/cnxn.php';
    include '../../lliibb/config/vars.php';
	include '../index.mod.php';
    $db = new Mod();
    $db->EMP = $_SESSION['EMP'];
    $db->USE = $_SESSION['USE'];
    $v = $db->rp($_GET);
    $ip = $db->getRealIP();
    $age = filter_input(INPUT_GET, 'A') ? $v['A'] : die('¡Agencia campo obligatorio!') ;
    $cod = filter_input(INPUT_GET, 'C') ? $v['C'] : die('¡Codigo campo obligatorio!') ;
    $db->uSolCal5c($age,$cod);
    $empage = $db->sEmpAge($age);
    $datper = $db->sdatSolicitud($age,$cod);
    ?>
    <style>
        *{
            font-family: Verdana, Geneva, Tahoma, sans-serif;
            font-size: 10px;
        }
        table{
            width: 100%;
            border-collapse: collapse;
        }
        .green{
            background-color: #4caf50;
        }
        .red{
            background-color: #f44336;
        }
        .white-text{
            color: #ffffff;
        }
        .tbl{}
        .tbl td{
            text-align: center;
        }
        .titulo{
            width: 100%;
            padding: 2px;
            background-color: #263238;
            color: #ffffff;
            font-weight: bold;
            font-size: 12px;
            text-align: center;
        }
        .titulo-c{
            width: 100%;
            padding: 2px;
            background-color: #01579b;
            color: #ffffff;
            font-weight: bold;
            font-size: 12px;
            text-align: center;
        }
        .footer{
            position: absolute;
            bottom: 0;
            width: 100%;
        }
        .footer table td{
            padding: 0 10px;
        }
        .footer table td div{
            width: 100%;
            height: 5px;
        }
        .centered{}
        .centered td{
            text-align: center;
        }
    </style>
    <table class="tbl">
        <thead>
            <tr><th><?php echo $empage[0][0]; ?></th></tr>
            <tr><th><?php echo $empage[0][1]; ?></th></tr>
        </thead>
    </table>
    <table class="centered">
        <tbody>
            <tr>
                <td>Nro. socio: <?php echo $datper[0][0]; ?></td>
                <td>Fecha impresion: <?php echo Date('Y-m-d H:i:s'); ?></td>
                <td>Usuario: <?php echo $db->USE; ?></td>
            </tr>
        </tbody>
    </table>
    <div class="titulo">DATOS PERSONALES</div>
    <table>
        <tbody>
            <tr style="border-bottom:1px solid #c3c3c3;">
                <td style="width:14%;"><b>NOMBRE</b></td>
                <td style="width:21%;"><?php echo $datper[0][1]; ?></td>
                <td style="width:12%;"><b>DIRECCIÓN DOMICILIO</b></td>
                <td style="width:21%;"><?php echo $datper[0][2]; ?></td>
                <td style="width:12%;"><b>SECTOR</b></td>
                <td style="width:20%;"><?php echo $datper[0][3]; ?></td>
            </tr>
            <tr style="border-bottom:1px solid #c3c3c3;">
                <td><b>EDAD</b></td>
                <td><?php echo $datper[0][4]; ?></td>
                <td><b>DIRECCIÓN TRABAJO</b></td>
                <td><?php echo $datper[0][5]; ?></td>
                <td><b>SECTOR</b></td>
                <td><?php echo $datper[0][6]; ?></td>
            </tr>
            <tr style="border-bottom:1px solid #c3c3c3;">
                <td><b>NRO. CÉDULA</b></td>
                <td><?php echo $datper[0][7]; ?></td>
                <td><b>TELEFONO TRABAJO</b></td>
                <td><?php echo $datper[0][8]; ?></td>
                <td><b>GÉNERO</b></td>
                <td><?php echo $datper[0][9]; ?></td>
            </tr>
            <tr style="border-bottom:1px solid #c3c3c3;">
                <td><b>ESTADO CIVIL</b></td>
                <td><?php echo $datper[0][10]; ?></td>
                <td><b>TELEFONO CONVENCIONAL</b></td>
                <td><?php echo $datper[0][11]; ?></td>
                <td><b>TELEFONO MOVIL</b></td>
                <td><?php echo $datper[0][12]; ?></td>
            </tr>
            <tr>
                <td><b>ACTIVIDAD ECONÓMICA</b></td>
                <td><?php echo $datper[0][13]; ?></td>
                <td><b>CÁNTON</b></td>
                <td><?php echo $datper[0][14]; ?></td>
                <td><b>PROVINCIA</b></td>
                <td><?php echo $datper[0][15]; ?></td>
            </tr>
        </tbody>
    </table>
    <table border="1" class="tbl">
        <tbody>
            <tr>
                <td style="width:40%;"><b>CONSTA EN LISTAS DE CONTROL</b><br><?php echo $datper[0][16]; ?></td>
                <td style="width:20%;"><b>ES VINCULADO</b><br><?php echo $datper[0][17]; ?></td>
                <td style="width:40%;"><b>SE REALIZÓ INSPECCIÓN</b><br><?php echo $datper[0][18]; ?></td>
            </tr>
        </tbody>
    </table>

    <?php $a_1 = $db->sDetSol_1($age,$cod);
    if($a_1 != false){
        foreach ($a_1 as $a1) { ?>
            <div class="titulo"><?php echo $a1[1]; ?></div>
            <?php $a_2 = $db->sDetSol_2($age,$cod,$a1[0]);
            if($a_2 != false){ ?>
                <table>
                    <tbody>
                        <tr>
                            <?php foreach ($a_2 as $a2) { ?>
                                <td style="width:50%;vertical-align:top;">
                                    <table border="1">
                                        <tbody>
                                            <tr><th style="background-color: #455a64;color: #ffffff;"><?php echo $a2[1]; ?></th></tr>
                                            <tr><td>

                                                <?php $a_3 = $db->sDetSol_3($age,$cod,$a1[0],$a2[0]);
                                                if($a_3 != false){
                                                    foreach ($a_3 as $a3) { ?>
                                                        <table>
                                                            <tbody>
                                                                <tr>
                                                                    <th colspan="2" style="background-color: #f4511e;color: #ffffff;"><?php echo $a3[1]; ?></th>
                                                                </tr>

                                                                <?php $a_4 = $db->sDetSol_4($age,$cod,$a1[0],$a2[0],$a3[0]);
                                                                if($a_4 != false){  
                                                                    foreach ($a_4 as $a4) { ?>
                                                                        <tr>
                                                                            <td style="width:80%;"><?php echo $a4[1]; ?></td>
                                                                            <td style="width:20%;"><?php echo $a4[2]; ?></td>
                                                                        </tr>
                                                                    <?php }
                                                                } ?>

                                                            </tbody>
                                                        </table>
                                                    <?php }
                                                } ?>

                                            </td></tr>
                                        </tbody>
                                    </table>
                                </td>
                            <?php } ?>
                        </tr>
                    </tbody>
                </table>
                <?php
            } ?>

            <?php if($a1[2] == 't'){ ?>
                
                <br><table border="1" class="centered">
                    <tbody>
                        <tr style="background-color: #01579b;color: #ffffff;">
                            <th>MONTO SOLICITADO</th>
                            <th>INTERES</th>
                            <th>PLAZO</th>
                            <th>CUOTA</th>
                        </tr>
                        <tr>
                            <td><?php echo $datper[0][25]; ?></td>
                            <td><?php echo $datper[0][26]; ?></td>
                            <td><?php echo $datper[0][27]; ?></td>
                            <td><?php echo $datper[0][28]; ?></td>
                        </tr>
                    </tbody>
                </table>

                <?php $tot_cobpat = [0, $db->sTotDetSol_1_cobpat($age,$cod,$a1[0],$datper[0][24]),0,['','']]; 
                foreach ($tot_cobpat[1] as $cobpat) {
                    if($cobpat[0] == '+'){
                        $tot_cobpat[0] += $cobpat[1];
                    }else{
                        $tot_cobpat[0] -= $cobpat[1];
                    }
                } $tot_cobpat[0] = abs($tot_cobpat[0]); 
                $tot_cobpat[2] = $tot_cobpat[0] <> 0 ? round(($datper[0][25]/$tot_cobpat[0])*100,2) : 0; 
                if($datper[0][25] < $tot_cobpat[0]){
                    $tot_cobpat[3] = ['TIENE COBERTURA PATRIMONIAL PARA EL MONTO SOLICITADO','green'];
                }else{
                    $tot_cobpat[3] = ['NO TIENE PATRIMONIO SUFICIENTE PARA EL MONTO QUE SOLICITA DEBE TENER EL 140%','red white-text'];
                } ?>
                <br><table class="centered">
                    <tbody class="<?php echo $tot_cobpat[3][1]; ?>">
                        <tr>
                            <td>COBERTURA PATRIMONIAL</td>
                            <td rowspan="2"><?php echo $tot_cobpat[2]; ?>%</td>
                        </tr>
                        <tr>
                            <td><?php echo $tot_cobpat[3][0]; ?></td>
                        </tr>
                    </tbody>
                </table><br>

                <?php $cappag = $db->sCapPago($age,$cod);
                $saldo = $cappag[0][0]; ?>
                <table border="1" class="centered">
                    <tbody>
                        <tr style="background-color: #01579b;color: #ffffff;">
                            <th>INGRESOS-EGRESOS</th>
                            <td colspan="2">% MARGEN DE IMPREVISTOS</td>
                            <td>CAPACIDAD DE PAGO</td>
                            <td colspan="2">% DE CUOTA SOBRE CAPACIDAD DE PAGO</td>
                        </tr>
                        <tr>
                            <td>$<?php echo $saldo; ?></td>
                            <td><?php echo $datper[0][29]; ?>%</td>
                            <td>$<?php echo $saldo*($datper[0][29]/100); ?></td>
                            <td>$<?php 
                            $cappag = $saldo-($saldo*($datper[0][29]/100));
                            echo $cappag;
                            ?></td>
                            <td><?php
                            $porcuo_cappag = $cappag == 0 ? 0 : round(($datper[0][28]/$cappag)*100,2);
                            echo $porcuo_cappag; 
                            ?>%</td>
                            <td><?php if($porcuo_cappag < 90){
                                echo 'TIENE BUENA COBERTURA SOBRE CUOTA';
                            }else{
                                echo 'PENSAR EN BAJAR MONTO O INCREMENTAR PLAZO';
                            } ?></td>
                        </tr>
                    </tbody>
                </table><br>

            <?php } ?>

        <?php }
    } ?>

    <?php $cincoC_1 = $db->sDet5cSol_1($age,$cod);
    if($cincoC_1 != false){
        foreach ($cincoC_1 as $cincoC1) { ?>
            <div class="titulo-c"><?php echo $cincoC1[1]; ?></div>
            <table border="1">
                <tbody>
                    <?php $cincoC_2 = $db->sDet5cSol_2($age,$cod,$cincoC1[0]);
                    if($cincoC_2 != false){
                        foreach ($cincoC_2 as $cincoC2) {
                            $cincoC_3 = $db->sDet5cSol_3_rep($age,$cod,$cincoC1[0],$cincoC2[0]);
                            if($cincoC_3 != false){$cincoC_3 = [$cincoC_3[0][1],$cincoC_3[0][2]];}
                            else{$cincoC_3 = ['',0];}
                            echo '<tr>
                            <td style="width:60%;">'.$cincoC2[1].'</td>
                            <td style="width:35%;">'.$cincoC_3[0].'</td>
                            <td style="width:5%;">'.$cincoC_3[1].'</td>
                            </tr>';
                        }
                    } ?>
                </tbody>
            </table>
        <?php }
    } ?>
    
    <br><table border="1">
        <tbody>
            <?php 
            $estado = ['',''];
            if($datper[0][21] == 'A'){$estado = ['APROBADO','background-color:#4caf50;color:#ffffff;'];}
            else if($datper[0][21] == 'R'){$estado = ['RECHAZADO','background-color:#f44336;color:#ffffff;'];}
            else if($datper[0][21] == 'S'){$estado = ['SUSPENSO','background-color:#9e9e9e;color:#ffffff;'];}
            else{$estado = ['EN PROCESO',''];}
            ?>
            <tr style="<?php echo $estado[1]; ?>">
                <th style="width:50%;"><br>RESULTADO<br><br></th>
                <th style="width:50%;"><br><?php echo $estado[0]; ?><br><br></th>
            </tr>
        </tbody>
    </table><br>

    <table border="1">
        <tbody>
            <?php 
            $estado = ['',''];
            if($datper[0][21] == 'A'){$estado = ['APROBADO','background-color:#4caf50;color:#ffffff;'];}
            else if($datper[0][21] == 'R'){$estado = ['RECHAZADO','background-color:#f44336;color:#ffffff;'];}
            else if($datper[0][21] == 'S'){$estado = ['SUSPENSO','background-color:#9e9e9e;color:#ffffff;'];}
            else{$estado = ['EN PROCESO',''];}
            ?>
            <tr>
                <th style="width:50%;" rowspan="2">RECOMIENDA EL CREDITO</th>
                <th style="width:25%;<?php echo $datper[0][22] == 'SI' ? 'background-color:#4caf50;color:#ffffff;' : ''; ?>">SI</th>
                <th style="width:25%;<?php echo $datper[0][22] == 'NO' ? 'background-color:#f44336;color:#ffffff;' : ''; ?>">NO</th>
            </tr>
            <tr>
                <td colspan="2"><?php echo $datper[0][23]; ?></td>
            </tr>
        </tbody>
    </table>
    
    <br>
    <br>
    <br>

    <table>
        <tbody>
            <tr>
                <td style="width:65%;text-align:center;">Declaro que la información registrada es real y verídica y puede ser confirmada por la Cooperativa</td>
                <td style="width:35%;border-bottom: 1px solid #000000;"></td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align:center;">Firma de funcionario que recomienda crédito</td>
            </tr>
        </tbody>
    </table>

    <div class="footer">
        <table>
            <tbody>
                <tr>
                    <th style="width:20%;" rowspan="3">FIRMAS DE APROBACIÓN</th>
                    <td style="width:40%;"><div style="border-bottom: 1px solid #000000;"></div></td>
                    <td style="width:40%;"><div style="border-bottom: 1px solid #000000;"></div></td>
                </tr>
                <tr>
                    <td>Nombres:</td>
                    <td>Nombres:</td>
                </tr>
                <tr>
                    <td>CI:</td>
                    <td>CI:</td>
                </tr>
            </tbody>
        </table>
    </div>

    <?php
    $dompdf = new DOMPDF();
    $options = new Options();
    $options->set('chroot',realpath(''));
    $dompdf = new Dompdf($options);
    $dompdf->loadHtml(ob_get_clean());
    $dompdf->render();
    $pdf = $dompdf->output();
    if (!is_dir('../pdfs/'.Date('Y-m').'')) {
        mkdir('../pdfs/'.Date('Y-m').'', 0665, true);
    }
    $filename = preg_replace('/[^a-zA-Z0-9\s\/\.\_\-]+/', '', '../pdfs/'.Date('Y-m').'/sol_'.$datper[0][1].'_'.Date('YmdHis').mt_rand(100, 999).'.pdf');
    $db->iLogImpresion($age,$cod,$filename,$ip);
    file_put_contents($filename, $pdf);
    $dompdf->stream($filename);
}else{
    ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
    <?php
}