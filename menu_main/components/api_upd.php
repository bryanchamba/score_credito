<?php
/* Creado por: Bryan Alejandro Chamba Freire */
session_start();
if(isset($_SESSION['g_usuario'])){ 
    include '../../lliibb/config/cnxn.php';
    include '../../lliibb/config/vars.php';
	include '../index.mod.php';
    $db = new Mod();
    $db->EMP = $_SESSION['EMP'];
    $db->USE = $_SESSION['USE'];
    $pagina = filter_input(INPUT_GET, 'P') ? filter_input(INPUT_GET, 'P') : 1 ;
    $fec = filter_input(INPUT_GET, 'F') ? filter_input(INPUT_GET, 'F') : die('...') ;
    $bus = filter_input(INPUT_GET, 'B') ? filter_input(INPUT_GET, 'B') : '' ;
    $nro = $db->sCountDili($fec,$bus);
    $tots = $db->sCountDiliTot($fec,$bus);
    $lmt = 5;
    $pgs = ceil($nro/$lmt);
    $oft = $lmt*($pagina-1);
    $par = $db->sTraMes($fec,$lmt,$oft,$bus);
    ?>
    <div id="auxParam">
        <div class="row">
            <div class="col s12 center"><h4>DETALLE DEL PERIODO / TRANSACCIONES POR MES</h4></div>
            <div class="input-field col s12 m6 l4">
                <input type="text" id="brap" value="<?php echo $bus; ?>" onchange="transacMes(1)" onfocus="this.select();">
                <label for="brap">Busqueda rapida</label>
            </div>
            <div class="input-field col s12 m6 l8 center">
                <span>Total Perfil<br>Financiero</span><br>
                <?php if($tots!=false){foreach ($tots as $item) {
                    if($item[0] == 'B'){$t=['BAJO','green white-text'];}else if($item[0] == 'M'){$t=['MEDIO','yellow'];}else if($item[0] == 'A'){$t=['ALTO','red white-text'];}
                    echo '<div class="chip '.$t[1].'">'.$t[0].' '.$item[1].'</div>';
                }} ?>
            </div>
            <div class="col s12">
                <table class="highlight tbl-striped-columns">
                    <thead>
                        <tr>
                            <th colspan="3" class="blue-grey white-text center">SOCIO</th>
                            <th colspan="24" class="blue-grey darken-1 white-text center">MESES</th>
                            <th colspan="4" class="blue-grey white-text center">TOTALES</th>
                        </tr>
                        <tr>
                            <th></th>
                            <th>CEDULA/RUC</th>
                            <th>NOMBRE</th>
                            <th>ENERO</th>
                            <th>FREC</th>
                            <th>FEBRERO</th>
                            <th>FREC</th>
                            <th>MARZO</th>
                            <th>FREC</th>
                            <th>ABRIL</th>
                            <th>FREC</th>
                            <th>MAYO</th>
                            <th>FREC</th>
                            <th>JUNIO</th>
                            <th>FREC</th>
                            <th>JULIO</th>
                            <th>FREC</th>
                            <th>AGOSTO</th>
                            <th>FREC</th>
                            <th>SEPTIEMBRE</th>
                            <th>FREC</th>
                            <th>OCTUBRE</th>
                            <th>FREC</th>
                            <th>NOVIEMBRE</th>
                            <th>FREC</th>
                            <th>DICIEMBRE</th>
                            <th>FREC</th>
                            <th>TOTAL<br>PERIODO</th>
                            <th>TOTAL</th>
                            <th>INGRESOS<br>MENSUALES</th>
                            <th>PERFIL<br>FINANCIERO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if($par != false){
                            foreach ($par as $k => $item) {
                                $pf = ['',''];
                                if($item[29] == 'B'){$pf=['BAJO','green white-text center'];}else if($item[29] == 'M'){$pf=['MEDIO','yellow center'];}else if($item[29] == 'A'){$pf=['ALTO','red white-text center'];}
                                $limites = explode('|',$item[30]);
                                $valores = [
                                    ['Ene',$limites[0],$limites[1],$limites[2],$item[2]],
                                    ['Feb',$limites[0],$limites[1],$limites[2],$item[4]],
                                    ['Mar',$limites[0],$limites[1],$limites[2],$item[6]],
                                    ['Abr',$limites[0],$limites[1],$limites[2],$item[8]],
                                    ['May',$limites[0],$limites[1],$limites[2],$item[10]],
                                    ['Jun',$limites[0],$limites[1],$limites[2],$item[12]],
                                    ['Jul',$limites[0],$limites[1],$limites[2],$item[14]],
                                    ['Ago',$limites[0],$limites[1],$limites[2],$item[16]],
                                    ['Sep',$limites[0],$limites[1],$limites[2],$item[18]],
                                    ['Oct',$limites[0],$limites[1],$limites[2],$item[20]],
                                    ['Nov',$limites[0],$limites[1],$limites[2],$item[22]],
                                    ['Dic',$limites[0],$limites[1],$limites[2],$item[24]],
                                ];
                                $transacPeriodo = $db->sTransacPer($item[0]);
                                $Numerotransac = $db->sNumTransac($item[0]);
                                echo '<tr>';
                                echo '<td><a href="#!" class="btn red" onclick="shdGraf(this,\'rep'.$k.'\',[[\'rep01'.$k.'\', '.str_replace('"', '\'', json_encode($valores)).'],[\'rep02'.$k.'\', '.str_replace('"', '\'', json_encode($transacPeriodo)).'],[\'rep03'.$k.'\', '.str_replace('"', '\'', json_encode($Numerotransac)).']]);">G</a></td>';
                                echo '<td>'.$item[0].'</td>';
                                echo '<td>'.$item[1].'</td>';
                                echo '<td>'.$item[2].'</td>';
                                echo '<td>'.$item[3].'</td>';
                                echo '<td>'.$item[4].'</td>';
                                echo '<td>'.$item[5].'</td>';
                                echo '<td>'.$item[6].'</td>';
                                echo '<td>'.$item[7].'</td>';
                                echo '<td>'.$item[8].'</td>';
                                echo '<td>'.$item[9].'</td>';
                                echo '<td>'.$item[10].'</td>';
                                echo '<td>'.$item[11].'</td>';
                                echo '<td>'.$item[12].'</td>';
                                echo '<td>'.$item[13].'</td>';
                                echo '<td>'.$item[14].'</td>';
                                echo '<td>'.$item[15].'</td>';
                                echo '<td>'.$item[16].'</td>';
                                echo '<td>'.$item[17].'</td>';
                                echo '<td>'.$item[18].'</td>';
                                echo '<td>'.$item[19].'</td>';
                                echo '<td>'.$item[20].'</td>';
                                echo '<td>'.$item[21].'</td>';
                                echo '<td>'.$item[22].'</td>';
                                echo '<td>'.$item[23].'</td>';
                                echo '<td>'.$item[24].'</td>';
                                echo '<td>'.$item[25].'</td>';
                                echo '<td>'.$item[26].'</td>';
                                echo '<td>'.$item[27].'</td>';
                                echo '<td>'.$item[28].'</td>';
                                echo '<td class="'.$pf[1].'">'.$pf[0].'</td>';
                                echo '</tr>';
                                
                                echo '<tr><td colspan="31" class="hide" id="rep'.$k.'">
                                    <div class="row">
                                        <div class="col s12 m12" id="rep01'.$k.'" style="height:300px;"></div>
                                        <div class="col s12 m6" id="rep02'.$k.'" style="height:300px;"></div>
                                        <div class="col s12 m6" id="rep03'.$k.'" style="height:300px;"></div>
                                    </div>
                                <td></tr>';
                            }
                        }else{
                            echo '<tr><td class="center" colspan="8">NO-DATA</td><tr>';
                        } ?>
                        <?php  ?>
                    </tbody>
                </table>
            </div>
            <div class="col s12 center"><br></div>
            <div class="col s12 center">
                <?php
                if($par != false){
                    $limreg = $pagina + 20;
                    $limreg = $limreg > $pgs ? $pgs : $limreg;
                    echo '<ul class="pagination">';
                    echo '<li class="waves-effect"><a href="#!" onclick="resumen('.($pagina == 1 ? 1 : $pagina-1).')"><img src="../lliibb/img/left-arrow.png" alt="" width="30"></a></li>';
                    for ($i=$pagina;$i<=$limreg;$i++) { 
                        echo '<li class="'.($pagina == $i ? 'active' : 'waves-effect').'"><a href="#!" onclick="resumen('.$i.')">'.$i.'</a></li>';
                    }
                    echo '<li class="waves-effect"><a href="#!" onclick="resumen('.($pagina >= $pgs ? $pgs : $pagina+1).')"><img src="../lliibb/img/right-arrow.png" alt="" width="30"></a></li>';
                    echo '<li class="disabled"><a href="#!">T.'.$nro.'</a></li>';
                    echo '</ul>';
                }
                ?>
            </div>
        </div>
    </div>
    <div class="divider"></div>
    <?php
}else{
    ?>
    <h3 class="red-text">Usario no autorizado!</h2>
    <?php
}