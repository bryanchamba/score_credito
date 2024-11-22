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
    <div id="auxParam">
        <?php $cincoC_1 = $db->sDet5cSol_1($mat);
        if($cincoC_1 != false){
            foreach ($cincoC_1 as $cincoC1) { ?>
                <div class="row">
                    <div class="input-field col s12 m12 center blue darken-4 white-text">
                        <table class="centered">
                            <tbody>
                                <tr>
                                    <td><h5><?php echo $cincoC1[1]; ?></h5></td>
                                    <td>
                                        <span>Porcentaje %</span>
                                        <input type="number" step="0.01" class="center white-text" 
                                            onfocus="this.select();" 
                                            onchange="uPor5c(this,<?php echo $cincoC1[0]; ?>);"
                                            value="<?php echo $cincoC1[2]; ?>">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <?php $cincoC_2 = $db->sDet5cSol_2($mat,$cincoC1[0]);
                    if($cincoC_2 != false){
                        foreach ($cincoC_2 as $cincoC2) { ?>
                            <div class="col s12 m6">
                                <table class="centered green lighten-3">
                                    <tbody>
                                        <tr>
                                            <td><h5><?php echo $cincoC2[1]; ?></h5></td>
                                            <td>
                                                <span>Porcentaje %</span>
                                                <input type="number" step="0.01" class="center" 
                                                    onfocus="this.select();" 
                                                    onchange="uPorInd(this,<?php echo $cincoC1[0].','.$cincoC2[0]; ?>);"
                                                    value="<?php echo $cincoC2[2]; ?>">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table>
                                    <tbody>
                                    <?php $cincoC_3 = $db->sDet5cSol_3($mat,$cincoC1[0],$cincoC2[0]);
                                    if($cincoC_3 != false){
                                        foreach ($cincoC_3 as $cincoC3) {
                                            echo '<tr>
                                            <td>'.$cincoC3[1].'</td>
                                            <td style="width:20%"><input type="number" step="0.01" value="'.$cincoC3[2].'"
                                                onfocus="this.select();" 
                                                onchange="uValInd(this,'.$cincoC1[0].','.$cincoC2[0].','.$cincoC3[0].');"/></td>
                                            </tr>';
                                        }
                                    } ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php }
                    } ?>

                </div>
            <?php }
        } ?>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
