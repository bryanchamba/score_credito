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

    $npt_matriz = $db->sMatriz();
    $s = $db->sSolicitud($age,$cod);

?>
    <div id="auxParam">
        <div class="row">
            <div class="col s12">
                <h4>Editar solicitud</h4>
            </div>
        </div>
        <div class="row hide">
            <input type="text" id="npt_agencia" value="<?php echo $age; ?>" disabled>
            <input type="text" id="npt_codigo" value="<?php echo $cod; ?>" disabled>
        </div>
        <div class="row">
            <div class="col s12 center">
                <button class="btn blue" onclick="uSolicitud(this,<?php echo $age.','.$cod; ?>);">ACTUALIZAR<i class="right material-icons white-text">update</i></button>
                <div class="right">
                    <button class="btn blue-grey" onclick="grd();">VOLVER<i class="right material-icons white-text">arrow_back</i></button>
                    <button class="btn blue" onclick="eSolicitud('<?php echo $age; ?>','<?php echo $cod; ?>');">EDITAR<i class="right material-icons white-text">update</i></button>
                </div>
            </div>
        </div>
        <div class="card-panel">
            <div class="row">
                <div class="input-field col s12 m12">
                    <i class="material-icons prefix">person</i>
                    <input type="text" id="npt_cliente" autocomplete="off" value="<?php echo $s[0][0]; ?>" disabled>
                    <label for="npt_cliente">Cliente <span class="red-text">*</span></label>
                    <div class="hide">
                        <input type="number" id="npt_aux_cliente" value="" disabled>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <i class="material-icons prefix">work</i>
                    <input type="text" id="npt_actividad_economica" class="autocomplete" autocomplete="off" value="<?php echo $s[0][1]; ?>">
                    <label for="npt_actividad_economica">Actividad economica <span class="red-text">*</span></label>
                    <div class="hide">
                        <input type="text" id="npt_aux_actividad_economica" value="<?php echo $s[0][2]; ?>" disabled>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m2">
                    <i class="material-icons prefix">apps</i>
                    <select id="npt_matriz" disabled>
                        <option value="" disabled selected>Seleccionar</option>
                        <?php if ($npt_matriz != false) {
                            foreach ($npt_matriz as $item) {
                                echo '<option value="' . $item[0] . '" '.($item[0] == $s[0][3] ? 'selected' : '').'>' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Tipo matriz <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_fecha" type="date" value="<?php echo $s[0][4]; ?>" disabled>
                    <label for="npt_fecha">Fecha <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_monto" type="number" step="0.01" value="<?php echo $s[0][5]; ?>">
                    <label for="npt_monto">Monto <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_interes" type="number" step="0.01" value="<?php echo $s[0][6]; ?>">
                    <label for="npt_interes">Interes <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_plazo" type="number" step="1" value="<?php echo $s[0][7]; ?>">
                    <label for="npt_plazo">Plazo <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_cuota" type="number" step="0.01" value="<?php echo $s[0][8]; ?>">
                    <label for="npt_cuota">Cuota <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row center">
                <div class="input-field col s12 m4">
                    <div class="center"><label>Consta en listas de control</label></div>
                    <p>
                        <label>
                            <input name="npt_listas" type="radio" value="SI" <?php echo $s[0][9] == 'SI' ? 'checked' : ''; ?>/>
                            <span>SI</span>
                        </label>
                        <label>
                            <input name="npt_listas" type="radio" value="NO" <?php echo $s[0][9] == 'NO' ? 'checked' : ''; ?>/>
                            <span>NO</span>
                        </label>
                    </p>
                </div>
                <div class="input-field col s12 m4">
                    <div class="center"><label>Es vinculado</label></div>
                    <p>
                        <label>
                            <input name="npt_vinculado" type="radio" value="SI" <?php echo $s[0][10] == 'SI' ? 'checked' : ''; ?>/>
                            <span>SI</span>
                        </label>
                        <label>
                            <input name="npt_vinculado" type="radio" value="NO" <?php echo $s[0][10] == 'NO' ? 'checked' : ''; ?>/>
                            <span>NO</span>
                        </label>
                    </p>
                </div>
                <div class="input-field col s12 m4">
                    <div class="center"><label>Se realizó inspección</label></div>
                    <p>
                        <label>
                            <input name="npt_inspeccion" type="radio" value="SI" <?php echo $s[0][11] == 'SI' ? 'checked' : ''; ?>/>
                            <span>SI</span>
                        </label>
                        <label>
                            <input name="npt_inspeccion" type="radio" value="NO" <?php echo $s[0][11] == 'NO' ? 'checked' : ''; ?>/>
                            <span>NO</span>
                        </label>
                    </p>
                </div>
            </div>
        </div>
        <?php $a_1 = $db->sDetSol_1($age,$cod);
        if($a_1 != false){
            foreach ($a_1 as $a1) { ?>
                <div class="row">
                    <div class="col s12 center blue darken-4 white-text">
                        <h5><?php echo $a1[1]; ?></h5>
                    </div>
                </div>
                
                <div class="row">
                <?php $a_2 = $db->sDetSol_2($age,$cod,$a1[0]);
                if($a_2 != false){
                    foreach ($a_2 as $a2) { ?>
                        <div class="col s12 m6">
                            <div class="row">
                                <div class="col s12 center blue-grey darken-4 white-text bl"><h6><?php echo $a2[1]; ?></h6></div>

                                <?php $a_3 = $db->sDetSol_3($age,$cod,$a1[0],$a2[0]);
                                if($a_3 != false){
                                    foreach ($a_3 as $a3) { ?>
                                        <div class="col s12 center orange darken-4 white-text bl">
                                            <h6>
                                                <?php echo $a3[1]; ?>
                                                <a href="#¡" class="btn orange darken-2" onclick="iItmSol(this,<?php echo $a1[0].','.$a2[0].','.$a3[0].',\''.$a3[1].'\''; ?>);"><i class="material-icons">add</i></a>
                                            </h6>
                                        </div>
                                        <div class="col s12">
                                            
                                        <?php $a_4 = $db->sDetSol_4($age,$cod,$a1[0],$a2[0],$a3[0]);
                                        if($a_4 != false){
                                            echo '<table><tbody>';
                                            foreach ($a_4 as $a4) { ?>
                                                <tr>
                                                    <td><?php echo $a4[1]; ?></td>
                                                    <td><input type="number" step="0.01" value="<?php echo $a4[2]; ?>" 
                                                        onchange="uValSol(this,<?php echo $a1[0].','.$a2[0].','.$a3[0].','.$a4[0]; ?>);" 
                                                        onfocus="pValSol(this)"></td>
                                                    <td><select class="browser-default"
                                                        onchange="uSigSol(this,<?php echo $a1[0].','.$a2[0].','.$a3[0].','.$a4[0]; ?>);">
                                                            <option value="+" <?php echo $a4[3] == '+' ? 'selected' : ''; ?>>(+)</option>
                                                            <option value="-" <?php echo $a4[3] == '-' ? 'selected' : ''; ?>>(-)</option>
                                                        </select></td>
                                                    <td><a href="#¡" onclick="dItmSol(this,<?php echo $a1[0].','.$a2[0].','.$a3[0].','.$a4[0].',\''.$a4[1].'\''; ?>);"><i class="material-icons red-text">delete</i></a></td>
                                                </tr>
                                            <?php }
                                            echo '</tbody></table>';
                                        } ?>

                                        </div>
                                    <?php }
                                } ?>

                            </div>
                        </div>
                    <?php }
                } ?>
                </div>

            <?php }
        } ?>

        <div class="row">
            <div class="divider"></div>
            <div class="divider"></div>
            <div class="divider"></div>
        </div>

        <?php $cincoC_1 = $db->sDet5cSol_1($age,$cod);
        if($cincoC_1 != false){
            foreach ($cincoC_1 as $cincoC1) { ?>
                <div class="row">
                    <div class="col s12 m12 center blue darken-4 white-text">
                        <h5><?php echo $cincoC1[1]; ?></h5>
                    </div>

                    <?php $cincoC_2 = $db->sDet5cSol_2($age,$cod,$cincoC1[0]);
                    if($cincoC_2 != false){
                        foreach ($cincoC_2 as $cincoC2) { ?>
                            <div class="input-field col s12 m6">
                                <select onchange="uValSol5c(this,<?php echo $cincoC1[0].','.$cincoC2[0]; ?>);">
                                    <option value="" disabled selected><?php echo $cincoC2[1]; ?></option>
                                    
                                    <?php $cincoC_3 = $db->sDet5cSol_3($age,$cod,$cincoC1[0],$cincoC2[0]);
                                    if($cincoC_3 != false){
                                        foreach ($cincoC_3 as $cincoC3) {
                                            echo '<option value="'.$cincoC3[0].'" '.($cincoC3[2] == 'A' ? 'selected' : '').'>( '.$cincoC3[3].' ) '.$cincoC3[1].'</option>';
                                        }
                                    } ?>

                                </select>
                                <label><?php echo $cincoC2[1]; ?></label>
                            </div>
                        <?php }
                    } ?>

                </div>
            <?php }
        } ?>
    </div>
    <div class="resumen">
        <div class="resumen-content hide" id="resumen">...</div>
        <div class="resumen-buttom resultados" onclick="shwHdResumen(this)">RESUMEN</div>
        <div class="resumen-buttom imprimir" onclick="repSolicitud();">IMPRIMIR</div>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
