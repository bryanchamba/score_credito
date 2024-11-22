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
		<title>SOLICITUDES</title>
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
			<div class="" id="res">
				<div class="row">
					<div class="col s12">
						<h3>Solicitudes</h3>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12 m2">
						<input id="npt_busqueda" type="text" value="">
						<label for="npt_busqueda">Busqueda rapida</label>
					</div>
					<div class="input-field col s12 m2">
						<input id="npt_fecha_inicio" type="date" value="<?php echo Date('Y-m-d'); ?>">
						<label for="npt_fecha_inicio">Desde</label>
					</div>
					<div class="input-field col s12 m2">
						<input id="npt_fecha_final" type="date" value="<?php echo Date('Y-m-d'); ?>">
						<label for="npt_fecha_final">Hasta</label>
					</div>
					<div class="input-field col s12 m3">
						<select id="npt_estado">
							<option value="ALL" selected>Todos</option>
							<option value="P">En proceso</option>
							<option value="A">Aprobado</option>
							<option value="R">Rechazado</option>
						</select>
						<label>Estado</label>
					</div>
					<div class="input-field col s12 m3 center">
						<a href="#!" class="btn blue" onclick="grid(1);"><i class="material-icons right">search</i>Buscar</a>
						<a href="#!" class="btn cyan" onclick="solicitud();"><i class="material-icons right">add</i>Nuevo</a>
					</div>
				</div>
				<div id="res_grid"></div>
			</div>
		</main>
		<div id="modal1" class="modal modal-fixed-footer">
			<div class="modal-content" id="res_modal" style="overflow-y: hidden;padding: 0;"></div>
			<div class="modal-footer">
				<a href="#!" class="modal-close waves-effect waves-green btn-flat">Cerrar</a>
			</div>
		</div>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
