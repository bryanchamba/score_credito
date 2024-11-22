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

    $npt_matriz = $db->sMatriz();
?>
    <div id="auxParam">
        <div class="row">
            <div class="col s12">
                <h4>Nueva solicitud</h4>
            </div>
        </div>
        <div class="row">
            <div class="col s12 center">
                <button class="btn blue" onclick="iSolicitud();">GUARDAR<i class="right material-icons white-text">add</i></button>
                <div class="right">
                    <button class="btn blue-grey" onclick="grd();">VOLVER<i class="right material-icons white-text">arrow_back</i></button>
                    <button class="btn blue" onclick="solicitud();">NUEVO<i class="right material-icons white-text">add</i></button>
                </div>
            </div>
        </div>
        <div class="card-panel">
            <div class="row">
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">person</i>
                    <input type="text" id="npt_cliente" class="autocomplete" autocomplete="off">
                    <label for="npt_cliente">Cliente <span class="red-text">*</span></label>
                    <div class="hide">
                        <input type="number" id="npt_aux_cliente" value="" disabled>
                    </div>
                </div>
                <div class="input-field col s12 m6 center" id="aux_cli">
                    ................. <br> .................
                </div>
                <div class="input-field col s12 m2 center">
                    <a href="#modal1" class="btn red modal-trigger" onclick="nCliente();"><i class="material-icons">add</i><i class="material-icons">person</i></a>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <i class="material-icons prefix">work</i>
                    <input type="text" id="npt_actividad_economica" class="autocomplete" autocomplete="off">
                    <label for="npt_actividad_economica">Actividad economica <span class="red-text">*</span></label>
                    <div class="hide">
                        <input type="text" id="npt_aux_actividad_economica" value="" disabled>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m2">
                    <i class="material-icons prefix">apps</i>
                    <select id="npt_matriz">
                        <option value="" disabled selected>Seleccionar</option>
                        <?php if ($npt_matriz != false) {
                            foreach ($npt_matriz as $item) {
                                echo '<option value="' . $item[0] . '">' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Tipo matriz <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_fecha" type="date" value="<?php echo Date('Y-m-d'); ?>">
                    <label for="npt_fecha">Fecha <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_monto" type="number" step="0.01" value="">
                    <label for="npt_monto">Monto <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_interes" type="number" step="0.01" value="">
                    <label for="npt_interes">Interes <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_plazo" type="number" step="1" value="">
                    <label for="npt_plazo">Plazo <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m2">
                    <input id="npt_cuota" type="number" step="0.01" value="">
                    <label for="npt_cuota">Cuota <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row center">
                <div class="input-field col s12 m4">
                    <div class="center"><label>Consta en listas de control</label></div>
                    <p>
                        <label>
                            <input name="npt_listas" type="radio" value="SI" />
                            <span>SI</span>
                        </label>
                    </p>
                    <p>
                        <label>
                            <input name="npt_listas" type="radio" value="NO" checked />
                            <span>NO</span>
                        </label>
                    </p>
                </div>
                <div class="input-field col s12 m4">
                    <div class="center"><label>Es vinculado</label></div>
                    <p>
                        <label>
                            <input name="npt_vinculado" type="radio" value="SI" />
                            <span>SI</span>
                        </label>
                    </p>
                    <p>
                        <label>
                            <input name="npt_vinculado" type="radio" value="NO" checked />
                            <span>NO</span>
                        </label>
                    </p>
                </div>
                <div class="input-field col s12 m4">
                    <div class="center"><label>Se realizó inspección</label></div>
                    <p>
                        <label>
                            <input name="npt_inspeccion" type="radio" value="SI" />
                            <span>SI</span>
                        </label>
                    </p>
                    <p>
                        <label>
                            <input name="npt_inspeccion" type="radio" value="NO" checked />
                            <span>NO</span>
                        </label>
                    </p>
                </div>
            </div>
        </div>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
