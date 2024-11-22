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

    $nro = $db->sCountCli();
    $lmt = 8;
    $pgs = ceil($nro/$lmt);
    $oft = $lmt*($pagina-1);
    $s = $db->sClientes([$bus],$lmt,$oft);
?>
    <div id="auxParam">
        <?php if($s != false){ ?>
            <div class="row">
                <div class="col s12">
                    <table>
                        <thead>
                            <tr>
                                <th>Identificación</th>
                                <th>Apellidos</th>
                                <th>Nombres</th>
                                <th>Fecha nacimiento</th>
                                <th>Género</th>
                                <th>Estado civil</th>
                                <th>Celular</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($s as $item) {
                                echo '<tr>
                                <td>'.$item[0].'</td>
                                <td>'.$item[1].'</td>
                                <td>'.$item[2].'</td>
                                <td>'.$item[3].'</td>
                                <td>'.$item[4].'</td>
                                <td>'.$item[5].'</td>
                                <td>'.$item[6].'</td>
                                <td class="center"><a href="#¡" onclick="eCliente('.$item[11].');"><i class="material-icons">edit</i></a></td>
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
        <?php }else{ ?>
            <h3 class="red-text center">NO-DATA</h3>
        <?php } ?>
    </div>
<?php } else { ?>
    <h3 class="red-text">Usuario no autorizado!</h2>
<?php }
