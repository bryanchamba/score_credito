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
	$s = $db->sAgencias();
?>
	<!DOCTYPE html>
	<html lang="es">

	<head>
		<meta charset="UTF-8">
		<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
		<title>AGENCIAS</title>
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
					<div class="col s12">
						<h2>Agencias</h2>
					</div>
				</div>
				<?php 
				if ($s != false) { ?>
				<div class="row">
					<div class="col s12 hide">
						<div class="right"><button class="btn blue" onclick="fmrAdd();">Nuevo<i class="right material-icons white-text">add</i></button></div>
					</div>
					<div class="col s12">
						<table class="highlight">
							<thead>
								<tr>
									<th>Codigo</th>
									<th>Descripciíon</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<?php foreach ($s as $item) {
									echo '<tr>
									<td>'.$item[0].'</td>
									<td>'.$item[1].'</td>
									<td><i class="material-icons pointer blue-text" onclick="fmrEdit('.$item[0].',\''.str_replace('\'',' ',$item[1]).'\');">edit</i></td>
									</tr>';
								} ?>
								<?php  ?>
							</tbody>
						</table>
					</div>
				</div>
				<?php } else { ?>
				<div class="row">
					<div class="col s12">
						<h4 class="red-text">NO-DATA</h4>
					</div>
				</div>
				<?php } ?>
			</div>
		</main>
		<script src="js/index.js<?php echo VS; ?>"></script>
	</body>

	</html>
<?php
} else {
	echo '¡Usuario no autorizado!';
}