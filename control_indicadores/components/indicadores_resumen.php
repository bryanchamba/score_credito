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

    $mat = filter_input(INPUT_GET, 'M') ? $v['M'] : die('¡Matriz campo obligatorio!');

?>
    <div id="auxParamResumen">
        
        <div class="row">
            <div class="col s12 m6">
                <div class="card-panel">
                    <table>
                        <tbody class="blue darken-4 white-text">
                        <?php $cincoC_1 = $db->sDet5cSol_1($mat);
                        if($cincoC_1 != false){
                            $tot5C = 0;
                            foreach ($cincoC_1 as $cincoC1) { ?>
                                <tr>
                                    <td><?php echo $cincoC1[1]; ?></td>
                                    <td>
                                        <span><?php echo $cincoC1[2]; ?>%</span>
                                    </td>
                                </tr>
                            <?php $tot5C += $cincoC1[2];}
                        } ?>
                        </tbody>
                        <tbody>
                            <tr class="<?php if($tot5C > 100){echo 'red';}elseif($tot5C == 100){echo 'green';}else{echo 'yellow';} ?>">
                                <td><b>Total</b></td>
                                <td><b><?php echo $tot5C; ?>%</b></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col s12 m6">
                <div class="card-panel">
                    <?php $cincoC_1 = $db->sDet5cSol_1($mat);
                    if($cincoC_1 != false){
                        foreach ($cincoC_1 as $cincoC1) { ?>
                            <div class="row">
                                <div class="input-field col s12 m12 center blue darken-4 white-text">
                                    <table class="centered">
                                        <tbody>
                                            <tr>
                                                <td><?php echo $cincoC1[1]; ?></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <?php $cincoC_2 = $db->sDet5cSol_2($mat,$cincoC1[0]);
                                if($cincoC_2 != false){
                                    $totInd = 0;
                                    foreach ($cincoC_2 as $cincoC2) { ?>
                                        <div class="col s12 m12">
                                            <table class="centered green lighten-3 tbl-no-padd">
                                                <tbody>
                                                    <tr>
                                                        <td><?php echo $cincoC2[1]; ?></td>
                                                        <td style="width: 100px;">
                                                            <span><?php echo $cincoC2[2]; ?> %</span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    <?php $totInd += $cincoC2[2];} ?>
                                    <div class="col s12 m12">
                                        <table class="centered">
                                            <tbody>
                                                <tr class="<?php if($totInd > 100){echo 'red';}elseif($totInd == 100){echo 'green';}else{echo 'yellow';} ?>">
                                                    <td><b>Total</b></td>
                                                    <td style="width: 100px;"><b><?php echo $totInd; ?> %</b></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                <?php } ?>

                            </div>
                        <?php }
                    } ?>
                </div>
            </div>
        </div>

    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
