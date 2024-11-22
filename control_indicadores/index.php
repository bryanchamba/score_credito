<?php

/**
 * Creado por Bryan Alejandro Chamba Freire
 */
session_start();
include '../lliibb/config/vars.php';
include DIR_DEPLOYMENT;
if (isset($_SESSION['EMP']) && isset($_SESSION['USE']) && isset($_SESSION['AGE'])) {
	include CONEXION;
	include DIR_MODEL;
	$db = new Mod();
	$db->EMP = $_SESSION['EMP'];
	$db->USE = $_SESSION['USE'];
	$db->AGE = $_SESSION['AGE'];

	$matrices = $db->sMatrices();

?>
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<meta charset="UTF-8">
		<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
		<title>5C</title>
		<link rel="stylesheet" type="text/css" href="css/main.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>sweetalert2.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>materialize.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>icons.css<?php echo VS; ?>">
		<script src="<?php echo DIR_JS; ?>jquery.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>sweetalert2.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>materialize.min.js<?php echo VS; ?>"></script>
	</head>

	<body>
		<main>
			<div class="">
				<div class="row">
					<div class="col s12">
						<h3>INDICADORES</h3>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<select id="npt_matriz" onchange="indicador();">
							<option value="" selected disabled>Seleccionar</option>
							<?php if($matrices != false){
								foreach ($matrices as $item) {
									echo '<option value="'.$item[0].'">'.$item[1].'</option>';
								}
							} ?>
						</select>
						<label>Matriz</label>
					</div>
				</div>
				<div id="res"></div>
			</div>
		</main>
		<div class="resumen">
			<div class="resumen-content hide" id="resumen">...</div>
			<div class="resumen-buttom resultados" onclick="shwHdResumen(this)">RESUMEN</div>
		</div>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
