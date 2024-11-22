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
?>
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<meta charset="UTF-8">
		<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
		<title>CONTRASEÑA</title>
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
			<div class="container">
				<div class="row">
					<div class="col s12 center">
						<h2>Actualizar contraseña</h2>
					</div>
				</div>
				<form class="row" id="fmr">
					<div class="input-field col s12">
						<i class="material-icons prefix red-text">security</i>
						<input id="npt_oldpas" type="password" class="validate" autocomplete="off" autofocus>
						<label for="npt_oldpas">Antigua contraseña</label>
					</div>
					<div class="input-field col s12">
						<i class="material-icons prefix green-text">security</i>
						<input id="npt_newpas" type="password" class="validate" autocomplete="off">
						<label for="npt_newpas">Nueva contraseña</label>
					</div>
					<div class="input-field col s12">
						<i class="material-icons prefix yellow-text">security</i>
						<input id="npt_reppas" type="password" class="validate" autocomplete="off">
						<label for="npt_reppas">Repita contraseña</label>
					</div>
					<div class="col s12">
						<br><button class="btn-large blue">Aceptar</button>
					</div>
				</form>
			</div>
		</main>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
