<?php
define('SLH','/');
define('BKC','..');
define('THS','.');
define('VS','?0.0.1');
define('VS_SHW','1.0.0');
define('DEPLOYMENT',false);

define('FOLDER_LIB','lliibb');
define('FOLDER_CONFIG','config');
define('FOLDER_LIBRERIAS','librerias');
define('FOLDER_JS','js');
define('FOLDER_CSS','css');
define('FOLDER_IMG','img');
define('FOLDER_MEDIA','media');

define('DIR_LIB',BKC.SLH.FOLDER_LIB);
define('DIR_JS',BKC.SLH.FOLDER_LIB.SLH.FOLDER_JS.SLH);
define('DIR_CSS',BKC.SLH.FOLDER_LIB.SLH.FOLDER_CSS.SLH);
define('DIR_IMAGES',BKC.SLH.FOLDER_LIB.SLH.FOLDER_IMG.SLH);
define('DIR_MEDIA',BKC.SLH.FOLDER_LIB.SLH.FOLDER_MEDIA.SLH);
define('DIR_CONFIG',DIR_LIB.SLH.FOLDER_CONFIG.SLH);
define('DIR_DEPLOYMENT',DIR_LIB.SLH.FOLDER_CONFIG.SLH.'deployment.php');
define('DIR_MODEL',THS.SLH.'index.mod.php');
define('DIR_FPDF',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'FPDF'.SLH.'fpdf.php');
define('DIR_TCPDF',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'TCPDF'.SLH.'tcpdf.php');
define('DIR_PHPMAILER',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'PHPMailer'.SLH.'PHPMailerAutoload.php');

define('DIR_BARCODE_01',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'BARCODE'.SLH.'class'.SLH.'BCGFontFile.php');
define('DIR_BARCODE_02',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'BARCODE'.SLH.'class'.SLH.'BCGColor.php');
define('DIR_BARCODE_03',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'BARCODE'.SLH.'class'.SLH.'BCGDrawing.php');
define('DIR_BARCODE_04',DIR_LIB.SLH.FOLDER_LIBRERIAS.SLH.'BARCODE'.SLH.'class'.SLH.'BCGcode128.barcode.php');

define('CONEXION',DIR_CONFIG.'cnxn.php');