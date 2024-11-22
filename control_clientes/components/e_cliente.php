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

    $cod = filter_input(INPUT_GET, 'COD') ? $v['COD'] : die('¡Parametro no encontrado!');
    $cod = is_numeric($cod) ? $v['COD'] : die('¡Parametro no reconocido!');

    $s = $db->sInfoCliente($cod);

    $npt_tipo_documento = $db->sTipDocumento();
    $npt_estado_civil = $db->sEstCivil();
    $npt_provincia = $db->sProvincias();
    $npt_canton = $db->sCantones($s[0][9]);
?>
    <div id="auxParam">
        <div class="row">
            <div class="col s12">
                <h4>Editar cliente</h4>
            </div>
        </div>
        <form class="card-panel" id="fmr_cli">
            <div class="row hide">
                <input type="text" id="npt_codigo" value="<?php echo $s[0][0]; ?>" disabled/>
            </div>
            <div class="row">
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">insert_drive_file</i>
                    <select id="npt_tipo_documento" disabled>
                        <?php if ($npt_tipo_documento != false) {
                            foreach ($npt_tipo_documento as $item) {
                                echo '<option value="' . $item[0] . '" '.($s[0][1] == $item[0] ? 'selected' : '').'>' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Tipo documento <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">insert_drive_file</i>
                    <input id="npt_identificacion" type="text" value="<?php echo $s[0][2]; ?>" class="validate" disabled>
                    <label for="npt_identificacion">Identificación <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">confirmation_number</i>
                    <input id="npt_nro_socio" type="text" value="<?php echo $s[0][3]; ?>" class="validate">
                    <label for="npt_nro_socio">Nro. Socio <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">person</i>
                    <input id="npt_apellidos" type="text" value="<?php echo $s[0][4]; ?>" class="validate">
                    <label for="npt_apellidos">Apellidos <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">person</i>
                    <input id="npt_nombres" type="text" value="<?php echo $s[0][5]; ?>" class="validate">
                    <label for="npt_nombres">Nombres <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">date_range</i>
                    <input id="npt_fecha_nacimento" type="date" value="<?php echo $s[0][6]; ?>" class="validate">
                    <label for="npt_fecha_nacimento">Fecha nacimeinto <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">person_outline</i>
                    <select id="npt_genero">
                        <option value="" disabled selected>Seleccionar</option>
                        <option value="M" <?php echo ($s[0][7] == 'M' ? 'selected' : ''); ?>>Masculino</option>
                        <option value="F" <?php echo ($s[0][7] == 'F' ? 'selected' : ''); ?>>Femenino</option>
                    </select>
                    <label>Género <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">person_outline</i>
                    <select id="npt_estado_civil">
                        <option value="" disabled selected>Seleccionar</option>
                        <?php if ($npt_estado_civil != false) {
                            foreach ($npt_estado_civil as $item) {
                                echo '<option value="' . $item[0] . '" '.($s[0][8] == $item[0] ? 'selected' : '').'>' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Estado civil <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">phone</i>
                    <input id="npt_telefono_convencional" type="number" value="<?php echo $s[0][13]; ?>" class="validate">
                    <label for="npt_telefono_convencional">Telefono convencional <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">phone_android</i>
                    <input id="npt_telefono_celular" type="number" value="<?php echo $s[0][14]; ?>" class="validate">
                    <label for="npt_telefono_celular">Telefono cecular <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row">
                <div class="col s12 m12 l12"><div class="divider"></div></div>
            </div>
            <div class="row">
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">location_on</i>
                    <select id="npt_provincia" onchange="chaProvincia(this);">
                        <option value="" disabled selected>Seleccionar</option>
                        <?php if ($npt_provincia != false) {
                            foreach ($npt_provincia as $item) {
                                echo '<option value="' . $item[0] . '" '.($s[0][9] == $item[0] ? 'selected' : '').'>' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Provincia <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">location_on</i>
                    <select id="npt_canton">
                        <option value="" disabled selected>Seleccionar</option>
                        <?php if ($npt_canton != false) {
                            foreach ($npt_canton as $item) {
                                echo '<option value="' . $item[0] . '" '.($s[0][10] == $item[0] ? 'selected' : '').'>' . $item[1] . '</option>';
                            }
                        } ?>
                    </select>
                    <label>Cantón <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">location_on</i>
                    <input id="npt_sector" type="text" value="<?php echo $s[0][12]; ?>" class="validate">
                    <label for="npt_sector">Sector <span class="red-text">*</span></label>
                </div>
                <div class="input-field col s12 m3">
                    <i class="material-icons prefix">location_on</i>
                    <input id="npt_direccion" type="text" value="<?php echo $s[0][11]; ?>" class="validate">
                    <label for="npt_direccion">Dirección <span class="red-text">*</span></label>
                </div>
            </div>
            <div class="row">
                <div class="col s12 m12 l12"><div class="divider"></div></div>
            </div>
            <div class="row">
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">work</i>
                    <input id="npt_telefono_trabajo" type="text" value="<?php echo $s[0][17]; ?>" class="validate">
                    <label for="npt_telefono_trabajo">Telefono trabajo</label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">work</i>
                    <input id="npt_sector_trabajo" type="text" value="<?php echo $s[0][16]; ?>" class="validate">
                    <label for="npt_sector_trabajo">Sector trabajo</label>
                </div>
                <div class="input-field col s12 m4">
                    <i class="material-icons prefix">work</i>
                    <input id="npt_direccion_trabajo" type="text" value="<?php echo $s[0][15]; ?>" class="validate">
                    <label for="npt_direccion_trabajo">Dirección trabajo</label>
                </div>
            </div>
            <div class="row">
                <div class="col s12 m12 l12"><div class="divider"></div></div>
            </div>
            <div class="row">
                <div class="col s12 center">
                    <a href="#¡" class="btn blue-grey" onclick="grd(1);">VOLVER<i class="right material-icons white-text">arrow_back</i></a>
                    <a href="#¡" class="btn grey" onclick="cliente();">NUEVO<i class="right material-icons white-text">add</i></a>
                    <button class="btn blue" onclick="uCliente(event);">ACTUALIZAR<i class="right material-icons white-text">update</i></button>
                </div>
            </div>
        </form>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
