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
		<title>MENU SEGURIDAD</title>
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>sweetalert2.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>materialize.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>icons.css<?php echo VS; ?>">
		<script src="<?php echo DIR_JS; ?>jquery.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>sweetalert2.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>materialize.min.js<?php echo VS; ?>"></script>
		<link rel="stylesheet" type="text/css" href="css/main.css<?php echo VS; ?>">
	</head>

	<body>
		<ul id="slide-out" class="sidenav sidenav-fixed blue-grey darken-2">
			<li><div class="divider"></div></li>
			<li><a href="#!" class="white-text" onclick="item('control_contraseña');"><i class="material-icons yellow-text">lock_person</i>Actualizar contraseña</a></li>
			<li><a href="#!" class="white-text" onclick="item('control_usuarios');"><i class="material-icons blue-text">group</i>Usuarios</a></li>
			<br><br><br>
		</ul>
		<main id="main">
			<br><br><br><br>
			<center><img src="<?php echo DIR_IMAGES?>robot.jpeg" alt="" width="300px"></center>
		</main>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
