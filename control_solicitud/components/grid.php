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

    $pagina = filter_input(INPUT_GET, 'P') ? $v['P'] : 1 ;
    $bus = filter_input(INPUT_GET, 'B') ? $v['B'] : '' ;
    $fin = filter_input(INPUT_GET, 'FI') ? $v['FI'] : die('¡Seleccione fecha inicio!') ;
    $ffi = filter_input(INPUT_GET, 'FF') ? $v['FF'] : die('¡Seleccione fecha final!') ;
    $est = filter_input(INPUT_GET, 'ES') ? $v['ES'] : 'ALL' ;

    $nro = $db->sCountSol();
    $lmt = 8;
    $pgs = ceil($nro/$lmt);
    $oft = $lmt*($pagina-1);
    $s = $db->sSolicitudes([$bus,$fin,$ffi,$est],$lmt,$oft);
?>
    <div id="auxParam">
        <?php if($s != false){ ?>
            <div class="row">
                <div class="col s12">
                    <table>
                        <thead>
                            <tr>
                                <th>Tipo matriz</th>
                                <th>Fecha</th>
                                <th>Cliente</th>
                                <th>Actividad economica</th>
                                <th>Monto</th>
                                <th>Lista de<br>control</th>
                                <th>Vínculado</th>
                                <th>Inspección</th>
                                <th>Estado</th>
                                <th>Usuario</th>
                                <th class="grey lighten-3">Edit</th>
                                <th>Del</th>
                                <th>Impre-<br>siones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($s as $item) {
                                $e = ['',''];
                                if($item[8] == 'A'){$e = ['APROBADO','green white-text'];}
                                else if($item[8] == 'R'){$e = ['RECHAZADO','red white-text'];}
                                else if($item[8] == 'S'){$e = ['SUSPENSO','grey white-text'];}
                                else{$e = ['EN PROCESO',''];}
                                echo '<tr>
                                <td>'.$item[0].'</td>
                                <td>'.$item[1].'</td>
                                <td>'.$item[2].'</td>
                                <td>'.$item[3].'</td>
                                <td class="green-text text-darken-4">$'.$item[4].'</td>
                                <td class="center">'.$item[5].'</td>
                                <td class="center">'.$item[6].'</td>
                                <td class="center">'.$item[7].'</td>
                                <td class="'.$e[1].' center">'.$e[0].'</td>
                                <td class="center">'.$item[9].'</td>
                                <td class="center grey lighten-3"><a href="#¡" onclick="eSolicitud('.$item[14].','.$item[15].');"><i class="material-icons">edit</i></a></td>
                                <td class="center"><a href="#¡" onclick="dSolicitud(this,'.$item[14].','.$item[15].');"><i class="material-icons red-text">delete</i></a></td>
                                <td class="center"><a href="#modal1" class="btn blue-grey darken-3 modal-trigger" onclick="vImpresiones(this,'.$item[14].','.$item[15].');">'.$item[10].'</a></td>
                                </tr>';
                            } ?>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row center">
                <div class="col s12 m9">
                    <?php
                    $limreg = $pagina + 12;
                    $limreg = $limreg > $pgs ? $pgs : $limreg;
                    echo '<ul class="pagination">';
                    echo '<li class="waves-effect"><a href="#!" onclick="grid('.($pagina == 1 ? 1 : $pagina-1).')"><img src="../lliibb/img/left-arrow.png" alt="" width="25"></a></li>';
                    for ($i=$pagina;$i<=$limreg;$i++) { 
                        echo '<li class="'.($pagina == $i ? 'active' : 'waves-effect').'"><a href="#!" onclick="grid('.$i.')">'.$i.'</a></li>';
                    }
                    echo '<li class="waves-effect"><a href="#!" onclick="grid('.($pagina >= $pgs ? $pgs : $pagina+1).')"><img src="../lliibb/img/right-arrow.png" alt="" width="25"></a></li>';
                    echo '</ul>';
                    ?>
                </div>
                <div class="input-field col s12 m3">
                    <a href="#!" class="btn blue-grey"><?php echo '&nbsp;P: '.$pagina.'&nbsp;&nbsp;&nbsp;T: '.$nro.'&nbsp;'; ?></a>
                </div>
            </div>
            <div id="modal1" class="modal modal-fixed-footer">
                <div class="modal-content">
                    <h4>Historial de impresiones</h4>
                    <div id="resImpresiones">Cargando...</div>
                </div>
                <div class="modal-footer">
                    <a href="#!" class="modal-close waves-effect waves-green btn cyan">Cerrar</a>
                </div>
            </div>
        <?php }else{ ?>
            <h3 class="red-text center">NO-DATA</h3>
        <?php } ?>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h3>
<?php }
