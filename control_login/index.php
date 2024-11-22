<?php
/**
 * Creado por Bryan Alejandro Chamba Freire
 */
session_start();
session_destroy();
include '../lliibb/config/vars.php';
?>
<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<link rel="icon" type="image/png" href="<?php echo DIR_IMAGES; ?>icono.png" />
	<title>BIENVENIDO</title>
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
		<form class="row center" id="fmr">
			<div class="col s12">
				<img src="<?php echo DIR_IMAGES; ?>logo.png" alt="">
			</div>
			<div class="col s12">
				<h5>SCORE DE CREDITO</h5>
			</div>
			<div class="input-field col s12">
				<i class="material-icons prefix blue-grey-text">person</i>
				<input id="npt_user" type="text" class="validate" required>
				<label for="npt_user">Usuario <span class="red-text">*</span></label>
			</div>
			<div class="input-field col s12">
				<i class="material-icons prefix blue-grey-text">security</i>
				<input id="npt_pass" type="password" class="validate" autocomplete="off" required>
				<label for="npt_pass">Contraseña <span class="red-text">*</span></label>
			</div>
			<div class="col s12"></div>
			<div class="col s12">
				<button class="btn-large blue" id="btn_main">Ingresar</button>
			</div>
		</form>
	</main>
	<div class="version teal darken-2 white-text">V.S. <?php echo VS_SHW; ?></div>
	<script src="js/index.js<?php echo VS; ?>"></script>
</body>

</html>