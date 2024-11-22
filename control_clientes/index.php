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

	$new = filter_input(INPUT_GET, 'NEW') ? 'Y' : 'N';

?>
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<meta charset="UTF-8">
		<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
		<title>CLIENTES</title>
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
						<h3>Clientes</h3>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12 m7">
						<input id="npt_busqueda" type="text" value="">
						<label for="npt_busqueda">Busqueda rapida</label>
					</div>
					<div class="input-field col s12 m5 center">
						<a href="#!" class="btn blue" onclick="grid(1);"><i class="material-icons right">search</i>Buscar</a>
						<a href="#!" class="btn cyan" onclick="cliente();" id="btn_new"><i class="material-icons right">add</i>Nuevo</a>
						<a href="#modal1" class="btn red modal-trigger"><i class="material-icons right">file_upload</i>Carga masiva</a>
					</div>
				</div>
				<div id="res_grid"></div>
			</div>
		</main>
		<div id="modal1" class="modal modal-fixed-footer">
			<div class="modal-content">
				<h4>Carga masiva clientes</h4>
				<div class="divider"></div>
				<form class="row" onsubmit="uplFlList(event);">
					<div class="file-field input-field col s12">
						<div class="btn">
							<span>EXCEL</span>
							<input type="file" id="archivo">
						</div>
						<div class="file-path-wrapper">
							<input class="file-path validate" type="text" placeholder="Seleccione un archivo.">
						</div>
					</div>
					<div class="col s12 center">
						<button class="btn blue" id="btnUpdFile">Cargar datos</button>
					</div>
					<div class="col s12" id="resData"></div>
				</form>
				<div class="divider"></div>
				<div class="formato-clientes">
					<h5>Formato</h5>
					<p>
						<span class="red-text">*</span> Formato de todas las celdas (Texto).<br>
						<span class="red-text">*</span> Número de socio maximo 10 digitos.<br>
					</p>
					<img src="<?php echo DIR_IMAGES; ?>formato_clientes.png" alt="">
					<a href="components/descargar.php" class="btn indigo" target="_blank">Descargar archivo ejemplo</a>
				</div>
			</div>
			<div class="modal-footer">
				<a href="#!" class="modal-close waves-effect waves-green btn red">Cancelar</a>
			</div>
		</div>
		<script src="js/index.js<?php echo VS; ?>"></script>
		<script>
			if (<?php echo '\'' . $new . '\''; ?> == 'Y') {
				setTimeout(() => {
					document.getElementById('btn_new').click();
				}, 500);
			}
		</script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
