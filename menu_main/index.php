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

	$info = $db->sInfo();
?>
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<meta charset="UTF-8">
		<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
		<title>MENU</title>
		<link rel="stylesheet" type="text/css" href="css/main.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>sweetalert2.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>materialize.min.css<?php echo VS; ?>">
		<link rel="stylesheet" href="<?php echo DIR_CSS; ?>icons.css<?php echo VS; ?>">
		<script src="<?php echo DIR_JS; ?>jquery.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>sweetalert2.min.js<?php echo VS; ?>"></script>
		<script src="<?php echo DIR_JS; ?>materialize.min.js<?php echo VS; ?>"></script>

	</head>

	<body>
		<header>
			<nav class="blue-grey">
				<div class="nav-wrapper">
					<a href="#" class="brand-logo left hide-on-small-only" style="width:300px;text-align:center;"><img src="<?php echo DIR_IMAGES; ?>logo.png" alt=""></a>
					<ul id="nav-mobile" class="right">
						<li><a href="#¡" onclick="item('menu_procesos');"><i class="material-icons blue-text text-darken-4 left" style="font-size: 32px;">lan</i>Procesos</a></li>
						<!-- <li><a href="#¡" onclick="item('menu_consultas');"><i class="material-icons green-text text-lighten-2 left" style="font-size: 32px;">file_present</i>Consultas</a></li> -->
						<li><a href="#¡" onclick="item('menu_configuraciones');"><i class="large material-icons orange-text left" style="font-size: 32px;">settings</i>Configuraciones</a></li>
						<li><a href="#¡" onclick="item('menu_seguridad');"><i class="material-icons blue-text left" style="font-size: 32px;">security</i>Seguridad</a></li>
						<li><a href="#¡" class=" hide-on-med-and-down" style="font-size: 12px;font-weight:bold;"><i class="large material-icons left">account_balance</i><?php echo $info[0][0].' - '.$info[0][1]; ?></a></li>
						<li><a href="../control_login"><i class="material-icons red-text text-darken-3" style="font-size: 32px;">logout</i></a></li>
					</ul>
				</div>
			</nav>
		</header>
		<main id="main"></main>
		<div class="version teal darken-2 white-text">V.S. <?php echo VS_SHW; ?></div>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}
