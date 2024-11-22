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

    $age = filter_input(INPUT_GET, 'A') ? $v['A'] : die('¡Agencia campo obligatorio!') ;
    $cod = filter_input(INPUT_GET, 'C') ? $v['C'] : die('¡Codigo campo obligatorio!') ;

    $s = $db->sAuxSolicitud($age,$cod);

    $estado = ['',''];
    if($s[0][0] == 'A'){$estado = ['APROBADO','green white-text'];}
    else if($s[0][0] == 'R'){$estado = ['RECHAZADO','red white-text'];}
    else if($s[0][0] == 'S'){$estado = ['SUSPENSO','grey white-text'];}
    else{$estado = ['EN PROCESO',''];}

?>
    <div id="auxParamResumen">
        <div class="row">

            <div class="col s12 m8">
                <?php $a_1 = $db->sDetSol_1($age,$cod);
                if($a_1 != false){
                    foreach ($a_1 as $a1) { ?>
                        <div class="row">
                            <div class="col s12 center blue darken-4 white-text">
                                <?php echo $a1[1]; ?>
                            </div>
                            <div class="col s12">
                                <div class="row">
                                <?php $a_2 = $db->sDetSol_2($age,$cod,$a1[0]);
                                if($a_2 != false){
                                    foreach ($a_2 as $a2) { 
                                        $tot_a2 = $db->sTotDetSol_3($age,$cod,$a1[0],$a2[0]); ?>
                                        <div class="col s12 m6">
                                            <div class="row">
                                                <div class="col s12 blue-grey darken-4 white-text bl">
                                                    <table class="centered">
                                                        <tbody>
                                                            <tr>
                                                                <td><?php echo $a2[1]; ?></td>
                                                                <td><?php echo $tot_a2[0][0]; ?></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <?php $a_3 = $db->sDetSol_3($age,$cod,$a1[0],$a2[0]);
                                                if($a_3 != false){
                                                    foreach ($a_3 as $a3) { 
                                                        $tot_a3 = $db->sTotDetSol_4($age,$cod,$a1[0],$a2[0],$a3[0]); ?>
                                                        <div class="col s12 center orange darken-4 white-text bl">
                                                            <table class="centered">
                                                                <tbody>
                                                                    <tr>
                                                                        <td><?php echo $a3[1]; ?></td>
                                                                        <td><?php echo $tot_a3[0][0]; ?></td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    <?php }
                                                } ?>

                                            </div>
                                        </div>
                                    <?php }
                                } ?>
                                </div>
                            </div>

                            <div class="col s12">
                                <?php if($a1[2] == 't'){ 
                                $tot_cobpat = [0, $db->sTotDetSol_1_cobpat($age,$cod,$a1[0],$s[0][4]),0,['','']]; 
                                foreach ($tot_cobpat[1] as $cobpat) {
                                    if($cobpat[0] == '+'){
                                        $tot_cobpat[0] += $cobpat[1];
                                    }else{
                                        $tot_cobpat[0] -= $cobpat[1];
                                    }
                                } $tot_cobpat[0] = abs($tot_cobpat[0]); 
                                $tot_cobpat[2] = $tot_cobpat[0] <> 0 ? round(($s[0][3]/$tot_cobpat[0])*100,2) : 0; 
                                if($s[0][3] < $tot_cobpat[0]){
                                    $tot_cobpat[3] = ['TIENE COBERTURA PATRIMONIAL PARA EL MONTO SOLICITADO','green'];
                                }else{
                                    $tot_cobpat[3] = ['NO TIENE PATRIMONIO SUFICIENTE PARA EL MONTO QUE SOLICITA DEBE TENER EL 140%','red'];
                                } ?>
                                <table class="centered">
                                    <tbody class="<?php echo $tot_cobpat[3][1]; ?>">
                                        <tr>
                                            <td>COBERTURA PATRIMONIAL</td>
                                            <td rowspan="2"><h5><?php echo $tot_cobpat[2]; ?>%</h5></td>
                                        </tr>
                                        <tr>
                                            <td><?php echo $tot_cobpat[3][0]; ?></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <?php } ?>
                            </div>

                        </div>

                    <?php }
                } ?>
            </div>

            <div class="col s12 m4 center">
                <div class="<?php echo $estado[1]; ?>">
                    <h5>Estado<br><?php echo $estado[0]; ?></h5>
                </div>
                <span>Recomienda el crédito</span>
                <p>
                    <label>
                        <input onchange="chaRecCre(this);" name="npt_reccre" value="SI" type="radio" <?php echo $s[0][1] == 'SI' ? 'checked' : ''; ?> />
                        <span>SI</span>
                    </label>
                    <label>
                        <input onchange="chaRecCre(this);" name="npt_reccre" value="NO" type="radio" <?php echo $s[0][1] == 'NO' ? 'checked' : ''; ?> />
                        <span>NO</span>
                    </label>
                </p>
                <input onchange="chaDesRecCre(this);" id="npt_des_reccre" value="<?php echo $s[0][6]; ?>" placeholder="Indique la razón"/>
                
                <?php $cappag = $db->sCapPago($age,$cod);
                $saldo = $cappag[0][0]; ?>
                <div class="card-panel">
                    <table>
                        <tbody>
                            <tr>
                                <td>INGRESOS-EGRESOS</td>
                                <td>$<?php echo $saldo; ?></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="center">% MARGEN DE IMPREVISTOS</td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="number" step="0.01" onchange="chaMarImp(this);" onfocus="this.select();" value="<?php echo $s[0][2]; ?>">
                                </td>
                                <td>$<?php echo $saldo*($s[0][2]/100); ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <table class="yellow">
                    <tbody>
                        <tr>
                            <td>CAPACIDAD DE PAGO</td>
                            <td>$<?php 
                            $cappag = $saldo-($saldo*($s[0][2]/100));
                            echo $cappag;
                            ?></td>
                        </tr>
                    </tbody>
                </table>
                <table class="blue-grey darken-2 white-text centered">
                    <tbody>
                        <tr>
                            <td>% DE CUOTA SOBRE CAPACIDAD DE PAGO</td>
                            <td><?php
                            $porcuo_cappag = $s[0][5] == 0 ? 0 : round(($cappag/$s[0][5])*100,2);
                            echo $porcuo_cappag; 
                            ?>%</td>
                        </tr>
                        <tr>
                            <td colspan="2"><?php if($porcuo_cappag < 90){
                                echo 'TIENE BUENA COBERTURA SOBRE CUOTA';
                            }else{
                                echo 'PENSAR EN BAJAR MONTO O INCREMENTAR PLAZO';
                            } ?></td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
