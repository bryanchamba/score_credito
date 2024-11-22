drop schema "public" cascade;
create schema "public";

create table tbl_tip_documento(
tdo_codigo char(1) not null,
tdo_descri varchar(10) not null
);
alter table tbl_tip_documento add constraint pk_tbl_tip_documento primary key(tdo_codigo);
insert into tbl_tip_documento values('C','CEDULA');
insert into tbl_tip_documento values('P','PASAPORTE');

create table tbl_est_civil(
eci_codigo char(1) not null,
eci_descri varchar(25) not null
);
alter table tbl_est_civil add constraint pk_tbl_estciv primary key (eci_codigo);
insert into tbl_est_civil values('S','SOLTERO/A');
insert into tbl_est_civil values('C','CASADO/A');
insert into tbl_est_civil values('D','DIVORCIADO/A');
insert into tbl_est_civil values('U','UNION LIBRE');
insert into tbl_est_civil values('V','VIUDO/A');

create table tbl_empresas(
emp_codigo smallint not null,
emp_descri varchar(100) not null,
emp_usuari varchar(25) not null,
emp_fecsis date not null
);
alter table tbl_empresas add constraint pk_tbl_empresas primary key(emp_codigo);
insert into tbl_empresas values(1,'VIP-G','bryan','2020-01-23');

create table tbl_agencias(
emp_codigo smallint not null,
age_codigo smallint not null,
age_descri varchar(100) not null
);
alter table tbl_agencias add constraint pk_tbl_agencias primary key (emp_codigo,age_codigo);
alter table tbl_agencias add constraint fk_emp_to_age foreign key (emp_codigo) references tbl_empresas (emp_codigo);
insert into tbl_agencias values(1,1,'MATRIZ');
/*---------------------------*/
create table tbl_dat_usuarios(
emp_codigo smallint not null,
dus_codigo int not null,
tdo_codigo char(1) not null,
dus_cedruc varchar(15) not null,
dus_apelli varchar(75) not null,
dus_nombre varchar(75) not null,
dus_email varchar(75) not null,
dus_usuari varchar(25) not null,
dus_fecsis timestamp not null,
unique(dus_cedruc,emp_codigo)
);
alter table tbl_dat_usuarios add constraint pk_tbl_dat_usuarios primary key(dus_codigo,emp_codigo);
alter table tbl_dat_usuarios add constraint fk_tbl_dat_usuarios_tbl_tip_documento foreign key(tdo_codigo) references tbl_tip_documento(tdo_codigo);
alter table tbl_dat_usuarios add constraint fk_tbl_datusu_to_emp foreign key(emp_codigo) references tbl_empresas(emp_codigo);
insert into tbl_dat_usuarios values(1,1,'C','0703887497','CHAMBA FREIRE','BRYAN ALEJANDRO','bryan96ch@hotmail.com','bryan',current_timestamp);
insert into tbl_dat_usuarios values(1,2,'C','0703887498','VIP','G','vipg@vipg.com','bryan',current_timestamp);

create table sec_usuarios(
emp_codigo smallint not null,
age_codigo smallint not null,
dus_codigo int not null,
usu_login varchar(25) not null,
usu_passw varchar(200) not null,
usu_estado char(1) not null,
usu_menu varchar(25) not null,
usu_usuari varchar(25) not null,
usu_fecsis timestamp not null,
unique(usu_login)
);
alter table sec_usuarios add constraint pk_sec_usuarios primary key(emp_codigo,usu_login);
alter table sec_usuarios add constraint fk_usu_to_datusu foreign key(dus_codigo,emp_codigo) references tbl_dat_usuarios(dus_codigo,emp_codigo);
insert into sec_usuarios values(1,1,1,'bryan','40bd001563085fc35165329ea1ff5c5ecbdbbeef','A','all','bryan',current_timestamp);
insert into sec_usuarios values(1,1,2,'vipg','40bd001563085fc35165329ea1ff5c5ecbdbbeef','A','all','bryan',current_timestamp);

create table sec_log(
emp_codigo smallint not null,
age_codigo smallint not null,
log_codigo serial primary key,
log_fecsis date not null,
log_horsis time not null,
usu_login varchar(25) not null,
log_accion varchar(25) not null,
log_descri text
);

create table tbl_provincias(
pro_codigo smallint not null,
pro_auxcod char(2) not null,
pro_descri varchar(50) not null
);
alter table tbl_provincias add constraint pk_provi primary key (pro_codigo);
insert into tbl_provincias (pro_codigo,pro_auxcod,pro_descri) values 
	(1,'01','AZUAY'),
	(2,'02','BOLIVAR'),
	(3,'03','CAÑAR'),
	(4,'04','CARCHI'),
	(5,'05','COTOPAXI'),
	(6,'06','CHIMBORAZO'),
	(7,'07','EL ORO'),
	(8,'08','ESMERALDAS'),
	(9,'09','GUAYAS'),
	(10,'10','IMBABURA');
insert into tbl_provincias (pro_codigo,pro_auxcod,pro_descri) values
	(11,'11','LOJA'),
	(12,'12','LOS RIOS'),
	(13,'13','MANABI'),
	(14,'14','MORONA'),
	(15,'15','NAPO'),
	(16,'16','PASTAZA'),
	(17,'17','PICHINCHA'),
	(18,'18','TUNGURAHUA'),
	(19,'19','ZAMORA'),
	(20,'20','GALAPAGOS');
insert into tbl_provincias (pro_codigo,pro_auxcod,pro_descri) values
	(21,'21','SUCUMBIOS'),
	(22,'22','ORELLANA'),
	(23,'23','SANTO DOMINGO DE LOS TSACHILAS'),
	(24,'24','SANTA ELENA');

create table tbl_cantones(
pro_codigo smallint not null,
can_codigo smallint not null,
can_auxcod char(2) not null,
can_descri varchar(50) not null
);
alter table tbl_cantones add constraint pk_cant primary key (pro_codigo,can_codigo);
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (1,1,'01','CUENCA'),
	 (1,2,'02','GIRON'),
	 (1,3,'03','GUALACEO'),
	 (1,4,'04','NABON'),
	 (1,5,'05','PAUTE'),
	 (1,6,'06','PUCARA'),
	 (1,7,'07','SAN FERNANDO'),
	 (1,8,'08','SANTA ISABEL'),
	 (1,9,'09','SIGSIG'),
	 (1,10,'10','OÑA');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (1,11,'11','CHORDELEG'),
	 (1,12,'12','EL PAN'),
	 (1,13,'13','SEVILLA DE ORO'),
	 (1,14,'14','GUACHAPALA'),
	 (1,15,'15','CAMILO PONCE ENRIQUEZ'),
	 (2,1,'01','GUARANDA'),
	 (2,2,'02','CHILLANES'),
	 (2,3,'03','CHIMBO'),
	 (2,4,'04','ECHEANDIA'),
	 (2,5,'05','SAN MIGUEL');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (2,6,'06','CALUMA'),
	 (2,7,'07','LAS NAVES'),
	 (3,1,'01','AZOGUES'),
	 (3,2,'02','BIBLIAN'),
	 (3,3,'03','CAÑAR'),
	 (3,4,'04','LA TRONCAL'),
	 (3,5,'05','EL TAMBO'),
	 (3,6,'06','DEELEG'),
	 (3,7,'07','SUSCAL'),
	 (4,1,'01','TULCAN');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (4,2,'02','BOLIVAR'),
	 (4,3,'03','ESPEJO'),
	 (4,4,'04','MIRA'),
	 (4,5,'05','MONTUFAR'),
	 (4,6,'06','SAN PEDRO DE HUACA'),
	 (5,1,'01','LATACUNGA'),
	 (5,2,'02','LA MANA'),
	 (5,3,'03','PANGUA'),
	 (5,4,'04','PUJILI'),
	 (5,5,'05','SALCEDO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (5,6,'06','SAQUISILI'),
	 (5,7,'07','SIGCHOS'),
	 (6,1,'01','RIOBAMBA'),
	 (6,2,'02','ALAUSI'),
	 (6,3,'03','COLTA'),
	 (6,4,'04','CHAMBO'),
	 (6,5,'05','CHUNCHI'),
	 (6,6,'06','GUAMOTE'),
	 (6,7,'07','GUANO'),
	 (6,8,'08','PALLATANGA');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (6,9,'09','PENIPE'),
	 (6,10,'10','CUMANDA'),
	 (7,1,'01','MACHALA'),
	 (7,2,'02','ARENILLAS'),
	 (7,3,'03','ATAHUALPA'),
	 (7,4,'04','BALSAS'),
	 (7,5,'05','CHILLA'),
	 (7,6,'06','EL GUABO'),
	 (7,7,'07','HUAQUILLAS'),
	 (7,8,'08','MARCABELI');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (7,9,'09','PASAJE'),
	 (7,10,'10','PIÑAS'),
	 (7,11,'11','PORTOVELO'),
	 (7,12,'12','SANTA ROSA'),
	 (7,13,'13','ZARUMA'),
	 (7,14,'14','LAS LAJAS'),
	 (8,1,'01','ESMERALDAS'),
	 (8,2,'02','ELOY ALFARO'),
	 (8,3,'03','MUISNE'),
	 (8,4,'04','QUININDE');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (8,5,'05','SAN LORENZO'),
	 (8,6,'06','ATACAMES'),
	 (8,7,'07','RIOVERDE'),
	 (9,1,'01','GUAYAQUIL'),
	 (9,2,'02','ALFREDO BAQUERIZO MORENO (JUJAN)'),
	 (9,3,'03','BALAO'),
	 (9,4,'04','BALZAR'),
	 (9,5,'05','COLIMES'),
	 (9,6,'06','DAULE'),
	 (9,7,'07','DURAN');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (9,8,'08','EL EMPALME'),
	 (9,9,'09','EL TRIUNFO'),
	 (9,10,'10','MILAGRO'),
	 (9,11,'11','NARANJAL'),
	 (9,12,'12','NARANJITO'),
	 (9,13,'13','PALESTINA'),
	 (9,14,'14','PEDRO CARBO'),
	 (9,16,'16','SAMBORONDON'),
	 (9,18,'18','SANTA LUCIA'),
	 (9,19,'19','SALITRE (URBINA JADO)');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (9,20,'20','SAN JACINTO DE YAGUACHI'),
	 (9,21,'21','PLAYAS'),
	 (9,22,'22','SIMON BOLIVAR'),
	 (9,23,'23','CORONEL MARCELINO MARIDUEÑA'),
	 (9,24,'24','LOMAS DE SARGENTILLO'),
	 (9,25,'25','NOBOL'),
	 (9,27,'27','GENERAL ANTONIO ELIZALDE (BUCAY)'),
	 (9,28,'28','ISIDRO AYORA'),
	 (10,1,'01','IBARRA'),
	 (10,2,'02','ANTONIO ANTE');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (10,3,'03','COTACACHI'),
	 (10,4,'04','OTAVALO'),
	 (10,5,'05','PIMAMPIRO'),
	 (10,6,'06','SAN MIGUEL DE URCUQUI'),
	 (11,1,'01','LOJA'),
	 (11,2,'02','CALVAS'),
	 (11,3,'03','CATAMAYO'),
	 (11,4,'04','CELICA'),
	 (11,5,'05','CHAGUARPAMBA'),
	 (11,6,'06','ESPINDOLA');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (11,7,'07','GONZANAMA'),
	 (11,8,'08','MACARA'),
	 (11,9,'09','PALTAS'),
	 (11,10,'10','PUYANGO'),
	 (11,11,'11','SARAGURO'),
	 (11,12,'12','SOZORANGA'),
	 (11,13,'13','ZAPOTILLO'),
	 (11,14,'14','PINDAL'),
	 (11,15,'15','QUILANGA'),
	 (11,16,'16','OLMEDO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (12,1,'01','BABAHOYO'),
	 (12,2,'02','BABA'),
	 (12,3,'03','MONTALVO'),
	 (12,4,'04','PUEBLO VIEJO'),
	 (12,5,'05','QUEVEDO'),
	 (12,6,'06','URDANETA'),
	 (12,7,'07','VENTANAS'),
	 (12,8,'08','VINCES'),
	 (12,9,'09','PALENQUE'),
	 (12,10,'10','BUENA FE');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (12,11,'11','VALENCIA'),
	 (12,12,'12','MOCACHE'),
	 (12,13,'13','QUINSALOMA'),
	 (13,1,'01','PORTOVIEJO'),
	 (13,2,'02','BOLIVAR'),
	 (13,3,'03','CHONE'),
	 (13,4,'04','EL CARMEN'),
	 (13,5,'05','FLAVIO ALFARO'),
	 (13,6,'06','JIPIJAPA'),
	 (13,7,'07','JUNIN');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (13,8,'08','MANTA'),
	 (13,9,'09','MONTECRISTI'),
	 (13,10,'10','PAJAN'),
	 (13,11,'11','PICHINCHA'),
	 (13,12,'12','ROCAFUERTE'),
	 (13,13,'13','SANTA ANA'),
	 (13,14,'14','SUCRE'),
	 (13,15,'15','TOSAGUA'),
	 (13,16,'16','24 DE MAYO'),
	 (13,17,'17','PEDERNALES');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (13,18,'18','OLMEDO'),
	 (13,19,'19','PUERTO LOPEZ'),
	 (13,20,'20','JAMA'),
	 (13,21,'21','JARAMIJO'),
	 (13,22,'22','SAN VICENTE'),
	 (14,1,'01','MORONA'),
	 (14,2,'02','GUALAQUIZA'),
	 (14,3,'03','LIMON INDANZA'),
	 (14,4,'04','PALORA'),
	 (14,5,'05','SANTIAGO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (14,6,'06','SUCUA'),
	 (14,7,'07','HUAMBOYA'),
	 (14,8,'08','SAN JUAN BOSCO'),
	 (14,9,'09','TAISHA'),
	 (14,10,'10','LOGROÑO'),
	 (14,11,'11','PABLO SEXTO'),
	 (14,12,'12','TIWINTZA'),
	 (15,1,'01','TENA'),
	 (15,3,'03','ARCHIDONA'),
	 (15,4,'04','EL CHACO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (15,7,'07','QUIJOS'),
	 (15,9,'09','CARLOS JULIO AROSEMENA TOLA'),
	 (16,1,'01','PASTAZA'),
	 (16,2,'02','MERA'),
	 (16,3,'03','SANTA CLARA'),
	 (16,4,'04','ARAJUNO'),
	 (17,1,'01','QUITO'),
	 (17,2,'02','CAYAMBE'),
	 (17,3,'03','MEJIA'),
	 (17,4,'04','PEDRO MONCAYO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (17,5,'05','RUMIÑAHUI'),
	 (17,7,'07','SAN MIGUEL DE LOS BANCOS'),
	 (17,8,'08','PEDRO VICENTE MALDONADO'),
	 (17,9,'09','PUERTO QUITO'),
	 (18,1,'01','AMBATO'),
	 (18,2,'02','BAÑOS DE AGUA SANTA'),
	 (18,3,'03','CEVALLOS'),
	 (18,4,'04','MOCHA'),
	 (18,5,'05','PATATE'),
	 (18,6,'06','QUERO');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (18,7,'07','SAN PEDRO DE PELILEO'),
	 (18,8,'08','SANTIAGO DE PILLARO'),
	 (18,9,'09','TISALEO'),
	 (19,1,'01','ZAMORA'),
	 (19,2,'02','CHINCHIPE'),
	 (19,3,'03','NANGARITZA'),
	 (19,4,'04','YACUAMBI'),
	 (19,5,'05','YANTZAZA'),
	 (19,6,'06','EL PANGUI'),
	 (19,7,'07','CENTINELA DEL CONDOR');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (19,8,'08','PALANDA'),
	 (19,9,'09','PAQUISHA'),
	 (20,1,'01','SAN CRISTOBAL'),
	 (20,2,'02','ISABELA'),
	 (20,3,'03','SANTA CRUZ'),
	 (21,1,'01','LAGO AGRIO'),
	 (21,2,'02','GONZALO PIZARRO'),
	 (21,3,'03','PUTUMAYO'),
	 (21,4,'04','SHUSHUFINDI'),
	 (21,5,'05','SUCUMBIOS');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (21,6,'06','CASCALES'),
	 (21,7,'07','CUYABENO'),
	 (22,1,'01','ORELLANA'),
	 (22,2,'02','AGUARICO'),
	 (22,3,'03','LA JOYA DE LOS SACHAS'),
	 (22,4,'04','LORETO'),
	 (23,1,'01','SANTO DOMINGO'),
	 (23,2,'02','LA CONCORDIA'),
	 (24,1,'01','SANTA ELENA'),
	 (24,2,'02','LA LIBERTAD');
INSERT INTO tbl_cantones (pro_codigo,can_codigo,can_auxcod,can_descri) VALUES
	 (24,3,'03','SALINAS');

create table tbl_act_economica(
aec_codigo smallint not null,
aec_auxcod varchar(15) not null,
aec_descri text not null,
aec_preg01 char(1) not null,
aec_vapr01 numeric(6,2) not null,
aec_preg02 char(1) not null,
aec_vapr02 numeric(6,2) not null,
aec_preg03 char(1) not null,
aec_vapr03 numeric(6,2) not null,
aec_preg04 char(1) not null,
aec_vapr04 numeric(6,2) not null,
aec_preg05 char(1) not null,
aec_vapr05 numeric(6,2) not null,
aec_total numeric(6,2) not null,
aec_ponder numeric(6,2) not null,
aec_nivrie char(1) not null,
unique(aec_auxcod)
);
alter table tbl_act_economica add constraint pk_acteco primary key (aec_codigo);
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1,'A','AGRICULTURA, GANADERÍA, SILVICULTURA Y PESCA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2,'A01','AGRICULTURA, GANADERÍA, CAZA Y ACTIVIDADES DE SERVICIOS CONEXAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (3,'A011','CULTIVO DE PLANTAS NO PERENNES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (4,'A0111','CULTIVO DE CEREALES (EXCEPTO ARROZ), LEGUMBRES Y SEMILLAS OLEAGINOSAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (5,'A01111','CULTIVO DE CEREALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (6,'A011111','CULTIVO DE TRIGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (7,'A011112','CULTIVO DE MAÍZ. (EXCEPTO MAÍZ SUAVE Y DURO)','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (8,'A011113','CULTIVO DE QUINUA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (9,'A011119','OTROS CULTIVOS DE CEREALES N.C.P.: SORGO, CEBADA, CENTENO, AVENA, MIJO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (10,'A01112','CULTIVO DE LEGUMBRES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (11,'A011121','CULTIVO DE FRÉJOL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (12,'A011122','CULTIVO DE ARVEJA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (13,'A011123','CULTIVO DE LENTEJA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (14,'A011129','OTROS CULTIVOS LE LEGUMBRES: HABAS, GARBANZOS, VAINITAS, CHOCHO (ALTRAMUCES), ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (15,'A01113','CULTIVO DE GRANOS Y SEMILLAS OLEAGINOSAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (16,'A011131','CULTIVO DE GRANOS Y SEMILLAS DE SOYA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (17,'A011132','CULTIVO DE SEMILLAS DE MANÍ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (18,'A011139','OTROS CULTIVOS DE SEMILLAS OLEAGINOSAS: SEMILLAS DE RICINO, SEMILLAS DE LINAZA, SEMILLAS DE MOSTAZA, SEMILLAS DE GIRASOL,  SEMILLAS DE AJONJOLÍ (SÉSAMO), SEMILLAS DE COLZA, SEMILLAS DE CÁRTAMO, SEMILLAS DE NÍGER, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (19,'A0112','CULTIVO DE ARROZ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (20,'A01120','CULTIVO DE ARROZ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (21,'A011200','CULTIVO DE ARROZ (INCLUIDO EL CULTIVO ORGÁNICO Y EL CULTIVO DE ARROZ GENÉTICAMENTE MODIFICADO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (22,'A0113','CULTIVO DE HORTALIZAS Y MELONES, RAÍCES Y TUBÉRCULOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (23,'A01131','CULTIVO DE HORTALIZAS DE HOJA O DE TALLO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (24,'A011311','CULTIVO DE BRÓCOLI, COL Y COLIFLOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (25,'A011312','CULTIVO DE ALCACHOFA Y ESPÁRRAGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (26,'A011319','OTROS CULTIVOS DE HORTALIZAS DE HOJA O DE TALLO, ESPINACA, LECHUGA, BERROS, APIO, PEREJIL, ACELGA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (27,'A01132','CULTIVO DE HORTALIZAS DE FRUTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (28,'A011321','CULTIVO DE TOMATES (EXCEPTO TOMATE DE ÁRBOL),  PEPINILLOS Y SIMILARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (29,'A011322','CULTIVO DE SANDÍAS, MELONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (30,'A011329','OTROS CULTIVOS DE HORTALIZAS DE FRUTO, ZAPALLO, SAMBO, ZUQUINI, BERENJENAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (31,'A01133','CULTIVO DE HORTALIZAS DE RAÍCES BULBOSAS O TUBEROSAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (32,'A011331','CULTIVO DE CEBOLLAS PAITEÑAS, CEBOLLAS PERLA, CEBOLLAS EN RAMA (PUERROS), AJOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (33,'A011332','CULTIVO DE ZANAHORIA AMARILLA, RÁBANO, REMOLACHA (BETERABA), (EXCEPTO LA REMOLACHA AZUCARERA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (34,'A011339','OTROS CULTIVOS DE HORTALIZAS DE RAÍCES BULBOSAS O TUBEROSAS: PAPANABO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (35,'A01134','CULTIVO TUBÉRCULOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (36,'A011341','CULTIVO DE PAPA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (37,'A011342','CULTIVO DE YUCA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (38,'A011349','OTROS CULTIVOS DE RAÍCES Y TUBÉRCULOS, CAMOTE (BATATA), MELLOCO, OCA, MASHUA, ZANAHORIA BLANCA, PAPA CHINA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (39,'A01139','CULTIVO DE OTRAS HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (40,'A011391','CULTIVO DE HONGOS (CHAMPIÑONES) Y TRUFAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (41,'A011392','CULTIVO DE SEMILLAS VEGETALES EXCEPTO SEMILLAS DE REMOLACHA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (42,'A011393','CULTIVO DE REMOLACHA AZUCARERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (43,'A011399','CULTIVO DE OTRAS HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (44,'A0114','CULTIVO DE CAÑA DE AZÚCAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (45,'A01140','CULTIVO DE CAÑA DE AZÚCAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (46,'A011400','CULTIVO DE CAÑA DE AZÚCAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (47,'A0115','CULTIVO DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (48,'A01150','CULTIVO DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (49,'A011500','CULTIVO DE TABACO EN BRUTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (50,'A0116','CULTIVO DE PLANTAS DE FIBRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (51,'A01160','CULTIVO DE PLANTAS DE FIBRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (52,'A011601','CULTIVO DE ALGODÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (53,'A011602','CULTIVO DE YUTE, KENAF Y OTRAS PLANTAS DE FIBRAS TEXTILES BLANDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (54,'A011603','CULTIVO DE LINO Y CÁÑAMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (55,'A011604','CULTIVO DE SISAL Y OTRAS PLANTAS DE FIBRAS TEXTILES DEL GÉNERO AGAVE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (56,'A011605','CULTIVO DE ABACÁ, RAMIO Y OTRAS PLANTAS DE FIBRAS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (57,'A011609','CULTIVO DE OTRAS PLANTAS DE FIBRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (58,'A0119','CULTIVO DE OTRAS PLANTAS NO PERENNES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (59,'A01190','CULTIVO DE OTRAS PLANTAS NO PERENNES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (60,'A011901','CULTIVO DE PLANTAS FORRAJERAS: NABOS FORRAJEROS, REMOLACHA FORRAJERA, RAÍCES FORRAJERAS, TRÉBOL, ALFALFA, ESPARCETA, MAÍZ FORRAJERO, KIKUYO, RAYGRÁS Y OTRAS PLANTAS FORRAJERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (61,'A011902','CULTIVO DE SEMILLAS DE REMOLACHA (EXCEPTUANDO LA REMOLACHA AZUCARERA) Y SEMILLAS DE PLANTAS FORRAJERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (62,'A011903','CULTIVO DE FLORES, INCLUIDA LA PRODUCCIÓN DE FLORES CORTADAS Y CAPULLOS.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'N',0.00,0.60,6.10,'M'),
	 (63,'A011904','PRODUCCIÓN DE SEMILLAS DE FLORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (64,'A012','CULTIVO DE PLANTAS PERENNES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (65,'A0121','CULTIVO DE UVAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (66,'A01210','CULTIVO DE UVAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (67,'A012100','CULTIVO DE UVAS PARA VINO Y UVAS PARA SER CONSUMIDAS COMO FRUTA FRESCA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (68,'A0122','CULTIVO DE FRUTAS TROPICALES Y SUBTROPICALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (69,'A01220','CULTIVO DE FRUTAS TROPICALES Y SUBTROPICALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (70,'A012201','CULTIVO DE BANANOS Y PLÁTANOS.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'N',0.00,0.60,6.10,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (71,'A012202','CULTIVO DE MANGOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (72,'A012203','CULTIVO DE MARACUYÁ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (73,'A012204','CULTIVO DE PIÑAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (74,'A012209','OTROS CULTIVOS DE FRUTAS TROPICALES Y SUBTROPICALES: PAPAYAS, BABACOS, CHAMBUROS, AGUACATES, HIGOS, ARAZÁ, GUAYABAS, GUANÁBANA, GUABA, CHIRIMOYA, NARANJILLAS, ZAPOTES, BOROJÓ, TAMARINDO, GRANADILLAS, DÁTILES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (75,'A0123','CULTIVO DE CÍTRICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (76,'A01230','CULTIVO DE CÍTRICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (77,'A012301','CULTIVO DE NARANJAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (78,'A012302','CULTIVO DE MANDARINAS, CLEMENTINAS Y TANGERINAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (79,'A012309','OTROS CULTIVOS DE CÍTRICOS, LIMONES, TORONJAS, LIMAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (80,'A0124','CULTIVO DE FRUTAS CON HUESO Y CON PEPA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (81,'A01240','CULTIVO DE FRUTAS CON HUESO Y CON PEPA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (82,'A012401','CULTIVO DE MANZANAS, PERAS Y MEMBRILLOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (83,'A012402','CULTIVO DE DURAZNOS (MELOCOTONES), ALBARICOQUES Y NECTARINAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (84,'A012409','OTROS CULTIVOS DE FRUTAS CON HUESO Y CON PEPA: CEREZAS, CIRUELAS, ENDRINAS, CAPULÍES, OVOS, CLAUDIAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (85,'A0125','CULTIVO DE OTROS FRUTOS Y NUECES DE ÁRBOLES Y ARBUSTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (86,'A01250','CULTIVO DE OTROS FRUTOS Y NUECES DE ÁRBOLES Y ARBUSTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (87,'A012501','CULTIVO DE BAYAS GROSELLAS, GROSELLAS ESPINOSAS, KIWIS, FRAMBUESAS, FRESAS (FRUTILLAS), MORAS, MORTIÑOS (ARÁNDANOS), UVILLA Y OTRAS BAYAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (88,'A012502','CULTIVO DE TOMATES DE ÁRBOL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (89,'A012503','PRODUCCIÓN DE SEMILLAS DE FRUTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (90,'A012504','CULTIVOS DE NUECES COMESTIBLES: ALMENDRAS, ANACARDOS, CASTAÑAS, AVELLANAS, PISTACHOS, NUECES DE NOGAL Y OTRAS NUECES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (91,'A012509','OTROS CULTIVOS DE FRUTOS DE ÁRBOLES Y ARBUSTOS: PITAHAYA, TUNA, ALGARROBA, TAXOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (92,'A0126','CULTIVO DE FRUTOS OLEAGINOSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (93,'A01260','CULTIVO DE FRUTOS OLEAGINOSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (94,'A012601','CULTIVO DE PALMAS DE ACEITE (PALMA AFRICANA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (95,'A012609','OTROS CULTIVOS DE FRUTOS OLEAGINOSOS: COCOS, ACEITUNAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (96,'A0127','CULTIVO DE PLANTAS CON LAS QUE SE PREPARAN BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (97,'A01270','CULTIVO DE PLANTAS CON LAS QUE SE PREPARAN BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (98,'A012701','CULTIVO DE CAFÉ.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'N',0.00,0.60,6.10,'M'),
	 (99,'A012702','CULTIVO DE CACAO.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'N',0.00,0.60,6.10,'M'),
	 (100,'A012709','OTROS CULTIVOS DE PLANTAS CON LAS QUE SE PREPARAN BEBIDAS: TÉ, MATE, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'N',0.00,0.60,6.10,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (101,'A0128','CULTIVO DE ESPECIAS Y DE PLANTAS AROMÁTICAS, MEDICINALES Y FARMACÉUTICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (102,'A01280','CULTIVO DE ESPECIAS Y DE PLANTAS AROMÁTICAS, MEDICINALES Y FARMACÉUTICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (103,'A012801','CULTIVO DE ESPECIAS DEL GÉNERO CAPSICUM: AJÍES, PIMIENTOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (104,'A012802','CULTIVO DE ESPECIAS PERENNES Y NO PERENNES: NUEZ MOSCADA, MACIS, CARDAMOMOS, ANÍS, BADIANA, HINOJO, PIMIENTA, CANELA, CLAVO, JENGIBRE, VAINILLA, LÚPULO, ESTRAGÓN, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (105,'A012803','CULTIVO DE PLANTAS MEDICINALES, NARCÓTICAS Y PLANTAS UTILIZADAS PRINCIPALMENTE EN PERFUMERÍA, PARA LA PREPARACIÓN DE INSECTICIDAS, FUNGICIDAS O PROPÓSITOS SIMILARES: ORTIGA, MENTA, BELLADONA, HIERBA LUISA, MANZANILLA, GUANTO, ORÉGANO, UÑA DE GATO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (106,'A0129','CULTIVO DE OTRAS PLANTAS PERENNES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (107,'A01290','CULTIVO DE OTRAS PLANTAS PERENNES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (108,'A012901','CULTIVO DE MATERIALES VEGETALES DE LOS TIPOS UTILIZADOS PRINCIPALMENTE PARA TRENZAR: PAJA TOQUILLA, TOTORA, BAMBÚ, MIMBRE, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (109,'A012902','CULTIVO DE PALMITO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (110,'A012909','OTROS CULTIVOS DE PLANTAS PERENNES: CULTIVO DE ÁRBOLES DE CAUCHO, LÁTEX, ÁRBOLES PARA LA EXTRACCIÓN DE SAVIA, ÁRBOLES DE NAVIDAD, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (111,'A013','PROPAGACIÓN DE PLANTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (112,'A0130','PROPAGACIÓN DE PLANTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (113,'A01300','PROPAGACIÓN DE PLANTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (114,'A013000','EXPLOTACIÓN DE VIVEROS (EXCEPTO VIVEROS FORESTALES), CULTIVO DE PLANTAS PARA: EL TRASPLANTE INCLUIDO CÉSPED PARA TRASPLANTE, PLANTAS CON FINES ORNAMENTALES, PLANTAS VIVAS PARA UTILIZAR SUS BULBOS, TUBÉRCULOS Y RAÍCES; ESQUEJES E INJERTOS; ESTACAS; ESPORAS DE HONGOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (115,'A014','GANADERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (116,'A0141','CRÍA DE GANADO BOVINO Y BÚFALOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (117,'A01410','CRÍA DE GANADO BOVINO Y BÚFALOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (118,'A014101','CRÍA Y REPRODUCCIÓN DE GANADO BOVINO INCLUIDO LA OBTENCIÓN DE PELO Y EXCREMENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (119,'A014102','PRODUCCIÓN DE LECHE CRUDA DE VACA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (120,'A014103','PRODUCCIÓN DE SEMEN Y EMBRIONES BOVINOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (121,'A014109','CRÍA Y REPRODUCCIÓN DE OTRO TIPO DE GANADO BOVINO: BÚFALOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (122,'A0142','CRÍA DE CABALLOS Y OTROS EQUINOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (123,'A01420','CRÍA DE CABALLOS Y OTROS EQUINOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (124,'A014201','CRÍA Y REPRODUCCIÓN DE CABALLOS (INCLUIDOS CABALLOS DE CARRERAS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (125,'A014202','CRÍA Y REPRODUCCIÓN DE ASNOS (BURROS), MULAS Y BURDÉGANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (126,'A0143','CRÍA DE CAMELLOS Y OTROS CAMÉLIDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (127,'A01430','CRÍA DE CAMELLOS Y OTROS CAMÉLIDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (128,'A014300','CRÍA Y REPRODUCCIÓN DE CAMÉLIDOS: ALPACA, LLAMA, VICUÑA, ETCÉTERA INCLUIDO LA OBTENCIÓN DE PELO Y EXCREMENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (129,'A0144','CRÍA DE OVEJAS Y CABRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (130,'A01440','CRÍA DE OVEJAS Y CABRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (131,'A014401','CRÍA Y REPRODUCCIÓN DE OVEJAS Y CABRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (132,'A014402','PRODUCCIÓN DE LECHE CRUDA DE OVEJA Y CABRA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (133,'A014403','PRODUCCIÓN DE LANA CRUDA Y PELO DE OVEJAS Y CABRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (134,'A014404','PRODUCCIÓN DE SEMEN Y EMBRIONES DE OVEJAS Y CABRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (135,'A0145','CRÍA DE CERDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (136,'A01450','CRÍA DE CERDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (137,'A014501','CRÍA Y REPRODUCCIÓN DE CERDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (138,'A014502','PRODUCCIÓN DE SEMEN Y EMBRIONES DE CERDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (139,'A0146','CRÍA DE AVES DE CORRAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (140,'A01460','CRÍA DE AVES DE CORRAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (141,'A014601','EXPLOTACIÓN DE CRIADEROS DE POLLOS Y REPRODUCCIÓN DE AVES DE CORRAL, POLLOS Y GALLINAS (AVES DE LA ESPECIE GALLUS DOMESTICUS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (142,'A014602','CRÍA Y REPRODUCCIÓN DE: CODORNICES, PATOS, GANSOS, PAVOS Y GALLINAS DE GUINEA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (143,'A014603','PRODUCCIÓN DE HUEVOS DE AVES DE CORRAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (144,'A0149','CRÍA DE OTROS ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (145,'A01491','CRÍA Y REPRODUCCIÓN DE AVES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (146,'A014910','CRÍA Y REPRODUCCIÓN DE AVESTRUCES, EMÚES, PALOMAS, TÓRTOLAS Y OTRAS AVES (EXCEPTO AVES DE CORRAL).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (147,'A01492','CRÍA Y REPRODUCCIÓN DE ANIMALES DE PELO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (148,'A014920','CRÍA Y REPRODUCCIÓN DE CONEJOS Y CUYES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (149,'A01493','CRÍA Y REPRODUCCIÓN DE OTROS ANIMALES SEMIDOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (150,'A014931','CRÍA Y REPRODUCCIÓN DE INSECTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (151,'A014932','CRÍA Y REPRODUCCIÓN DE REPTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (152,'A01499','CRÍA DE OTROS ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (153,'A014991','PRODUCCIÓN DE PIELES FINAS, CUEROS DE REPTILES Y PLUMAS DE AVES COMO PARTE DE LA EXPLOTACIÓN PECUARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (154,'A014992','EXPLOTACIÓN DE CRIADEROS DE GUSANOS (LOMBRICULTURA), MOLUSCOS TERRESTRES, CARACOLES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (155,'A014993','CRÍA DE GUSANOS DE SEDA, PRODUCCIÓN DE CAPULLOS DE GUSANOS DE SEDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (156,'A014994','APICULTURA Y PRODUCCIÓN DE CERA Y MIEL DE ABEJA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (157,'A014995','CRÍA Y REPRODUCCIÓN DE ANIMALES DOMÉSTICOS (EXCEPTO PECES): GATOS, PERROS, PÁJAROS, HÁMSTERS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (158,'A014996','CRÍA DE DIVERSOS ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (159,'A014997','OBTENCIÓN DE PELO Y EXCREMENTO DE OTROS ANIMALES, N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (160,'A015','CULTIVO DE PRODUCTOS AGRÍCOLAS EN COMBINACIÓN CON LA CRÍA DE ANIMALES (EXPLOTACIÓN MIXTA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (161,'A0150','CULTIVO DE PRODUCTOS AGRÍCOLAS EN COMBINACIÓN CON LA CRÍA DE ANIMALES (EXPLOTACIÓN MIXTA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (162,'A01500','EXPLOTACIÓN MIXTA (GRANJAS INTEGRALES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (163,'A015000','EXPLOTACIÓN MIXTA DE CULTIVOS Y ANIMALES SIN ESPECIALIZACIÓN EN NINGUNA DE LAS ACTIVIDADES. EL TAMAÑO DEL CONJUNTO DE LA EXPLOTACIÓN AGRÍCOLA NO ES UN FACTOR DETERMINANTE. SI EL CULTIVO DE PRODUCTOS AGRÍCOLAS O LA CRÍA DE ANIMALES REPRESENTAN EN UNA UNIDAD DETERMINADA UNA PROPORCIÓN IGUAL O SUPERIOR AL 66% DE LOS MÁRGENES BRUTOS CORRIENTES, LA ACTIVIDAD MIXTA NO DEBE CLASIFICARSE EN ESTA CLASE, SINO ENTRE LOS CULTIVOS O LAS ACTIVIDADES DE CRÍA DE ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (164,'A016','ACTIVIDADES DE APOYO A LA AGRICULTURA Y LA GANADERÍA Y ACTIVIDADES POSCOSECHA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (165,'A0161','ACTIVIDADES DE APOYO A LA AGRICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (166,'A01610','ACTIVIDADES AGRÍCOLAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (167,'A016101','ACTIVIDADES DE ACONDICIONAMIENTO Y MANTENIMIENTO DE TERRENOS PARA USOS AGRÍCOLAS: PLANTACIÓN O SIEMBRA DE CULTIVOS Y COSECHA, PODA DE ÁRBOLES FRUTALES Y VIÑAS, TRANSPLANTE DE ARROZ Y ENTRESACADO DE REMOLACHA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (168,'A016102','ACTIVIDADES DE FUMIGACIÓN DE CULTIVOS, INCLUIDA LA FUMIGACIÓN AÉREA; TRATAMIENTO DE CULTIVOS, CONTROL DE PLAGAS (INCLUIDOS LOS CONEJOS); EN RELACIÓN CON LA AGRICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (169,'A016103','SUMINISTRO DE MAQUINARIA AGRÍCOLA CON OPERADORES Y PERSONAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (170,'A016104','MANEJO DE SISTEMAS DE RIEGO CON FINES AGRÍCOLAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (171,'A0162','ACTIVIDADES DE APOYO A LA GANADERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (172,'A01620','ACTIVIDADES DE APOYO A LA GANADERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (173,'A016201','ACTIVIDADES PARA MEJORAR LA REPRODUCCIÓN, CRECIMIENTO Y RENDIMIENTO DE LOS ANIMALES RELACIONADAS CON LA INSEMINACIÓN ARTIFICIAL, SERVICIOS DE SEMENTALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (174,'A016202','SERVICIOS DE INSPECCIÓN SANITARIA, ARREO Y PASTURAJE DE GANADO, CAPADURA DE ANIMALES, LIMPIEZA DE GALLINEROS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (175,'A016209','OTRAS ACTIVIDADES DE APOYO A LA GANADERÍA: ACTIVIDADES DE ALBERGUE Y CUIDADO DE ANIMALES DE GRANJA, ESQUILA DE OVEJAS, HERRADORES, ETCÉTERA','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (176,'A0163','ACTIVIDADES POSCOSECHA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (177,'A01630','ACTIVIDADES POSCOSECHA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (178,'A016301','ACTIVIDADES DE PREPARACIÓN DE LA COSECHA PARA SU COMERCIALIZACIÓN EN LOS MERCADOS PRIMARIOS: LIMPIEZA, RECORTE, CLASIFICACIÓN, DESINFECCIÓN, EMPACADO POSCOSECHA, ENCERADO DE FRUTAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (179,'A016309','OTRAS ACTIVIDADES DE POSCOSECHA: DESMOTADO DE ALGODÓN, PREPARACIÓN DE HOJAS DE TABACO, PREPARACIÓN DE CACAO Y CAFÉ EN GRANO, SECADO AL SOL DE FRUTAS Y HORTALIZAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (180,'A0164','TRATAMIENTO DE SEMILLAS PARA PROPAGACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (181,'A01640','TRATAMIENTO DE SEMILLAS PARA PROPAGACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (182,'A016400','ACTIVIDADES POSCOSECHA DIRIGIDAS A MEJORAR LA CALIDAD DE LAS SEMILLAS PARA PROPAGACIÓN, A TRAVÉS DE LA ELIMINACIÓN DE LOS MATERIALES QUE NO SON SEMILLA, SEMILLAS DE TAMAÑO INFERIOR AL NORMAL, SEMILLAS DAÑADAS MECÁNICAMENTE O POR INSECTOS Y SEMILLAS INMADURAS, ASÍ COMO LA ELIMINACIÓN DE LA HUMEDAD DE LAS SEMILLAS HASTA UN NIVEL QUE PERMITA SU ALMACENAMIENTO SEGURO. ESTA ACTIVIDAD INCLUYE EL SECADO, LIMPIEZA, CLASIFICACIÓN Y TRATAMIENTO DE SEMILLAS HASTA SU COMERCIALIZACIÓN. SE INCLUYE ASI MISMO EL TRATAMIENTO DE SEMILLAS GENÉTICAMENTE MODIFICADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (183,'A017','CAZA ORDINARIA, MEDIANTE TRAMPAS Y ACTIVIDADES DE SERVICIOS CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (184,'A0170','CAZA ORDINARIA, MEDIANTE TRAMPAS Y ACTIVIDADES DE SERVICIOS CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (185,'A01700','CAZA ORDINARIA, MEDIANTE TRAMPAS Y ACTIVIDADES DE SERVICIOS CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (186,'A017001','ACTIVIDADES DE CAZA ORDINARIA Y MEDIANTE TRAMPAS PARA FINES COMERCIALES. CAPTURA DE ANIMALES (VIVOS O MUERTOS) PARA CARNE, PRODUCCIÓN DE PIELES INCLUSO PIELES FINAS, CUEROS (CUEROS DE REPTILES), PLUMAS PARA UTILIZARLOS EN LA INVESTIGACIÓN, EN ZOOLÓGICOS O COMO ANIMALES DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (187,'A017002','CAPTURA EN TIERRA DE MAMÍFEROS MARINOS, COMO FOCAS Y MORSAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (188,'A02','SILVICULTURA Y EXTRACCIÓN DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (189,'A021','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (190,'A0210','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (191,'A02100','SILVICULTURA Y OTRAS ACTIVIDADES FORESTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (192,'A021001','EXPLOTACIÓN DE VIVEROS FORESTALES Y MADERA EN PIE : PLANTACIÓN, REPLANTE, TRANSPLANTE, ACLAREO Y CONSERVACIÓN DE BOSQUES Y ZONAS FORESTADAS (ESTAS ACTIVIDADES PUEDEN SER LLEVADAS A CABO EN BOSQUES NATURALES O EN PLANTACIONES FORESTALES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (193,'A021002','CULTIVO DE MONTE BAJO (ARBUSTOS), MADERA PARA PASTA Y PARA LEÑA (ESTA ACTIVIDAD PUEDE SER LLEVADA A CABO EN BOSQUES NATURALES O EN PLANTACIONES FORESTALES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (194,'A022','EXTRACCIÓN DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (195,'A0220','EXTRACCIÓN DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (196,'A02200','EXTRACCIÓN DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (197,'A022001','PRODUCCIÓN DE MADERA EN BRUTO (ROLLOS) PARA LAS INDUSTRIAS MANUFACTURERAS QUE UTILIZAN PRODUCTOS FORESTALES, CHONTA, BALSA, CIPRÉS, PINO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (198,'A022002','PRODUCCIÓN DE MADERA EN BRUTO (ROLLOS) UTILIZADA EN FORMA NO PROCESADA COMO PUNTALES, ESTACAS, CERCAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (199,'A022003','ACTIVIDADES DE RECOLECCIÓN Y PRODUCCIÓN DE LEÑA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (200,'A023','RECOLECCIÓN DE PRODUCTOS FORESTALES DISTINTOS DE LA MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (201,'A0230','RECOLECCIÓN DE PRODUCTOS FORESTALES DISTINTOS DE LA MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (202,'A02300','RECOLECCIÓN DE PRODUCTOS FORESTALES DISTINTOS DE LA MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (203,'A023000','RECOLECCIÓN DE MATERIALES SILVESTRES: HONGOS, TRUFAS, BAYAS, NUECES, BALATA Y OTRAS GOMAS SIMILARES AL CAUCHO, CORCHO, GOMA LACA Y RESINAS, BÁLSAMOS, CRIN VEGETAL, CRIN MARINA (ZOSTERA), BELLOTAS Y CASTAÑAS DE INDIAS, MUSGOS Y LÍQUENES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (204,'A024','SERVICIOS DE APOYO A LA SILVICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (205,'A0240','SERVICIOS DE APOYO A LA SILVICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (206,'A02400','ACTIVIDADES DE SERVICIOS FORESTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (207,'A024001','ACTIVIDADES DE INVENTARIOS FORESTALES Y EVALUACIÓN DE EXISTENCIAS MADERABLES, LUCHA CONTRA PLAGAS FORESTALES Y SERVICIOS DE CONSULTORÍA DE GESTIÓN FORESTAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (208,'A024002','ACTIVIDADES DE EXTINCIÓN Y PREVENCIÓN DE INCENDIOS FORESTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (209,'A024003','TRANSPORTE DE TRONCOS DENTRO DEL BOSQUE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (210,'A03','PESCA Y ACUICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (211,'A031','PESCA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (212,'A0311','PESCA MARINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (213,'A03110','PESCA MARINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (214,'A031101','ACTIVIDADES DE PESCA DE ALTURA Y COSTERA: EXTRACCIÓN DE PECES, CRUSTÁCEOS Y MOLUSCOS MARINOS, TORTUGAS, ERIZOS DE MAR, ASCIDIAS Y OTROS TUNICADOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (215,'A031102','ACTIVIDADES DE CAPTURA DE BALLENAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (216,'A031103','ACTIVIDADES DE BUQUES DEDICADOS TANTO A LA PESCA MARINA COMO A LA PREPARACIÓN Y CONSERVACIÓN DE PESCADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (217,'A031109','RECOLECCIÓN DE OTROS MATERIALES Y ORGANISMOS MARINOS: PERLAS NATURALES, ESPONJAS, CORALES Y ALGAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (218,'A0312','PESCA DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (219,'A03120','PESCA DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (220,'A031201','PESCA EN AGUAS INTERIORES, EXTRACCIÓN DE PECES, CRUSTÁCEOS Y MOLUSCOS DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (221,'A031202','RECOLECCIÓN DE MATERIALES DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (222,'A032','ACUICULTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (223,'A0321','ACUICULTURA MARINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (224,'A03210','ACUICULTURA MARINA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (225,'A032101','ACTIVIDADES DE ACUICULTURA EN AGUA DEL MAR O EN TANQUES DE AGUA SALADA: CRÍA DE PECES INCLUIDO LA CRIA DE PECES ORNAMENTALES MARINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (226,'A032102','EXPLOTACIÓN DE CRIADEROS DE CAMARONES (CAMARONERAS), CRIADEROS DE LARVAS  DE CAMARÓN (LABORATORIOS DE LARVAS DE CAMARÓN).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (227,'A032103','PRODUCCIÓN DE LARVAS DE BIVALVOS (OSTRAS, MEJILLONES, ETCÉTERA) Y DE OTROS MOLUSCOS, CRÍAS DE BOGAVANTE, ALEVINES Y JARAMUGOS, CRÍA DE CRUSTÁCEOS (LANGOSTAS Y LANGOSTINOS) Y OTROS ANIMALES ACUÁTICOS EN AGUA DE MAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (228,'A032104','ACTIVIDADES DE CULTIVO DE PERLAS, LAVER Y OTRAS ALGAS COMESTIBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (229,'A0322','ACUICULTURA DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (230,'A03220','ACUICULTURA DE AGUA DULCE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (231,'A032201','CRÍA Y EXPLOTACIÓN DE CRIADEROS DE PECES (DE AGUA DULCE) INCLUIDO PECES ORNAMENTALES, TRUCHAS, TILAPIAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (232,'A032202','CRÍA DE CRUSTÁCEOS, BIVALVOS, MOLUSCOS Y OTROS ANIMALES ACUÁTICOS DE AGUA DULCE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (233,'A032203','CRÍA DE RANAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (234,'B','EXPLOTACIÓN DE MINAS Y CANTERAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (235,'B05','EXTRACCIÓN DE CARBÓN DE PIEDRA Y LIGNITO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (236,'B051','EXTRACCIÓN DE CARBÓN DE PIEDRA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (237,'B0510','EXTRACCIÓN DE CARBÓN DE PIEDRA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (238,'B05100','EXTRACCIÓN DE CARBÓN DE PIEDRA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (239,'B051000','ACTIVIDADES DE EXTRACCIÓN DE CARBÓN DE PIEDRA EN MINAS, INCLUYENDO LA EXTRACCIÓN A TRAVÉS DE MÉTODOS DE LICUEFACCIÓN, RECUPERACIÓN DE CARBÓN DE PIEDRA DE ESCOMBRERAS, LIMPIEZA, CRIBADO, CLASIFICACIÓN, PULVERIZACIÓN, COMPRESIÓN, ETCÉTERA; DEL CARBÓN PARA CLASIFICARLO, MEJORAR SU CALIDAD O FACILITAR SU TRANSPORTE O ALMACENAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (240,'B052','EXTRACCIÓN DE LIGNITO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (241,'B0520','EXTRACCIÓN DE LIGNITO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (242,'B05200','EXTRACCIÓN DE LIGNITO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (243,'B052000','EXTRACCIÓN DE LIGNITO (CARBÓN PARDO) EN MINAS, INCLUYENDO LA EXTRACCIÓN A TRAVÉS DE MÉTODOS DE LICUEFACCIÓN, ACTIVIDADES DE LIMPIEZA, DESHIDRATACIÓN, PULVERIZACIÓN, COMPRESIÓN, ETCÉTERA; DE LIGNITO PARA MEJORAR SU CALIDAD O FACILITAR SU TRANSPORTE O ALMACENAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (244,'B06','EXTRACCIÓN DE PETRÓLEO CRUDO Y GAS NATURAL.','N',0.00,'N',0.00,'N',0.00,'S',0.02,'S',0.08,0.10,1.00,'B'),
	 (245,'B061','EXTRACCIÓN DE PETRÓLEO CRUDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (246,'B0610','EXTRACCIÓN DE PETRÓLEO CRUDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (247,'B06100','EXTRACCIÓN DE PETRÓLEO CRUDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (248,'B061000','EXTRACCIÓN DE ACEITES CRUDOS DE PETRÓLEO, ESQUISTOS BITUMINOSOS Y ARENAS ALQUITRANADAS, PRODUCCIÓN DE PETRÓLEO CRUDO DE ESQUISTOS Y ARENAS BITUMINOSAS, PROCESOS DE OBTENCIÓN DE CRUDOS: DECANTACIÓN, DESALADO, DESHIDRATACIÓN, ESTABILIZACIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (249,'B062','EXTRACCIÓN DE GAS NATURAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (250,'B0620','EXTRACCIÓN DE GAS NATURAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (251,'B06200','EXTRACCIÓN DE GAS NATURAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (252,'B062001','PRODUCCIÓN DE HIDROCARBUROS CRUDOS EN ESTADO GASEOSO (GAS NATURAL), EXTRACCIÓN DE CONDENSADOS, DRENAJE Y SEPARACIÓN DE LAS FRACCIONES LÍQUIDAS, DESULFURIZACIÓN DE GAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (253,'B062002','EXTRACCIÓN DE HIDROCARBUROS LÍQUIDOS, OBTENIDOS A TRAVÉS DE LICUEFACCIÓN O PIROLISIS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (254,'B07','EXTRACCIÓN DE MINERALES METALÍFEROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (255,'B071','EXTRACCIÓN DE MINERALES DE HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (256,'B0710','EXTRACCIÓN DE MINERALES DE HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (257,'B07100','EXTRACCIÓN DE MINERALES DE HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (258,'B071001','EXTRACCIÓN DE MINERALES ESTIMADOS PRINCIPALMENTE POR SU CONTENIDO EN HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (259,'B071002','BENEFICIO Y AGLOMERACIÓN DE MINERALES DE HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (260,'B072','EXTRACCIÓN DE MINERALES METALÍFEROS NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (261,'B0721','EXTRACCIÓN DE MINERALES DE URANIO Y TORIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (262,'B07210','EXTRACCIÓN DE MINERALES DE URANIO Y TORIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (263,'B072100','EXTRACCIÓN DE MINERALES ESTIMADOS PRINCIPALMENTE POR SU CONTENIDO DE URANIO Y TORIO: PECBLENDA, ÓXIDO NATURAL DE URANIO, ETCÉTERA; CONCENTRACIÓN DE URANIO Y TORIO, PRODUCCIÓN DE TORTA AMARILLA (CONCENTRADO DE URANIO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (264,'B0729','EXTRACCIÓN DE OTROS MINERALES METALÍFEROS NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (265,'B07290','EXTRACCIÓN DE OTROS MINERALES METALÍFEROS NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (266,'B072901','EXTRACCIÓN Y PREPARACIÓN DE MINERALES ESTIMADOS PRINCIPALMENTE POR SU CONTENIDO DE METALES NO FERROSOS: ALUMINIO (BAUXITA), COBRE, PLOMO, ZINC, ESTAÑO, MANGANESO, CROMO, NÍQUEL, COBALTO, MOLIBDENO, TÁNTALO, VANADIO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (267,'B072902','EXTRACCIÓN DE METALES PRECIOSOS: ORO, PLATA, PLATINO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (268,'B08','EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (269,'B081','EXTRACCIÓN DE PIEDRA, ARENA Y ARCILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (270,'B0810','EXTRACCIÓN DE PIEDRA, ARENA Y ARCILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (271,'B08101','EXTRACCIÓN DE PIEDRA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (272,'B081011','EXTRACCIÓN, TALLA SIN LABRAR Y ASERRADO DE PIEDRA DE CONSTRUCCIÓN, COMO MÁRMOL, GRANITO, ARENISCA, PIZARRA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (273,'B081012','EXTRACCIÓN, TRITURACIÓN Y FRAGMENTACIÓN DE PIEDRA CALIZA, PARA UTILIZARLA EN LA FABRICACIÓN DE CAL O CEMENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (274,'B081013','EXTRACCIÓN DE YESO Y ANHIDRITA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (275,'B081014','EXTRACCIÓN DE CRETA Y DOLOMITA SIN CALCINAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (276,'B08102','EXTRACCIÓN DE ARENA Y ARCILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (277,'B081021','EXTRACCIÓN Y DRAGADO DE ARENAS PARA LA INDUSTRIA, ARENAS PARA LA CONSTRUCCIÓN, GRAVA (RIPIO) Y GRAVILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (278,'B081022','FRAGMENTACIÓN Y TRITURACIÓN DE PIEDRA, GRAVA (RIPIO), GRAVILLA Y ARENA, PARA LA CONSTRUCCIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (279,'B081023','EXTRACCIÓN DE ARCILLAS, ARCILLAS REFRACTARIAS Y CAOLÍN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (280,'B089','EXPLOTACIÓN DE MINAS Y CANTERAS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (281,'B0891','EXTRACCIÓN DE MINERALES PARA LA FABRICACIÓN DE ABONOS Y PRODUCTOS QUÍMICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (282,'B08910','EXTRACCIÓN DE MINERALES PARA LA FABRICACIÓN DE ABONOS Y PRODUCTOS QUÍMICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (283,'B089101','EXTRACCIÓN DE FOSFATOS Y SALES DE POTASIO NATURALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (284,'B089102','EXTRACCIÓN DE AZUFRE NATURAL (NATIVO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (285,'B089103','EXTRACCIÓN Y PREPARACIÓN DE PIRITA Y PIRROTINA, EXCEPTO EL TOSTADO DE PIRITA Y PIRROTINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (286,'B089104','EXTRACCIÓN DE SULFATO Y CARBONATO DE BARIO NATURALES (BARITINA Y WITHERITA), BORATOS NATURALES, SULFATOS DE MAGNESIO NATURALES (KIESERITA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (287,'B089105','EXTRACCIÓN DE TIERRAS COLORANTES, ESPATOFLÚOR Y OTROS MINERALES ESTIMADOS PRINCIPALMENTE COMO FUENTE DE SUSTANCIAS QUÍMICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (288,'B089106','EXTRACCIÓN DE GUANO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (289,'B0892','EXTRACCIÓN DE TURBA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (290,'B08920','EXTRACCIÓN DE TURBA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (291,'B089200','EXTRACCIÓN, AGLOMERACIÓN, PREPARACIÓN DE TURBA PARA MEJORAR SU CALIDAD, FACILITAR SU TRANSPORTE O ALMACENAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (292,'B0893','EXTRACCIÓN DE SAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (293,'B08930','EXTRACCIÓN DE SAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (294,'B089301','EXTRACCIÓN DE SAL EN YACIMIENTOS SUBTERRÁNEOS, INCLUSO MEDIANTE DISOLUCIÓN Y BOMBEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (295,'B089302','PRODUCCIÓN DE SAL MEDIANTE EVAPORACIÓN AL SOL DE AGUA DE MAR Y OTRAS AGUAS SALINAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (296,'B089303','TRITURACIÓN, PURIFICACIÓN Y REFINADO DE LA SAL POR EL PRODUCTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (297,'B0899','EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (298,'B08990','EXPLOTACIÓN DE VARIOS MINERALES Y MATERIALES DE MINAS Y CANTERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (299,'B089901','EXTRACCIÓN DE BITUMEN NATURAL SÓLIDO, ASFALTO NATURAL, ASFALTITAS Y ROCA ASFÁLTICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (300,'B089902','EXTRACCIÓN DE PIEDRAS PRECIOSAS Y SEMIPRECIOSAS, GEMAS, MICA, CUARZO, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (301,'B089903','EXTRACCIÓN DE MATERIALES ABRASIVOS: GRAFITO NATURAL, PIEDRA PÓMEZ, FELDESPATOS, ESMERIL, CORINDÓN, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (302,'B089909','EXTRACCIÓN DE OTROS MINERALES: ASBESTO, POLVO DE FÓSILES SILÍCEOS, ESTEATITA (TALCO), VERMICULITA, PEOLITA, CLORITA, ANTIMONIO, MAGNESITA, SILICATO DE MAGNESIO (POLVO), SILICIO, ETCÉTERA','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (303,'B09','ACTIVIDADES DE SERVICIOS DE APOYO PARA LA EXPLOTACIÓN DE MINAS Y CANTERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (304,'B091','ACTIVIDADES DE APOYO PARA LA EXTRACCIÓN DE PETRÓLEO Y GAS NATURAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (305,'B0910','ACTIVIDADES DE APOYO PARA LA EXTRACCIÓN DE PETRÓLEO Y GAS NATURAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (306,'B09100','ACTIVIDADES DE APOYO PARA LA EXTRACCIÓN DE PETRÓLEO Y GAS NATURAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (307,'B091001','ACTIVIDADES DE SERVICIOS DE EXTRACCIÓN DE PETRÓLEO Y GAS REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: SONDEOS, EXPLORACIÓN (POR EJEMPLO: MÉTODOS TRADICIONALES DE PROSPECCIÓN, COMO OBSERVACIONES GEOLÓGICAS EN POSIBLES YACIMIENTOS); PERFORACIÓN DIRIGIDA Y REPERFORACIÓN; PERFORACIÓN INICIAL; ERECCIÓN, REPARACIÓN Y DESMANTELAMIENTO DE TORRES DE PERFORACIÓN, CEMENTACIÓN DE TUBOS DE ENCAMISADO DE LOS POZOS DE PETRÓLEO Y GAS, BOMBEO, TAPONAMIENTO Y ABANDONO DE POZOS, ETCÉTERA; LICUEFACCIÓN Y REGASIFICACIÓN DE GAS NATURAL PARA SU TRANSPORTE, REALIZADAS EN EL LUGAR DE EXTRACCIÓN; DRENAJE Y BOMBEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (308,'B091002','SERVICIOS DE PREVENCIÓN Y EXTINCIÓN DE INCENDIOS EN CAMPOS DE PETRÓLEO Y GAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (309,'B099','ACTIVIDADES DE APOYO PARA LA EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (310,'B0990','ACTIVIDADES DE APOYO PARA LA EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (311,'B09900','SERVICIOS DE APOYO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, REQUERIDAS PARA LA EXTRACCIÓN DE CARBÓN DE PIEDRA, LIGNITO, MINERALES METALÍFEROS Y OTRAS MINAS Y CANTERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (312,'B099001','SERVICIOS DE APOYO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, REQUERIDAS PARA LA EXTRACCIÓN DE CARBÓN DE PIEDRA, LIGNITO Y TURBA: EXPLORACIÓN (POR EJEMPLO: MÉTODOS DE PROSPECCIÓN TRADICIONALES, COMO RECOGIDA DE MUESTRAS Y REALIZACIÓN DE OBSERVACIONES GEOLÓGICAS EN POSIBLES YACIMIENTOS); PERFORACIONES DE PRUEBA Y SONDEOS; DRENAJE Y BOMBEO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (313,'B099002','SERVICIOS DE APOYO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, REQUERIDAS PARA LA EXTRACCIÓN DE MINERALES METALÍFEROS: PERFORACIONES DE PRUEBA Y SONDEOS, EXPLORACIÓN (POR EJEMPLO: MÉTODOS DE PROSPECCIÓN TRADICIONALES, COMO RECOGIDA DE MUESTRAS Y REALIZACIÓN DE OBSERVACIONES GEOLÓGICAS EN POSIBLES YACIMIENTOS; DRENAJE Y BOMBEO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (314,'B099009','SERVICIOS DE APOYO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, REQUERIDAS PARA LA EXPLOTACIÓN DE OTRAS MINAS Y CANTERAS: PERFORACIONES DE PRUEBA Y SONDEOS, EXPLORACIÓN (POR EJEMPLO: MÉTODOS DE PROSPECCIÓN TRADICIONALES, COMO RECOGIDA DE MUESTRAS Y REALIZACIÓN DE OBSERVACIONES GEOLÓGICAS EN POSIBLES YACIMIENTOS); DRENAJE Y BOMBEO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (315,'C','INDUSTRIAS MANUFACTURERAS.','N',0.00,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.68,7.00,'M'),
	 (316,'C10','ELABORACIÓN DE PRODUCTOS ALIMENTICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (317,'C101','ELABORACIÓN Y CONSERVACIÓN DE CARNE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (318,'C1010','ELABORACIÓN Y CONSERVACIÓN DE CARNE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (319,'C10101','ELABORACIÓN Y CONSERVACIÓN DE CARNE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (320,'C101011','EXPLOTACIÓN DE MATADEROS QUE REALIZAN ACTIVIDADES DE SACRIFICIO, FAENAMIENTO, PREPARACIÓN, PRODUCCIÓN Y EMPACADO DE CARNE FRESCA REFRIGERADA O CONGELADA EN CANALES O PIEZAS O PORCIONES INDIVIDUALES DE: BOVINO, PORCINO, OVINO, CAPRINO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (321,'C101012','EXPLOTACIÓN DE MATADEROS QUE REALIZAN ACTIVIDADES DE SACRIFICIO, FAENAMIENTO, PREPARACIÓN, PRODUCCIÓN Y EMPACADO DE CARNE FRESCA REFRIGERADA O CONGELADA INCLUSO EN PIEZAS O PORCIONES INDIVIDUALES DE AVES DE CORRAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (322,'C101013','ACTIVIDADES DE SACRIFICIO, FAENAMIENTO, PREPARACIÓN, PRODUCCIÓN Y EMPACADO DE CARNE FRESCA REFRIGERADA O CONGELADA INCLUSO EN PIEZAS O PORCIONES INDIVIDUALES DE: CUYES, CONEJOS, RANA (ANCAS DE RANA) ETCÉTERA,','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (323,'C101014','CAPTURA, SACRIFICIO Y PROCESAMIENTO DE BALLENAS EN TIERRA O SOBRE EMBARCACIONES ESPECIALIZADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (324,'C10102','CONSERVACIÓN DE CARNES Y ELABORACIÓN DE PRODUCTOS CÁRNICOS Y OTROS PRODUCTOS DE LA MATANZA DE ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (325,'C101021','PREPARACIÓN Y CONSERVACIÓN DE CARNE MEDIANTE: DESECACIÓN, SALADURA, AHUMADO, ENLATADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (326,'C101022','FABRICACIÓN DE PRODUCTOS CÁRNICOS: SALCHICHAS, SALCHICHÓN, CHORIZO, SALAME, MORCILLAS, MORTADELA, PATÉS, CHICHARRONES FINOS, JAMONES, EMBUTIDOS, ETCÉTERA. INCLUSO SNACKS DE CERDO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (327,'C101023','PRODUCCIÓN DE CUEROS Y PIELES ORIGINADOS EN MATADEROS INCLUIDA PIELES DEPILADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (328,'C101024','EXTRACCIÓN DE MANTECA DE CERDO Y OTRAS GRASAS COMESTIBLES DE ORIGEN ANIMAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (329,'C101025','OBTENCIÓN DE DESPOJOS DE ANIMALES, LANA DE MATADERO, PELO ORDINARIO, PLUMAS (PLUMÓN) Y PELUSAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (330,'C101026','PRODUCCIÓN DE HARINAS O SÉMOLAS DE CARNE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (331,'C10103','SERVICIOS DE APOYO A LA ELABORACIÓN Y CONSERVACIÓN DE CARNE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (332,'C101030','SERVICIOS DE APOYO A LA ELABORACIÓN Y CONSERVACIÓN DE CARNE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (333,'C102','ELABORACIÓN Y CONSERVACIÓN DE PESCADOS, CRUSTÁCEOS Y MOLUSCOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (334,'C1020','ELABORACIÓN Y CONSERVACIÓN DE PESCADOS, CRUSTÁCEOS Y MOLUSCOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (335,'C10200','ELABORACIÓN Y CONSERVACIÓN DE PESCADOS, CRUSTÁCEOS Y MOLUSCOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (336,'C102001','PREPARACIÓN Y CONSERVACIÓN DE CAMARÓN Y LANGOSTINOS MEDIANTE EL CONGELADO, ULTRACONGELADO SECADO, AHUMADO, SALADO, SUMERGIDO EN SALMUERA Y ENLATADO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (337,'C102002','PREPARACIÓN Y CONSERVACIÓN DE PESCADO, CRUSTÁCEOS (EXCEPTO CAMARÓN Y LANGOSTINOS) Y OTROS MOLUSCOS MEDIANTE EL CONGELADO, ULTRACONGELADO, SECADO, AHUMADO, SALADO, SUMERGIDO EN SALMUERA Y ENLATADO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (338,'C102003','ELABORACIÓN DE PRODUCTOS DE CAMARÓN Y LANGOSTINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (339,'C102004','ELABORACIÓN DE PRODUCTOS DE PESCADO: COCINADO, FILETES DE PESCADO, HUEVOS DE PESCADO, CAVIAR Y SUSTITUTOS DEL CAVIAR, ETCÉTERA. ELABORACIÓN DE PRODUCTOS DE CRUSTÁCEOS (EXCEPTO CAMARÓN Y LANGOSTINOS) Y OTROS MOLUSCOS MEDIANTE EL SECADO, SALAZÓN, CONSERVACIÓN EN SALMUERA, ENLATADOS, AHUMADO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (340,'C102005','ELABORACIÓN DE HARINA DE PESCADO PARA CONSUMO HUMANO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (341,'C102006','ELABORACIÓN DE HARINA Y SOLUBLES DE PESCADO Y OTROS ANIMALES ACUÁTICOS PARA ALIMENTO DE ANIMALES, NO APTOS PARA EL CONSUMO HUMANO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (342,'C102007','ACTIVIDADES DE BUQUES-FACTORÍA QUE SE DEDICAN A LA PESCA Y A LA CONSERVACIÓN DE PESCADO, CRUSTÁCEOS Y MOLUSCOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (343,'C102008','ELABORACIÓN DE PRODUCTOS DE ALGAS Y OTROS RECURSOS MARINOS, MEDIANTE EL SECADO, SALAZÓN, CONSERVACIÓN EN SALMUERA, ENLATADOS, AHUMADO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (344,'C102009','SERVICIOS DE APOYO A LA ELABORACIÓN Y CONSERVACIÓN DE PESCADOS, CRUSTÁCEOS Y MOLUSCOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (345,'C103','ELABORACIÓN Y CONSERVACIÓN DE FRUTAS, LEGUMBRES Y HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (346,'C1030','ELABORACIÓN Y CONSERVACIÓN DE FRUTAS, LEGUMBRES Y HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (347,'C10301','ELABORACIÓN Y CONSERVACIÓN DE FRUTAS, LEGUMBRES Y HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (348,'C103011','ELABORACIÓN DE ALIMENTOS COMPUESTOS (MEZCLA) PRINCIPALMENTE DE FRUTAS LEGUMBRES U HORTALIZAS, EXCEPTO PLATOS PREPARADOS EN FORMA CONGELADA O ENLATADA LISTOS PARA CONSUMIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (349,'C103012','CONSERVACIÓN DE FRUTAS, PULPA DE FRUTAS, LEGUMBRES Y HORTALIZAS MEDIANTE EL CONGELADO, SECADO, DESHIDRATADO, INMERSIÓN EN ACEITE O VINAGRE, ENLATADO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (350,'C103013','CONSERVACIÓN DE NUECES (PASTA DE NUECES) Y OTROS FRUTOS SECOS MEDIANTE EL TOSTADO, SALADO, ASADO, ENLATADO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (351,'C103014','FABRICACIÓN DE PRODUCTOS ALIMENTICIOS A PARTIR DE (UN SOLO COMPONENTE) FRUTAS, LEGUMBRES Y HORTALIZAS; INCLUSO SNACKS DE PLÁTANO (CHIFLES), YUCA, FRUTAS, ETCÉTERA, EXCEPTO PAPA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (352,'C103015','ELABORACIÓN DE JUGOS (ZUMOS), NÉCTARES, CONCENTRADOS DE FRUTA FRESCA Y HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (353,'C103016','ELABORACIÓN DE COMPOTAS, MERMELADAS Y JALEAS, PURÉS Y OTRAS CONFITURAS DE FRUTAS O FRUTOS SECOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (354,'C103017','FABRICACIÓN DE ALIMENTOS PERECIBLES A BASE DE FRUTAS, LEGUMBRES Y HORTALIZAS COMO: ENSALADAS EMPAQUETADAS, HORTALIZAS PELADAS Y CORTADAS, TOFU (CUAJADA DE SOYA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (355,'C10302','ELABORACIÓN Y CONSERVACIÓN DE PAPAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (356,'C103021','ELABORACIÓN Y CONSERVACIÓN DE PAPAS PREPARADAS CONGELADAS U OTRO TIPO DE CONSERVACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (357,'C103022','ELABORACIÓN DE PURÉ DE PAPAS DESHIDRATADO, HARINA Y SÉMOLA DE PAPA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (358,'C103023','ELABORACIÓN DE PAPAS FRITAS Y SNACKS DE PAPAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (359,'C10303','SERVICIOS DE APOYO A LA ELABORACIÓN Y CONSERVACIÓN DE FRUTAS, LEGUMBRES Y HORTALIZAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (360,'C103030','SERVICIOS DE APOYO A LA ELABORACIÓN Y CONSERVACIÓN DE FRUTAS, LEGUMBRES Y HORTALIZAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: PELADO INDUSTRIAL DE PAPAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (361,'C104','ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN VEGETAL Y ANIMAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (362,'C1040','ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN VEGETAL Y ANIMAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (363,'C10401','ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN VEGETAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (364,'C104011','ELABORACIÓN DE ACEITES CRUDOS VEGETALES (SIN REFINAR) DE: OLIVA, SOYA, PALMA, SEMILLA DE GIRASOL, SEMILLA DE ALGODÓN, COLZA, REPOLLO O MOSTAZA, LINAZA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (365,'C104012','ELABORACIÓN DE HARINA Y SÉMOLA SIN DESGRASAR DE SEMILLAS, NUECES Y ALMENDRAS OLEAGINOSAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (366,'C104013','ELABORACIÓN DE ACEITES VEGETALES REFINADOS: ACEITE DE OLIVA, ACEITE DE SOYA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (367,'C104014','ELABORACIÓN DE ACEITES VEGETALES: OXIDACIÓN POR CORRIENTE DE AIRE, COCCIÓN, DESHIDRATACIÓN, HIDROGENACIÓN, ETCÉTERA; MEZCLAS DE ACEITES DE OLIVA, GRASAS COMPUESTAS PARA COCINAR Y PRODUCTOS SIMILARES PARA UNTAR: MARGARINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (368,'C104015','PRODUCCIÓN DE BORRAS DE ALGODÓN, TORTAS Y OTROS PRODUCTOS RESIDUALES DE LA PRODUCCIÓN DE ACEITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (369,'C10402','ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN ANIMAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (370,'C104021','ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN ANIMAL NO COMESTIBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (371,'C104022','EXTRACCIÓN DE ACEITES DE PESCADO (HÍGADO DE PESCADO) Y MAMÍFEROS MARINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (372,'C10403','SERVICIOS DE APOYO A LA ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN VEGETAL Y ANIMAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (373,'C104030','SERVICIOS DE APOYO A LA ELABORACIÓN DE ACEITES Y GRASAS DE ORIGEN VEGETAL Y ANIMAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (374,'C105','ELABORACIÓN DE PRODUCTOS LÁCTEOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (375,'C1050','ELABORACIÓN DE PRODUCTOS LÁCTEOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (376,'C10500','ELABORACIÓN DE PRODUCTOS LÁCTEOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (377,'C105001','ELABORACIÓN DE LECHE FRESCA LÍQUIDA, CREMA DE LECHE LÍQUIDA, BEBIDAS A BASE DE LECHE, YOGURT, INCLUSO CASEÍNA O LACTOSA, PASTEURIZADA, ESTERILIZADA, HOMOGENEIZADA Y/O TRATADA A ALTAS TEMPERATURAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (378,'C105002','ELABORACIÓN DE LECHE EN POLVO, CONDENSADA SEA O NO AZUCARADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (379,'C105003','ELABORACIÓN DE CREMA EN FORMA SÓLIDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (380,'C105004','ELABORACIÓN DE MANTEQUILLA, QUESO, CUAJADA Y SUERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (381,'C105005','ELABORACIÓN DE HELADOS (DE TODO TIPO), SORBETES, BOLOS, GRANIZADOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (382,'C105006','SERVICIOS DE APOYO A LA ELABORACIÓN DE PRODUCTOS LÁCTEOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (383,'C105009','ELABORACIÓN DE OTROS PRODUCTOS LÁCTEOS: MANJAR DE LECHE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (384,'C106','ELABORACIÓN DE PRODUCTOS DE MOLINERÍA, ALMIDONES Y PRODUCTOS DERIVADOS DEL ALMIDÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (385,'C1061','ELABORACIÓN DE PRODUCTOS DE MOLINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (386,'C10611','MOLINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (387,'C106111','MOLIENDA DE CEREALES, PRODUCCIÓN DE HARINA, SEMOLINA, SÉMOLA Y GRÁNULOS DE: TRIGO, CENTENO, AVENA, MAÍZ Y OTROS CEREALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (388,'C106112','MOLIENDA O PILADO DE ARROZ: PRODUCCIÓN DE ARROZ DESCASCARILLADO, BLANQUEADO, PULIDO, SEMICOCIDO, HARINA DE ARROZ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (389,'C106113','MOLIENDA DE OTROS PRODUCTOS DE ORIGEN VEGETAL: PRODUCCIÓN DE HARINAS Y SÉMOLAS DE LEGUMINOSAS DESECADAS, DE RAÍCES Y TUBÉRCULOS (EXCEPTO PATATAS), DE NUECES Y FRUTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (390,'C10612','PRODUCTOS DE MOLINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (391,'C106121','ELABORACIÓN DE ALIMENTOS A BASE DE CEREALES TOSTADOS, INSUFLADOS, O MACERADOS, HOJALDRADOS, GRANOS PULIDOS Y CEREALES PARTIDOS O TRITURADOS, CEREALES PARA EL DESAYUNO Y SNACKS A BASE DE CEREALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (392,'C106122','ELABORACIÓN DE HARINAS O MASAS MEZCLADAS PREPARADAS PARA LA FABRICACIÓN DE PAN, PASTELES, BIZCOCHOS O PANQUEQUES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (393,'C10613','SERVICIOS DE APOYO A LA ELABORACIÓN DE PRODUCTOS DE MOLINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (394,'C106130','SERVICIOS DE APOYO A LA ELABORACIÓN DE PRODUCTOS DE MOLINERÍA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (395,'C1062','ELABORACIÓN DE ALMIDONES Y PRODUCTOS DERIVADOS DEL ALMIDÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (396,'C10620','ELABORACIÓN DE ALMIDONES Y PRODUCTOS DERIVADOS DEL ALMIDÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (397,'C106201','ELABORACIÓN DE ALMIDONES A PARTIR DE ARROZ, MAÍZ (MAICENA), PATATAS, YUCA Y OTRAS MATERIAS VEGETALES INCLUSO GLUTEN Y DEXTRINA ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (398,'C106202','MOLIENDA EN HÚMEDO DE MAÍZ, ELABORACIÓN DE ACEITE DE MAÍZ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (399,'C106203','ELABORACIÓN DE GLUCOSA, JARABE DE GLUCOSA, MALTOSA, INULINA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (400,'C106204','ELABORACIÓN DE TAPIOCA Y SUSTITUTOS DE TAPIOCA PREPARADOS A PARTIR DE ALMIDONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (401,'C106205','SERVICIOS DE APOYO A LA ELABORACIÓN DE ALMIDONES Y PRODUCTOS DERIVADOS DEL ALMIDÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (402,'C107','ELABORACIÓN DE OTROS PRODUCTOS ALIMENTICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (403,'C1071','ELABORACIÓN DE PRODUCTOS DE PANADERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (404,'C10710','ELABORACIÓN DE PRODUCTOS DE PANADERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (405,'C107101','ELABORACIÓN DE PAN Y OTROS PRODUCTOS DE PANADERÍA SECOS: PAN DE TODO TIPO, PANECILLOS, BIZCOCHOS, TOSTADAS, GALLETAS, ETCÉTERA, INCLUSO ENVASADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (406,'C107102','ELABORACIÓN DE PASTELES Y OTROS PRODUCTOS DE PASTELERÍA: PASTELES DE FRUTAS, TORTAS, PASTELES, TARTAS, ETCÉTERA, CHURROS, BUÑUELOS, APERITIVOS (BOCADILLOS), ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (407,'C107103','SERVICIOS DE APOYO A LA ELABORACIÓN DE PRODUCTOS DE PANADERÍA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (408,'C107109','ELABORACIÓN DE OTROS PRODUCTOS DE PANADERÍA, INCLUSO CONGELADOS: TORTILLAS DE MAÍZ O TRIGO, CONOS DE HELADO, OBLEAS, WAFFLES, PANQUEQUES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (409,'C1072','ELABORACIÓN DE AZÚCAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (410,'C10720','ELABORACIÓN DE AZÚCAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (411,'C107201','MOLIENDA Y EXTRACCIÓN DE JUGO DE CAÑA (TRAPICHE) Y PRODUCCIÓN DE PANELA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (412,'C107202','ELABORACIÓN Y REFINADO DE AZÚCAR DE CAÑA Y MELAZA DE CAÑA; REMOLACHA AZUCARERA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (413,'C107203','ELABORACIÓN DE JARABE DE: CAÑA DE AZÚCAR, PALMA, REMOLACHA AZUCARERA, STEVIA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (414,'C107204','SERVICIOS DE APOYO A LA ELABORACIÓN DE AZÚCAR A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (415,'C1073','ELABORACIÓN DE CACAO, CHOCOLATE Y PRODUCTOS DE CONFITERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (416,'C10731','ELABORACIÓN DE CACAO, CHOCOLATE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (417,'C107311','ELABORACIÓN DE CACAO, MANTECA, GRASA Y ACEITE DE CACAO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (418,'C107312','ELABORACIÓN DE CHOCOLATE Y PRODUCTOS DE CHOCOLATE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (419,'C10732','ELABORACIÓN PRODUCTOS DE CONFITERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (420,'C107321','ELABORACIÓN DE PRODUCTOS DE CONFITERÍA: CARAMELOS, TURRÓN, GRAGEAS Y PASTILLAS DE CONFITERÍA, GOMA DE MASCAR (CHICLES), CONFITES BLANDOS, CONFITERÍA A BASE DE CHOCOLATE Y CHOCOLATE BLANCO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (421,'C107322','CONSERVACIÓN EN AZÚCAR DE FRUTAS, NUECES Y OTROS FRUTOS SECOS, CÁSCARA DE FRUTAS Y OTRAS PARTES DE LAS PLANTAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (422,'C107329','ELABORACIÓN DE OTROS DULCES: MELCOCHAS, COCADAS, NOGADAS, DULCE DE GUAYABA, ALFEÑIQUES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (423,'C10733','SERVICIOS DE APOYO A LA ELABORACIÓN DE CACAO, CHOCOLATE Y PRODUCTOS DE CONFITERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (424,'C107330','SERVICIOS DE APOYO A LA ELABORACIÓN DE CACAO, CHOCOLATE Y PRODUCTOS DE CONFITERÍA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (425,'C1074','ELABORACIÓN DE MACARRONES, FIDEOS, ALCUZCUZ Y PRODUCTOS FARINÁCEOS SIMILARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (426,'C10740','ELABORACIÓN DE MACARRONES, FIDEOS, ALCUZCUZ Y PRODUCTOS FARINÁCEOS SIMILARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (427,'C107401','ELABORACIÓN DE PASTAS: TALLARÍN, ESPAGUETIS, MACARRONES, LASAÑA, CANELONES, RAVIOLES Y FIDEOS, SEAN O NO COCIDOS, RELLENOS O CONGELADOS, ELABORACIÓN DE ALCUZCUZ.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (428,'C107402','SERVICIOS DE APOYO A LA ELABORACIÓN DE MACARRONES, FIDEOS, ALCUZCUZ Y PRODUCTOS FARINÁCEOS SIMILARES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (429,'C1075','ELABORACIÓN DE COMIDAS Y PLATOS PREPARADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (430,'C10750','ELABORACIÓN DE COMIDAS Y PLATOS PREPARADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (431,'C107501','ELABORACIÓN DE PLATOS A BASE DE CARNE O DE POLLO, ESTOFADOS Y COMIDAS PREPARADOS AL VACIO, CONGELADAS, ENVASADAS, ENLATADAS O CONSERVADAS DE OTRA MANERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (432,'C107502','ELABORACIÓN DE PLATOS DE PESCADO Y MARISCOS, INCLUYENDO PESCADO CON PAPAS FRITAS, ENVASADO O CONGELADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (433,'C107503','ELABORACIÓN DE PLATOS PREPARADOS A BASE DE LEGUMBRES Y HORTALIZAS, CONGELADAS, ENVASADAS, ENLATADAS O CONSERVADAS DE OTRA MANERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (434,'C107504','SERVICIOS DE APOYO A LA ELABORACIÓN DE COMIDAS Y PLATOS PREPARADOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (435,'C107509','ELABORACIÓN DE OTRAS COMIDAS PREPARADAS: CONGELADAS, ENVASADAS, ENLATADAS O CONSERVADAS DE OTRA MANERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (436,'C1079','ELABORACIÓN DE OTROS PRODUCTOS ALIMENTICIOS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (437,'C10791','ELABORACIÓN DE CAFÉ, TÉ Y SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (438,'C107911','ACTIVIDADES DE DESCAFEINADO, TOSTADO Y ELABORACIÓN DE PRODUCTOS DE CAFÉ: CAFÉ MOLIDO, CAFÉ INSTANTÁNEO (SOLUBLE), EXTRACTOS Y CONCENTRADOS DE CAFÉ.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (439,'C107912','ELABORACIÓN DE PASTAS, EXTRACTOS Y CONCENTRADOS DE SUCEDÁNEOS (SUSTITUTOS) DEL CAFÉ.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (440,'C107913','ELABORACIÓN DE EXTRACTOS Y PREPARADOS A BASE DE TÉ O MATE; MEZCLA DE TÉ Y MATE, INFUSIONES DE HIERBAS (MENTA, MANZANILLA, VERBENA, ETCÉTERA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (441,'C10792','ELABORACIÓN DE ALIMENTOS ESPECIALES PARA INFANTES Y OTROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (442,'C107921','ELABORACIÓN DE ALIMENTOS ESPECIALES PARA INFANTES, LECHE MATERNIZADA, LECHE Y OTROS ALIMENTOS COMPLEMENTARIOS PARA EL CRECIMIENTO, ALIMENTOS QUE CONTIENEN INGREDIENTES HOMOGENEIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (443,'C107922','ELABORACIÓN DE SUSTITUTOS NO LÁCTEOS DE LECHE Y QUESOS NO LÁCTEOS (LECHE DE SOYA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (444,'C107929','ELABORACIÓN DE OTROS ALIMENTOS ESPECIALES: CONCENTRADOS DE PROTEÍNAS; ALIMENTOS PREPARADOS CON FINES DIETÉTICOS, ALIMENTOS SIN GLUTEN, ALIMENTOS PARA COMBATIR EL DESGASTE CAUSADO POR EL ESFUERZO MUSCULAR, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (445,'C10793','ELABORACIÓN DE ESPECIAS, SALSAS Y CONDIMENTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (446,'C107931','PROCESAMIENTO DE ESPECIAS Y CONDIMENTOS: LAUREL, TOMILLO, ALBAHACA, CILANTRO, COMINO, CANELA, PIMIENTA, NUEZ MOSCADA, JENGIBRE, SAL DE AJO, DE APIO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (447,'C107932','ELABORACIÓN DE SALSAS LÍQUIDAS O EN POLVO: MAYONESA, HARINA Y SÉMOLA DE MOSTAZA, MOSTAZA PREPARADA, SALSAS DE: TOMATE, AJÍ, SOYA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (448,'C107933','ELABORACIÓN DE VINAGRE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (449,'C107934','PROCESAMIENTO DE SAL DE MESA; POR EJEMPLO: SAL YODADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (450,'C10794','SERVICIOS DE APOYO A LA ELABORACIÓN DE OTROS PRODUCTOS ALIMENTICIOS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (451,'C107940','SERVICIOS DE APOYO A LA ELABORACIÓN DE OTROS PRODUCTOS ALIMENTICIOS N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (452,'C10799','ELABORACIÓN DE OTROS ALIMENTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (453,'C107991','ELABORACIÓN DE LEVADURA Y POLVOS DE HORNEAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (454,'C107992','ELABORACIÓN DE SOPAS Y CALDOS DE DIVERSOS INGREDIENTES, LÍQUIDOS, SÓLIDOS, POLVO O TABLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (455,'C107993','ELABORACIÓN DE EXTRACTOS Y JUGOS DE CARNE, PESCADO, CRUSTÁCEOS O MOLUSCOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (456,'C107994','ELABORACIÓN DE CONCENTRADOS ARTIFICIALES; POLVOS SOLUBLES PARA LA PREPARACIÓN DE POSTRES, TORTAS, FLANES, BUDINES, GELATINAS, REFRESCOS EN POLVO SIN DILUIR, EDULCORANTES, SABORIZANTES, ESPESANTES, COLORANTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (457,'C107999','ELABORACIÓN DE OTROS PRODUCTOS ALIMENTICIOS: ELABORACIÓN DE MIEL ARTIFICIAL, PRODUCTOS DE HUEVO, CLARAS DE HUEVO, OVOALBÚMINA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (458,'C108','ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (459,'C1080','ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (460,'C10800','ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (461,'C108001','ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES DOMÉSTICOS COMO: PERROS, GATOS, PÁJAROS, PECES, ETCÉTERA; INCLUIDOS LOS OBTENIDOS DEL TRATAMIENTO DE DESPERDICIOS DE MATADEROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (462,'C108002','FABRICACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES DE GRANJA (AVES, GANADO VACUNO, PORCINO, ETCÉTERA), ANIMALES ACUÁTICOS, INCLUIDOS ALIMENTOS CONCENTRADOS, SUPLEMENTOS ALIMENTICIOS, LA PREPARACIÓN DE ALIMENTOS SIN MEZCLAR (ELABORADOS A PARTIR DE UN ÚNICO PRODUCTO) Y LOS OBTENIDOS DEL TRATAMIENTO DE DESPERDICIOS DE MATADEROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (463,'C108003','SERVICIOS DE APOYO A LA ELABORACIÓN DE ALIMENTOS PREPARADOS PARA ANIMALES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (464,'C11','ELABORACIÓN DE BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (465,'C110','ELABORACIÓN DE BEBIDAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (466,'C1101','DESTILACIÓN, RECTIFICACIÓN Y MEZCLA DE BEBIDAS ALCOHÓLICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (467,'C11010','DESTILACIÓN, RECTIFICACIÓN Y MEZCLA DE BEBIDAS ALCOHÓLICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (468,'C110101','ELABORACIÓN DE BEBIDAS ALCOHÓLICAS DESTILADAS: WHISKY, COÑAC, BRANDY, GINEBRA, AGUARDIENTE DE CAÑA DE AZÚCAR, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (469,'C110102','ELABORACIÓN DE MEZCLA DE BEBIDAS ALCOHÓLICAS DESTILADAS Y PREPARADOS ALCOHÓLICOS COMPUESTOS: CREMAS Y OTRAS BEBIDAS ALCOHÓLICAS AROMATIZADAS Y AZUCARADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (470,'C110103','PRODUCCIÓN DE AGUARDIENTES NEUTROS (ALCOHOLES BASE PARA ELABORAR BEBIDAS ALCOHÓLICAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (471,'C110104','SERVICIOS DE APOYO A LA DESTILACIÓN, RECTIFICACIÓN Y MEZCLA DE BEBIDAS ALCOHÓLICAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (472,'C1102','ELABORACIÓN DE VINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (473,'C11020','ELABORACIÓN DE VINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (474,'C110201','ELABORACIÓN DE VINOS, VINOS ESPUMOSOS (CHAMPAGNE), VINO A PARTIR DE MOSTO DE UVA CONCENTRADO (VINO TINTO, JEREZ, OPORTO, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (475,'C110202','ELABORACIÓN DE BEBIDAS ALCOHÓLICAS FERMENTADAS PERO NO DESTILADAS: SAKE, SIDRA, PERADA, VERMOUTH, AGUAMIEL Y OTROS VINOS DE FRUTAS Y MEZCLAS DE BEBIDAS QUE CONTIENEN ALCOHOL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (476,'C110203','ELABORACIÓN DE VINOS DE BAJA GRADUACIÓN O SIN ALCOHOL Y MEZCLAS DE VINOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (477,'C110204','SERVICIOS DE APOYO A LA ELABORACIÓN DE VINOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (478,'C1103','ELABORACIÓN DE BEBIDAS MALTEADAS Y DE MALTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (479,'C11030','ELABORACIÓN DE BEBIDAS MALTEADAS Y DE MALTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (480,'C110301','ELABORACIÓN DE BEBIDAS MALTEADAS COMO: CERVEZAS CORRIENTES DE FERMENTACIÓN ALTA, NEGRAS Y FUERTES, INCLUIDA CERVEZA DE BAJA GRADUACIÓN O SIN ALCOHOL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (481,'C110302','ELABORACIÓN DE MALTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (482,'C110303','SERVICIOS DE APOYO A LA ELABORACIÓN DE BEBIDAS MALTEADAS Y DE MALTA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (483,'C1104','ELABORACIÓN DE BEBIDAS NO ALCOHÓLICAS; PRODUCCIÓN DE AGUAS MINERALES Y OTRAS AGUAS EMBOTELLADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (484,'C11040','ELABORACIÓN DE BEBIDAS NO ALCOHÓLICAS; PRODUCCIÓN DE AGUAS MINERALES Y OTRAS AGUAS EMBOTELLADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (485,'C110401','ELABORACIÓN DE BEBIDAS NO ALCOHÓLICAS EMBOTELLADAS (EXCEPTO CERVEZA Y VINO SIN ALCOHOL): BEBIDAS AROMATIZADAS Y/O EDULCORADAS: LIMONADAS, NARANJADAS, BEBIDAS GASEOSAS (COLAS), BEBIDAS ARTIFICIALES DE JUGOS DE FRUTAS (CON JUGOS DE FRUTAS O JARABES EN PROPORCIÓN INFERIOR AL 50%), AGUAS TÓNICAS, GELATINA COMESTIBLE, BEBIDAS HIDRATANTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (486,'C110402','PRODUCCIÓN DE AGUAS MINERALES NATURALES Y OTRAS AGUAS EMBOTELLADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (487,'C110403','SERVICIOS DE APOYO A LA ELABORACIÓN DE BEBIDAS NO ALCOHÓLICAS; PRODUCCIÓN DE AGUAS MINERALES Y OTRAS AGUAS EMBOTELLADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (488,'C12','ELABORACIÓN DE PRODUCTOS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (489,'C120','ELABORACIÓN DE PRODUCTOS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (490,'C1200','ELABORACIÓN DE PRODUCTOS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (491,'C12000','ELABORACIÓN DE PRODUCTOS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (492,'C120001','ELABORACIÓN DE PRODUCTOS DE TABACO Y SUSTITUTOS DE PRODUCTOS DE TABACO: TABACO HOMOGENEIZADO O RECONSTITUIDO, CIGARRILLOS, PICADURA PARA CIGARRILLOS, TABACO DE PIPA, TABACO DE MASCAR, RAPE, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (493,'C120002','DESNERVADO Y SECADO DE LAS HOJAS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (494,'C120003','ELABORACIÓN DE EXTRACTOS Y ESENCIAS DE TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (495,'C120004','SERVICIOS DE APOYO A LA ELABORACIÓN DE PRODUCTOS DE TABACO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (496,'C13','FABRICACIÓN DE PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (497,'C131','HILATURA, TEJEDURA Y ACABADOS DE PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (498,'C1311','PREPARACIÓN E HILATURA DE FIBRAS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (499,'C13110','PREPARACIÓN E HILATURA DE FIBRAS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (500,'C131101','ACTIVIDADES DE OPERACIONES PREPARATORIAS DE FIBRAS TEXTILES: DEVANADO Y LAVADO DE SEDA, DESENGRASE, CARBONIZACIÓN Y TEÑIDO DE VELLÓN, CARDADO Y PEINADO DE TODA CLASE DE FIBRAS ANIMALES, VEGETALES, ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (501,'C131102','HILATURA Y FABRICACIÓN DE HILADOS E HILOS PARA TEJEDURÍA O COSTURA, PARA EL COMERCIO O PARA PROCESAMIENTO POSTERIOR, TEXTURIZACIÓN, RETORCIDO, PLEGADO, CABLEADO Y REMOJO DE HILATURAS FILAMENTOSAS DE TODA CLASE DE FIBRAS ANIMALES, VEGETALES, SINTÉTICAS O ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (502,'C131103','FABRICACIÓN DE HILADOS DE PAPEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (503,'C131104','SERVICIOS DE APOYO A LA PREPARACIÓN E HILATURA DE FIBRAS TEXTILES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (504,'C1312','TEJEDURA DE PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (505,'C13120','FABRICACIÓN DE TEJIDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (506,'C131201','FABRICACIÓN DE TEJIDOS (TELAS) ANCHOS DE ALGODÓN, LANA CARDADA, LANA PEINADA O SEDA, INCLUIDOS LOS FABRICADOS A PARTIR DE MEZCLAS O DE HILADOS SINTÉTICOS O ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (507,'C131202','FABRICACIÓN DE TEJIDOS (TELAS) ATERCIOPELADOS Y DE FELPILLA, TEJIDOS DE RIZO, TEJIDOS DE GASA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (508,'C131203','FABRICACIÓN DE TEJIDOS (TELAS) DE FIBRA DE VIDRIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (509,'C131204','SERVICIOS DE APOYO A LA ELABORACIÓN DE TEJIDOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (510,'C131209','FABRICACIÓN DE OTROS TEJIDOS (TELAS) ANCHOS DE LINO, RAMIO, CÁÑAMO, YUTE Y FIBRAS BLANDAS Y DE HILADOS ESPECIALES, TEJIDOS DE FIBRA DE CARBONO E HILOS ARÁMIDOS, TEJIDOS QUE IMITAN LAS PIELES FINAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (511,'C1313','SERVICIO DE ACABADO DE PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (512,'C13130','SERVICIO DE ACABADO DE PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (513,'C131301','SERVICIO DE BLANQUEO Y TEÑIDO DE FIBRAS, HILADOS, TEJIDOS (TELAS) Y ARTÍCULOS TEXTILES, INCLUIDO PRENDAS DE VESTIR: PANTALONES VAQUEROS (JEANS) ETCÉTERA, REALIZADO POR TERCEROS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (514,'C131302','SERVICIO DE APRESTO, CALANDRADO, SECADO, VAPORIZADO, ENCOGIMIENTO, PERCHADO, REMALLADO, SANFORIZADO, MERCERIZADO, PLISADO DE TEXTILES Y ARTÍCULOS TEXTILES, INCLUIDO PRENDAS DE VESTIR REALIZADO POR TERCEROS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (515,'C131303','SERVICIO DE IMPERMEABILIZADO, REVESTIMIENTO, CAUCHUTADO O IMPREGNACIÓN DE PRENDAS REALIZADO POR TERCEROS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (516,'C131304','SERVICIO DE ESTAMPADO SERIGRÁFICO DE PRODUCTOS TEXTILES Y PRENDAS DE VESTIR, REALIZADO POR TERCEROS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (517,'C139','FABRICACIÓN DE OTROS PRODUCTOS TEXTILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (518,'C1391','FABRICACIÓN DE TEJIDOS DE PUNTO Y GANCHILLO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (519,'C13910','FABRICACIÓN DE TEJIDOS DE PUNTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (520,'C139101','FABRICACIÓN DE TEJIDOS (TELAS) DE PUNTO O GANCHILLO: TEJIDOS ATERCIOPELADOS Y DE RIZO, PIELES DE IMITACIÓN DE PUNTO OBTENIDAS MEDIANTE EL TRICOTAJE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (521,'C139102','SERVICIOS DE APOYO A LA FABRICACIÓN DE TEJIDOS DE PUNTO Y GANCHILLO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (522,'C1392','FABRICACIÓN DE ARTÍCULOS CONFECCIONADOS DE MATERIALES TEXTILES, EXCEPTO PRENDAS DE VESTIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (523,'C13920','FABRICACIÓN DE ARTÍCULOS CONFECCIONADOS DE MATERIALES TEXTILES, EXCEPTO PRENDAS DE VESTIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (524,'C139201','FABRICACIÓN DE ARTÍCULOS CONFECCIONADOS CON CUALQUIER TIPO DE MATERIAL TEXTIL, INCLUIDOS TEJIDOS (TELAS) DE PUNTO Y GANCHILLO: FRAZADAS, MANTAS DE VIAJE, SOBRECAMAS, COBIJAS, EDREDONES, ROPA DE CAMA, SÁBANAS, MANTELERÍA, TOALLAS Y ARTÍCULOS DE COCINA ACOLCHADOS, EDREDONES, COJINES, PUFÉS, ALMOHADAS, SACOS DE DORMIR, ARTÍCULOS PARA EL BAÑO, ETCÉTERA, INCLUIDO  TEJIDOS PARA MANTAS ELÉCTRICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (525,'C139202','FABRICACIÓN DE ACCESORIOS CONFECCIONADOS PARA EL HOGAR: CORTINAS, CENEFAS, VISILLOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (526,'C139203','FABRICACIÓN DE ARTÍCULOS DE LONA O ENCERADOS: TIENDAS DE CAMPAÑA, ARTÍCULOS DE ACAMPADA, VELAS, TOLDOS DE PROTECCIÓN CONTRA EL SOL, CARPAS, FUNDAS PARA EMBALAR MERCADERÍAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (527,'C139204','FABRICACIÓN DE TAPICES TEJIDOS A MANO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (528,'C139205','FABRICACIÓN DE BANDERAS, BANDERINES, GALLARDETES, ESTANDARTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (529,'C139206','FABRICACIÓN DE FUNDAS (FORROS) O COBERTORES DE ASIENTOS PARA AUTOMÓVILES, FUNDAS PARA MAQUINARIAS, MUEBLES, NEUMÁTICOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (530,'C139207','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS CONFECCIONADOS DE MATERIALES TEXTILES, EXCEPTO PRENDAS DE VESTIR A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (531,'C139209','FABRICACIÓN DE OTROS ARTÍCULOS CONFECCIONADOS CON TEXTILES: PAÑOS PARA DESEMPOLVAR, PAÑOS DE COCINA Y ARTÍCULOS SIMILARES, CHALECOS SALVAVIDAS, PARACAÍDAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (532,'C1393','FABRICACIÓN DE TAPICES Y ALFOMBRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (533,'C13930','FABRICACIÓN DE TAPICES Y ALFOMBRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (534,'C139301','FABRICACIÓN DE RECUBRIMIENTOS PARA PISOS DE MATERIALES TEXTILES: TAPICES, ALFOMBRAS, ESTERAS, RECUADROS DE MOQUETA (ALFOMBRA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (535,'C139302','FABRICACIÓN DE RECUBRIMIENTOS PARA PISOS DE FIELTRO PUNZONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (536,'C139303','SERVICIOS DE APOYO A LA FABRICACIÓN DE TAPICES Y ALFOMBRAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (537,'C1394','FABRICACIÓN DE CUERDAS, CORDELES, BRAMANTES Y REDES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (538,'C13940','FABRICACIÓN DE CUERDAS, CORDELES, BRAMANTES Y REDES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (539,'C139401','FABRICACIÓN DE CUERDAS, CORDELES, BRAMANTES E HILOS DE FIBRAS TEXTILES O DE CINTAS O SIMILARES, ESTÉN O NO IMPREGNADOS, REVESTIDOS, CUBIERTOS O FORRADOS CON CAUCHO O PLÁSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (540,'C139402','FABRICACIÓN DE MALLAS ANUDADAS DE CUERDA, CORDEL O BRAMANTE: REDES DE PESCA, DEFENSAS PARA BORDOS, COJINES PARA DESCARGA, ESLINGAS, CUERDAS Y MAROMAS CON AROS METÁLICOS, ETCÉTERA, INCLUIDO FABRICACIÓN DE HAMACAS, BOLSAS DE RED PARA PELOTAS, REDES PARA DEPORTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (541,'C139403','SERVICIOS DE APOYO A LA FABRICACIÓN DE CUERDAS, CORDELES, BRAMANTES Y REDES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (542,'C1399','FABRICACIÓN DE OTROS PRODUCTOS TEXTILES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (543,'C13990','FABRICACIÓN DE OTROS PRODUCTOS TEXTILES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (544,'C139901','FABRICACIÓN DE TEJIDOS (TELAS) ESTRECHOS, INCLUIDOS LOS DE URDIMBRE SIN TRAMA SUJETOS POR UNA SUSTANCIA ADHESIVA: MARBETES, INSIGNIAS, ETCÉTERA; ARTÍCULOS DE PASAMANERÍA: CORDONES DE MATERIALES TEXTILES PARA ZAPATOS, TRENCILLAS, BORLAS, MADROÑOS, TULES Y OTROS TEJIDOS (TELAS) DE MALLAS ANUDADAS, DE ENCAJE Y BORDADOS, EN PIEZAS, TIRAS O MOTIVOS DECORATIVOS, TEJIDOS (TELAS) DE RED Y DEL TIPO QUE SE UTILIZA PARA LA CONFECCIÓN DE VISILLOS TRICOTADOS EN MÁQUINAS RASCHEL O MÁQUINAS SIMILARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (545,'C139902','FABRICACIÓN DE TEJIDOS (TELAS) IMPREGNADOS, REVESTIDOS, RECUBIERTOS O LAMINADOS CON PLÁSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (546,'C139903','FABRICACIÓN DE HILADOS METALIZADOS E HILADOS ENTORCHADOS; HILOS Y CUERDAS DE CAUCHO REVESTIDOS DE MATERIALES TEXTILES; HILADOS Y BANDAS TEXTILES RECUBIERTOS IMPREGNADOS, REVESTIDOS O FORRADOS CON CAUCHO O PLÁSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (547,'C139904','FABRICACIÓN DE TEJIDOS DE HILADOS DE GRAN RESISTENCIA PARA CUERDAS DE NEUMÁTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (548,'C139905','FABRICACIÓN DE TEJIDOS TRATADOS O REVESTIDOS: PAPEL TELA, LIENZOS PREPARADOS PARA PINTORES, BOCACÍ Y TEJIDOS RÍGIDOS SIMILARES, TEJIDOS REVESTIDOS CON GOMA O SUSTANCIAS AMILÁCEAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (549,'C139906','FABRICACIÓN DE ARTÍCULOS TEXTILES DIVERSOS: MECHAS DE MATERIALES TEXTILES, CAMISAS PARA MECHEROS DE GAS INCANDESCENTES Y TEJIDOS TUBULARES PARA SU FABRICACIÓN, MANGUERAS, CORREAS TRANSPORTADORAS Y CORREAJE DE TRANSMISIÓN (ESTÉN REFORZADOS O NO CON METALES U OTROS MATERIALES), TELA PARA TAMICES, TELA DE FILTRACIÓN, FIELTRO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (550,'C139907','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS TEXTILES N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (551,'C139909','FABRICACIÓN DE OTROS PRODUCTOS TEXTILES: ADORNOS PARA VEHÍCULOS AUTOMOTORES, CINTA-TEJIDO SENSIBLE A LA PRESIÓN, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (552,'C14','FABRICACIÓN DE PRENDAS DE VESTIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (553,'C141','FABRICACIÓN DE PRENDAS DE VESTIR, EXCEPTO PRENDAS DE PIEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (554,'C1410','FABRICACIÓN DE PRENDAS DE VESTIR, EXCEPTO PRENDAS DE PIEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (555,'C14100','FABRICACIÓN DE PRENDAS DE VESTIR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (556,'C141001','FABRICACIÓN DE PRENDAS DE VESTIR DE CUERO O CUERO REGENERADO, INCLUIDOS ACCESORIOS DE TRABAJO DE CUERO COMO: MANDILES PARA SOLDADORES, ROPA DE TRABAJO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (557,'C141002','FABRICACIÓN DE PRENDAS DE VESTIR DE TELAS TEJIDAS, DE PUNTO Y GANCHILLO, DE TELAS NO TEJIDAS, ENTRE OTRAS, PARA HOMBRES, MUJERES, NIÑOS Y BEBES: ABRIGOS, TRAJES, CONJUNTOS, CHAQUETAS, PANTALONES, FALDAS, CALENTADORES, TRAJES DE BAÑO, ROPA DE ESQUÍ, UNIFORMES, CAMISAS, CAMISETAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (558,'C141003','FABRICACIÓN DE ROPA INTERIOR Y ROPA DE DORMIR DE TELAS TEJIDAS, DE PUNTO Y GANCHILLO, DE ENCAJE, ETCÉTERA, PARA HOMBRES, MUJERES Y NIÑOS: PANTIES, CALZONCILLOS, PIJAMAS, CAMISONES, BATAS, BLUSAS, SLIPS, SUJETADORES, FAJAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (559,'C141004','ACTIVIDADES DE CONFECCIÓN A LA MEDIDA DE PRENDAS DE VESTIR (COSTURERAS, SASTRES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (560,'C141005','FABRICACIÓN DE GORROS Y SOMBREROS (INCLUIDO LOS DE PIEL Y PAJA TOQUILLA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (561,'C141006','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRENDAS DE VESTIR, EXCEPTO PRENDAS DE PIEL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (562,'C141009','FABRICACIÓN DE OTROS ACCESORIOS DE VESTIR: GUANTES, CINTURONES, CHALES, CORBATAS, CORBATINES, REDECILLAS PARA EL CABELLO, CALZADO DE MATERIALES TEXTILES SIN APLICACIÓN DE SUELAS, ETCÉTERA, INCLUIDO LA FABRICACIÓN DE PARTES DE PRODUCTOS O PRENDAS TEXTILES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (563,'C142','FABRICACIÓN DE ARTÍCULOS DE PIEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (564,'C1420','FABRICACIÓN DE ARTÍCULOS DE PIEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (565,'C14200','FABRICACIÓN DE ARTÍCULOS DE PIEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (566,'C142001','FABRICACIÓN DE ARTÍCULOS DE PIEL (CON PELO NATURAL): PRENDAS Y ACCESORIOS DE PIEL INCLUIDO LOS CONFECCIONADOS CON PIELES “ALARGADAS”, PLANCHAS, CUADRADOS, TIRAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (567,'C142002','FABRICACIÓN DE ARTÍCULOS DIVERSOS DE PIEL (CON PELO NATURAL): ALFOMBRAS, PUFS SIN RELLENO, PAÑOS PARA PULIMENTO INDUSTRIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (568,'C142003','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE PIEL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (569,'C143','FABRICACIÓN DE ARTÍCULOS DE PUNTO Y GANCHILLO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (570,'C1430','FABRICACIÓN DE ARTÍCULOS DE PUNTO Y GANCHILLO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (571,'C14300','FABRICACIÓN DE ARTÍCULOS DE PUNTO Y GANCHILLO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (572,'C143001','FABRICACIÓN DE ARTÍCULOS DE CONFECCIÓN DE PUNTO Y GANCHILLO: JERSEYS, SUÉTERES, CHALECOS, CAMISETAS Y ARTÍCULOS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (573,'C143002','FABRICACIÓN DE MEDIAS, INCLUIDOS CALCETINES, LEOTARDOS Y PANTIMEDIAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (574,'C143003','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE PUNTO Y GANCHILLO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (575,'C15','FABRICACIÓN DE CUEROS Y PRODUCTOS CONEXOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (576,'C151','CURTIDO Y ADOBO DE CUEROS; FABRICACIÓN DE MALETAS, BOLSOS DE MANO Y ARTÍCULOS DE TALABARTERÍA Y GUARNICIONERÍA; ADOBO Y TEÑIDO DE PIELES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (577,'C1511','CURTIDO Y ADOBO DE CUEROS; ADOBO Y TEÑIDO DE PIELES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (578,'C15110','CURTIDO Y ADOBO DE CUEROS; ADOBO Y TEÑIDO DE PIELES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (579,'C151101','ACTIVIDADES DE DESCARNADURA, TUNDIDO, DEPILADO, ENGRASE, CURTIDO, BLANQUEO, TEÑIDO, ADOBO DE PIELES Y CUEROS DE PIELES FINAS Y CUEROS CON PELO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (580,'C151102','FABRICACIÓN DE CUEROS REGENERADOS (ARTIFICIALES), CUEROS GAMUZADOS Y APERGAMINADOS, CHAROL Y CUEROS METALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (581,'C151103','SERVICIOS DE APOYO AL CURTIDO Y ADOBO DE CUEROS; ADOBO Y TEÑIDO DE PIELES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (582,'C1512','FABRICACIÓN DE MALETAS, BOLSOS DE MANO Y ARTÍCULOS SIMILARES, ARTÍCULOS DE TALABARTERÍA Y GUARNICIONERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (583,'C15120','FABRICACIÓN DE MALETAS, BOLSOS DE MANO Y ARTÍCULOS SIMILARES, ARTÍCULOS DE TALABARTERÍA Y GUARNICIONERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (584,'C151201','FABRICACIÓN DE MALETAS, BOLSOS DE MANO, MOCHILAS Y ARTÍCULOS SIMILARES, DE CUERO, CUERO REGENERADO O CUALQUIER OTRO MATERIAL, COMO PLÁSTICO, MATERIALES TEXTILES, FIBRAS VULCANIZADAS O CARTÓN, CUANDO SE USA LA MISMA TECNOLOGÍA QUE EN EL CASO DEL CUERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (585,'C151202','FABRICACIÓN DE ARTÍCULOS DE TALABARTERÍA Y GUARNICIONERÍA: SILLAS DE MONTAR, ARREOS, LÁTIGOS Y FUSTAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (586,'C151203','SERVICIOS DE APOYO A LA FABRICACIÓN DE MALETAS, BOLSOS DE MANO Y ARTÍCULOS SIMILARES, ARTÍCULOS DE TALABARTERÍA Y GUARNICIONERÍA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (587,'C151209','FABRICACIÓN DE OTROS ARTÍCULOS DIVERSOS DE CUERO O CUERO REGENERADO: CORREAS DE TRANSMISIÓN, CORDONES DE CUERO PARA ZAPATOS, CORREAS NO METÁLICAS PARA RELOJES (DE MATERIALES TEXTILES, CUERO Y PLÁSTICO), ARTÍCULOS DE ENVASE O EMBALAJE, ARTÍCULOS USADOS CON FINES TÉCNICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (588,'C152','FABRICACIÓN DE CALZADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (589,'C1520','FABRICACIÓN DE CALZADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (590,'C15200','FABRICACIÓN DE CALZADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (591,'C152001','FABRICACIÓN DE CALZADO, BOTINES, POLAINAS Y ARTÍCULOS SIMILARES PARA TODO USO, DE CUALQUIER MATERIAL Y MEDIANTE CUALQUIER PROCESO, INCLUIDO EL MOLDEADO (APARADO DE CALZADO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (592,'C152002','FABRICACIÓN DE PARTES DE CUERO PARA CALZADO: PALAS Y PARTES DE PALAS, SUELAS Y PLANTILLAS, TACONES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (593,'C152003','SERVICIOS DE APOYO A LA FABRICACIÓN DE CALZADO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (594,'C16','PRODUCCIÓN DE MADERA Y FABRICACIÓN DE PRODUCTOS DE MADERA Y CORCHO, EXCEPTO MUEBLES; FABRICACIÓN DE ARTÍCULOS DE PAJA Y DE MATERIALES TRENZABLES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (595,'C161','ASERRADO Y ACEPILLADURA DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (596,'C1610','ASERRADO Y ACEPILLADURA DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (597,'C16100','ASERRADO Y ACEPILLADURA DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (598,'C161001','ACTIVIDADES DE SECADO, ASERRADO, ACEPILLADURA Y MAQUINADO DE MADERA TABLEADO, DESCORTEZADO Y DESMENUZAMIENTO DE TRONCOS; OBTENCIÓN DE LANA DE MADERA, HARINA DE MADERA Y PARTÍCULAS DE MADERA; IMPREGNACIÓN Y TRATAMIENTO QUÍMICO DE LA MADERA CON AGENTES CONSERVANTES Y OTRAS SUSTANCIAS (MADERA PREPARADA O TRATADA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (599,'C161002','FABRICACIÓN DE TABLETAS PARA LA ENSAMBLADURA DE PISOS DE MADERA (DUELA, MEDIA DUELA, PARQUET).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (600,'C161003','SERVICIOS DE APOYO AL ASERRADO Y ACEPILLADURA DE MADERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (601,'C161009','FABRICACIÓN DE OTROS TIPOS DE MADERA EN BRUTO: RODRIGONES, ESTACAS, TABLILLAS, TRAVIESAS DE MADERA (DURMIENTES) PARA VÍAS FÉRREAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (602,'C162','FABRICACIÓN DE HOJAS DE MADERA PARA ENCHAPADO Y TABLEROS A BASE DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (603,'C1621','FABRICACIÓN DE HOJAS DE MADERA PARA ENCHAPADO Y TABLEROS A BASE DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (604,'C16210','FABRICACIÓN DE HOJAS DE MADERA PARA ENCHAPADO Y TABLEROS A BASE DE MADERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (605,'C162101','FABRICACIÓN DE HOJAS DE MADERA (ALISADAS, TEÑIDAS, BAÑADAS, IMPREGNADAS, REFORZADAS CON PAPEL O TELA, CORTADAS EN FIGURAS) PARA ENCHAPADO SUFICIENTEMENTE DELGADAS PARA PRODUCIR MADERA ENCHAPADA, TABLEROS CONTRACHAPADOS Y OTROS FINES; FABRICACIÓN DE TABLEROS CONTRACHAPADOS, TABLEROS DE MADERA ENCHAPADA Y OTROS TABLEROS Y HOJAS DE MADERA LAMINADA, TABLEROS DE FIBRA Y TABLEROS DE PARTÍCULAS, MADERA COMPACTADA, MADERA LAMINADA ENCOLADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (606,'C162102','SERVICIOS DE APOYO A LA FABRICACIÓN DE HOJAS DE MADERA PARA ENCHAPADO Y TABLEROS A BASE DE MADERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (607,'C1622','FABRICACIÓN DE PARTES Y PIEZAS DE CARPINTERÍA PARA EDIFICIOS Y CONSTRUCCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (608,'C16220','FABRICACIÓN DE PARTES Y PIEZAS DE CARPINTERÍA PARA EDIFICIOS Y CONSTRUCCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (609,'C162201','FABRICACIÓN DE PRODUCTOS DE MADERA UTILIZADOS PRINCIPALMENTE POR LA INDUSTRIA DE LA CONSTRUCCIÓN: VIGAS, CABRÍOS, JABALCONES, PUNTALES, ARMAZONES DE MADERA LAMINADA ENCOLADA Y ARMAZONES DE MADERA PREFABRICADOS CON UNIONES DE METAL, ANDAMIOS, POSTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (610,'C162202','FABRICACIÓN DE PUERTAS, VENTANAS, CONTRAVENTANAS Y SUS MARCOS, TENGAN O NO HERRAJES, COMO BISAGRAS, CERRADURAS, ESCALERAS, BARANDALES, BOCELES Y MOLDURAS; RIPIAS, DUELAS DE MADERA, BLOQUES, LISTONES, ETCÉTERA, ENSAMBLADOS EN TABLEROS PARA PISOS DE PARQUÉT; TABIQUES (MAMPARAS) DE MADERA (EXCEPTO LOS AUTOESTABLES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (611,'C162203','FABRICACIÓN DE CASAS MÓVILES, EDIFICIOS PREFABRICADOS Y COMPONENTES DE LOS MISMOS, PREDOMINANTEMENTE DE MADERA, POR EJEMPLO SAUNAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (612,'C162204','SERVICIOS DE APOYO A LA FABRICACIÓN DE PARTES Y PIEZAS DE CARPINTERÍA PARA EDIFICIOS Y CONSTRUCCIONES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (613,'C1623','FABRICACIÓN DE RECIPIENTES DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (614,'C16230','FABRICACIÓN DE RECIPIENTES DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (615,'C162301','FABRICACIÓN DE CAJAS, CAJONES, BARRILES Y ENVASES SIMILARES, TONELES, BARRICAS, CUBAS, TINAS Y OTROS PRODUCTOS DE TONELERÍA DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (616,'C162302','FABRICACIÓN DE PALETAS, PALETAS-CAJA Y OTRAS BANDEJAS DE MADERA PARA OPERACIONES DE CARGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (617,'C162303','FABRICACIÓN DE CARRETES DE MADERA PARA CABLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (618,'C162304','SERVICIOS DE APOYO A LA FABRICACIÓN DE RECIPIENTES DE MADERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (619,'C1629','FABRICACIÓN DE OTROS PRODUCTOS DE MADERA; FABRICACIÓN DE ARTÍCULOS DE CORCHO, PAJA Y MATERIALES TRENZABLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (620,'C16291','FABRICACIÓN DE DIVERSOS PRODUCTOS DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (621,'C162911','FABRICACIÓN DE PRODUCTOS DE MADERA: MANGOS Y MONTURAS DE HERRAMIENTAS, CEPILLOS Y ESCOBAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (622,'C162912','FABRICACIÓN DE PARTES DE MADERA PARA BOTAS O ZAPATOS (TACONES), HORMAS Y TENSORES PARA BOTAS O ZAPATOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (623,'C162913','FABRICACIÓN DE UTENSILIOS DE COCINA Y PARA USO DOMÉSTICO DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (624,'C162914','FABRICACIÓN DE ESTATUILLAS Y ORNAMENTOS DE MADERA Y ARTÍCULOS DE MARQUETERÍA Y TARACEA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (625,'C162915','FABRICACIÓN DE MARCOS DE MADERA PARA ESPEJOS Y CUADROS, FABRICACIÓN DE BASTIDORES DE MADERA PARA LIENZOS DE PINTOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (626,'C162916','FABRICACIÓN DE CAJAS DE MADERA PARA JOYAS, CUCHILLOS Y ARTÍCULOS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (627,'C162917','FABRICACIÓN DE CARRETES, TAPAS, CANILLAS DE BOBINAS, CARRETES PARA HILOS DE COSER Y ARTÍCULOS SIMILARES DE MADERA TORNEADA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (628,'C162918','FABRICACIÓN DE ARTÍCULOS DE MADERA PARA MOBLAJE DEL TIPO APLIQUE COMO: PERCHEROS PARA ROPA Y SOMBREROS, PERO NO MUEBLES EN PIE, PERCHAS DE MADERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (629,'C162919','FABRICACIÓN DE OTROS ARTÍCULOS DE MADERA: MANGOS (EMPUÑADURAS) PARA PARAGUAS, BASTONES Y SIMILARES, BLOQUES DE MADERA PARA LA ELABORACIÓN DE PIPAS; PALILLOS, PALETAS PARA HELADOS, PINCHOS, BAJA LENGUAS, ETCÉTERA, TRONCOS DE CHIMENEA HECHOS DE MADERA PRENSADA O DE OTROS MATERIALES PRENSADOS, COMO MOLEDURAS DE CAFÉ O DE HABAS DE SOYA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (630,'C16292','FABRICACIÓN DE ARTÍCULOS DE CORCHO, PAJA Y MATERIALES TRENZABLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (631,'C162921','PROCESAMIENTO DE CORCHO NATURAL, FABRICACIÓN DE CORCHO AGLOMERADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (632,'C162922','FABRICACIÓN DE ARTÍCULOS DE CORCHO NATURAL O CORCHO AGLOMERADO, INCLUIDOS CUBRIMIENTOS PARA PISOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (633,'C162923','FABRICACIÓN DE TRENZAS Y ARTÍCULOS SIMILARES DE MATERIALES TRENZABLES: ESTERAS, ESTERILLAS, PERSIANAS, CAJAS, CESTOS Y ARTÍCULOS DE MIMBRE, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (634,'C16293','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS DE MADERA; FABRICACIÓN DE ARTÍCULOS DE CORCHO, PAJA Y MATERIALES TRENZABLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (635,'C162930','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS DE MADERA; FABRICACIÓN DE ARTÍCULOS DE CORCHO, PAJA Y MATERIALES TRENZABLES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (636,'C17','FABRICACIÓN DE PAPEL Y DE PRODUCTOS DE PAPEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (637,'C170','FABRICACIÓN DE PAPEL Y DE PRODUCTOS DE PAPEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (638,'C1701','FABRICACIÓN DE PASTA DE MADERA, PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (639,'C17010','FABRICACIÓN DE PASTA DE MADERA, PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (640,'C170101','FABRICACIÓN DE PASTA DE MADERA BLANQUEADA, SEMIBLANQUEADA O SIN BLANQUEAR MEDIANTE PROCESOS MECÁNICOS, QUÍMICOS (CON O SIN DISOLUCIÓN) O SEMIQUÍMICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (641,'C170102','FABRICACIÓN DE PASTA DE PAPEL A PARTIR DE LA ELIMINACIÓN DE LA TINTA Y FABRICACIÓN DE PASTA DE DESECHOS DE PAPEL PAPELES USADOS; O A PARTIR DE RESIDUOS TEXTILES, COMO BORRAS DE ALGODÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (642,'C170103','FABRICACIÓN DE PAPEL Y CARTÓN PARA SU POSTERIOR ELABORACIÓN INDUSTRIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (643,'C170104','TRATAMIENTO INDUSTRIAL POSTERIOR DE PAPEL Y CARTÓN: REVESTIMIENTO, RECUBRIMIENTO E IMPREGNACIÓN DE PAPEL Y CARTÓN; PAPELES LAMINADOS, PAPEL ALUMINIO, PAPEL KRAFT, CARTULINA, PAPEL MULTILAMINAR, PAPELES ABSORBENTES, PAPEL PERGAMINO, PAPEL CIGARRILLO, PAPEL RIZADO O PLEGADO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (644,'C170105','FABRICACIÓN DE PAPEL DE PERIÓDICO Y OTROS PAPELES PARA IMPRIMIR Y ESCRIBIR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (645,'C170106','SERVICIOS DE APOYO A LA FABRICACIÓN DE PASTA DE MADERA, PAPEL Y CARTÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (646,'C170109','ELABORACIÓN DE OTROS TIPOS DE PAPEL: PAPEL CARBÓN O PAPEL ESTÉNCIL EN ROLLOS U HOJAS GRANDES, PAPEL HECHO A MANO, FABRICACIÓN DE GUATA DE CELULOSA Y TIRAS DE FIBRAS DE CELULOSA ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (647,'C1702','FABRICACIÓN DE PAPEL Y CARTÓN ONDULADO Y DE ENVASES DE PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (648,'C17020','FABRICACIÓN DE PAPEL Y CARTÓN ONDULADO Y DE ENVASES DE PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (649,'C170201','FABRICACIÓN DEL PAPEL Y CARTÓN ONDULADOS O CORRUGADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (650,'C170202','FABRICACIÓN DE ENVASES DE PAPEL O DE CARTÓN ONDULADO, RÍGIDO O PLEGABLE: CAJAS, CAJONES, ESTUCHES, ENVASES, ARCHIVADORES DE CARTÓN DE OFICINA Y ARTÍCULOS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (651,'C170203','FABRICACIÓN DE SACOS Y DE BOLSAS DEL PAPEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (652,'C170204','SERVICIOS DE APOYO A LA FABRICACIÓN DE PAPEL Y CARTÓN ONDULADO Y DE ENVASES DE PAPEL Y CARTÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (653,'C1709','FABRICACIÓN DE OTROS ARTÍCULOS DEL PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (654,'C17091','FABRICACIÓN DE ARTÍCULOS DE PAPEL Y GUATA DE CELULOSA PARA USO DOMÉSTICO, SANITARIO E HIGIÉNICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (655,'C170911','FABRICACIÓN DE PRODUCTOS DE PAPEL DE HIGIENE PERSONAL Y PRODUCTOS DE GUATA DE CELULOSA Y MATERIALES TEXTILES: PAÑUELOS DE LIMPIEZA, TOALLAS, SERVILLETAS, PAPEL HIGIÉNICO, TOALLAS SANITARIAS Y TAMPONES, TOALLAS PARA DESMAQUILLAR, PAÑALES PARA BEBES Y SIMILARES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (656,'C170912','FABRICACIÓN DE ARTÍCULOS DE USO DOMÉSTICOS VASOS, PLATOS Y BANDEJAS, BANDEJAS PARA GUARDAR HUEVOS Y OTROS PRODUCTOS PARA ENVASADO, DE PAPEL O CARTÓN MOLDEADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (657,'C170913','ELABORACIÓN DE BOBINAS, CARRETES, TAPAS, ETCÉTERA, DE PAPEL O CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (658,'C170914','ELABORACIÓN DE PAPEL PARA EMPAPELAR Y CUBRIMIENTOS SIMILARES PARA PARED, INCLUIDO PAPEL DE EMPAPELAR TEXTIL Y RECUBIERTO DE VINILO, REVESTIMIENTO PARA VIDRIOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (659,'C170915','ELABORACIÓN DE PRENDAS Y COMPLEMENTOS DE VESTIR DE PAPEL O GUATA DE CELULOSA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (660,'C17092','FABRICACIÓN DE ARTÍCULOS DE PAPELERÍA Y OTROS ARTÍCULOS DE PAPEL Y CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (661,'C170921','FABRICACIÓN DE PAPEL PARA IMPRESORA DE COMPUTADORA; PAPEL PARA IMPRIMIR Y ESCRIBIR U OTROS USOS GRÁFICOS LISTO PARA USAR, CORTADO O PERFORADO, RAYADO, ETCÉTERA (PAPEL BOND, ETIQUETA, COUCHÉ).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (662,'C170922','ELABORACIÓN DE PAPEL DE ESTÉNCIL, AUTOCOPIA Y OTROS PAPELES PARA COPIAR O TRANSFERIR, LISTO PARA USAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (663,'C170923','FABRICACIÓN DE PAPEL ENGOMADO O ADHESIVO LISTO PARA USAR (CINTAS O ROLLOS), ELABORACIÓN DE SOBRES, AEROGRAMAS, CARTAS Y TARJETAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (664,'C170924','FABRICACIÓN DE REGISTROS, LIBROS DE CONTABILIDAD, CUADERNOS Y ARTÍCULOS DE PAPELERÍA SIMILARES DE USO EDUCATIVO O COMERCIAL, CUANDO LA INFORMACIÓN IMPRESA NO CONSTITUYA SU CARACTERÍSTICA PRINCIPAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (665,'C170925','FABRICACIÓN DE CAJAS, BOLSAS (FUNDAS), CARPETAS Y JUEGOS DE ESCRITORIO QUE CONTENGAN UNA VARIEDAD DE ARTÍCULOS DE PAPELERÍA, RECADOS DE ESCRIBIR QUE CONTIENEN PAPEL PARA CORRESPONDENCIA, ESQUELAS O TARJETAS POSTALES EN BLANCO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (666,'C170929','FABRICACIÓN DE OTROS ARTÍCULOS DE PAPEL O CARTÓN: ETIQUETAS IMPRESAS O SIN IMPRIMIR, ARTÍCULOS DE FANTASÍA DE PAPEL, ARTÍCULOS PROMOCIONALES Y DE REGALO DE PAPEL, PAPEL Y CARTÓN FILTRO, CUERDAS Y CORDAJES DE PAPEL, PAPEL PARA CIGARRILLO, PAPEL REGALO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (667,'C17093','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS ARTÍCULOS DEL PAPEL Y CARTÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (668,'C170930','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS ARTÍCULOS DEL PAPEL Y CARTÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (669,'C18','IMPRESIÓN Y REPRODUCCIÓN DE GRABACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (670,'C181','IMPRESIÓN Y ACTIVIDADES DE SERVICIOS RELACIONADOS CON LA IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (671,'C1811','ACTIVIDADES DE IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (672,'C18110','ACTIVIDADES DE IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (673,'C181101','ACTIVIDADES DE IMPRESIÓN DE PERIÓDICOS, REVISTAS Y OTRAS PUBLICACIONES PERIÓDICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (674,'C181102','ACTIVIDADES DE IMPRESIÓN DE LIBROS, DICCIONARIOS, ENCICLOPEDIAS Y FOLLETOS, MANUSCRITOS MUSICALES Y PARTITURA, MAPAS, ATLAS, CARTELES, ETCÉTERA; MEDIANTE IMPRESIÓN POR OFFSET, FOTOGRABACIÓN, IMPRESIÓN FLEXOGRÁFICA E IMPRESIÓN EN OTROS TIPOS DE PRENSA, MAQUINAS AUTOCOPISTAS, IMPRESORAS ESTAMPADORAS, ETCÉTERA, INCLUIDA LA IMPRESIÓN RÁPIDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (675,'C181103','ACTIVIDADES DE IMPRESIÓN DE SELLOS DE CORREO, ESTAMPILLAS Y TIMBRES FISCALES, DOCUMENTOS DE TÍTULOS, BOLETOS DE ENTRADAS A ESPECTÁCULOS, CHEQUES Y OTROS VALORES O DOCUMENTOS DE GARANTÍA Y DE SEGURIDAD, MEDIANTE IMPRESIÓN POR OFFSET, FOTOGRABACIÓN, IMPRESIÓN FLEXOGRÁFICA E IMPRESIÓN EN OTROS TIPOS DE PRENSA, MAQUINAS AUTOCOPISTAS, IMPRESORAS ESTAMPADORAS, ETCÉTERA, INCLUIDA LA IMPRESIÓN RÁPIDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (676,'C181104','ACTIVIDADES DE IMPRESIÓN DE PÓSTERS, GIGANTOGRAFÍAS, CATÁLOGOS DE PUBLICIDAD, PROSPECTOS Y OTROS IMPRESOS PUBLICITARIOS, CALENDARIOS, FORMULARIOS COMERCIALES, DIRECTORIOS Y OTROS MATERIALES IMPRESOS DE USO COMERCIAL, PAPEL DE CORRESPONDENCIA ÁLBUMES, AGENDAS PERSONALES, DIARIOS, TARJETAS DE INVITACIÓN, DE VISITA, DE PRESENTACIÓN Y OTROS MATERIALES IMPRESOS MEDIANTE IMPRESIÓN POR OFFSET, FOTOGRABACIÓN, IMPRESIÓN FLEXOGRÁFICA E IMPRESIÓN EN OTROS TIPOS DE PRENSA, MAQUINAS AUTOCOPISTAS, IMPRESORAS ESTAMPADORAS, ETCÉTERA, INCLUIDA LA IMPRESIÓN RÁPIDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (677,'C181105','ACTIVIDADES DE IMPRESIÓN DIRECTA EN TEXTILES, PLÁSTICOS, VIDRIO, METAL, MADERA Y CERÁMICA (EXCEPTO SERIGRAFÍA SOBRE TEXTILES O PRENDAS DE VESTIR).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (678,'C181106','ACTIVIDADES DE IMPRESIÓN EN ETIQUETAS O MARBETES (POR PROCEDIMIENTOS LITOGRÁFICOS, DE ROTOGRABADO, FLEXOGRÁFICOS, U OTROS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (679,'C1812','ACTIVIDADES DE SERVICIOS RELACIONADOS CON LA IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (680,'C18120','ACTIVIDADES DE SERVICIOS RELACIONADOS CON LA IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (681,'C181201','ACTIVIDADES DE ENCUADERNACIÓN DE HOJAS IMPRESAS PARA CONFECCIONAR LIBROS, FOLLETOS, REVISTAS, CATÁLOGOS ETCÉTERA, MEDIANTE EL COLADO, CORTADO, ENSAMBLADO, ENGOMADO, COMPAGINADO, HILVANADO (COSIDO), ENCUADERNADO CON ADHESIVO, RECORTADO, ESTAMPADO EN ORO, ENCUADERNACIÓN ESPIRAL, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (682,'C181202','ACTIVIDADES DE SERVICIOS DE PREPARACIÓN DE PLACAS, PLANCHAS Y TINTES PARA EL ESTAMPADO Y LA IMPRESIÓN E IMPRESIÓN EN RELIEVE (INCLUIDAS PLANCHAS DE FOTOPOLÍMEROS), PREPARACIÓN DE LA COMPOSICIÓN DE IMÁGENES Y PLACAS PARA IMPRENTAS TIPOGRÁFICAS Y DE OFFSET. COMPOSICIÓN TIPOGRAFÍA, FOTOCOMPOSICIÓN, LA INCORPORACIÓN DE DATOS ANTES DE LA IMPRESIÓN, INCLUSO MEDIANTE EL ESCANEO Y RECONOCIMIENTO ÓPTICO DE CARACTERES, COMPAGINACIÓN ELECTRÓNICA Y GRABADO DE CILINDROS PARA ROTOGRABADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (683,'C181203','ACTIVIDADES DE DISEÑO DE PRODUCTOS IMPRESOS POR EJEMPLO BOCETOS, DIAGRAMAS, PATRONES, CROQUIS, MAQUETAS, ETCÉTERA, PRODUCCIÓN DE PRUEBAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (684,'C181204','ACTIVIDADES DE PRODUCCIÓN DE OBRAS ARTÍSTICAS INCLUSO PIEDRAS LITOGRÁFICAS Y PLANCHAS DE MADERA PREPARADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (685,'C181205','ACTIVIDADES DE PRODUCCIÓN DE PRODUCTOS DE REPROGRAFÍA (COPIADORA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (686,'C181206','ACTIVIDADES DE SERVICIOS COMBINADOS DE IMPRESIÓN DE TEXTO E IMÁGENES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (687,'C181207','ACTIVIDADES GRAFICAS, COMO EL ESTAMPADO EN HUECO Y ESTAMPADO A TROQUEL, IMPRESIÓN DE LIBROS BRAILLE, TROQUELADO Y PERFORADO, ESTAMPADO EN RELIEVE, BARNIZADO Y LAMINADO, ALZADO, ENCARTACIÔN Y PLEGADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (688,'C181209','OTROS ACTIVIDADES DE SERVICIOS RELACIONADOS CON LA IMPRESIÓN: SERVICIOS DE PREPARACIÓN DE DATOS DIGITALES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (689,'C182','REPRODUCCIÓN DE GRABACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (690,'C1820','REPRODUCCIÓN DE GRABACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (691,'C18200','REPRODUCCIÓN DE GRABACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (692,'C182001','ACTIVIDADES DE REPRODUCCIÓN A PARTIR DE COPIAS MATRICES (ORIGINALES) DE: DISCOS GRAMOFÓNICOS, DISCOS COMPACTOS Y CINTAS CON MÚSICA U OTRAS GRABACIONES DE SONIDO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (693,'C182002','ACTIVIDADES DE REPRODUCCIÓN DE COPIAS MATRICES (ORIGINALES) DE DISCOS, DISCOS COMPACTOS, CINTAS CON PELÍCULAS Y OTRAS GRABACIONES DE VIDEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (694,'C182003','ACTIVIDADES DE REPRODUCCIÓN A PARTIR DE COPIAS MATRICES DE PROGRAMAS INFORMÁTICOS Y DATOS EN DISCOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (695,'C19','FABRICACIÓN DE COQUE Y DE PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (696,'C191','FABRICACIÓN DE PRODUCTOS DE HORNO DE COQUE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (697,'C1910','FABRICACIÓN DE PRODUCTOS DE HORNO DE COQUE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (698,'C19100','FABRICACIÓN DE PRODUCTOS DE HORNO DE COQUE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (699,'C191001','EXPLOTACIÓN DE HORNOS DE COQUE PARA LA PRODUCCIÓN DE COQUE O SEMICOQUE, BREA Y COQUE DE BREA, ALQUITRANES DE HULLA Y LIGNITO CRUDOS, GAS DE HORNO DE COQUE, CARBÓN DE RETORTA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (700,'C191002','AGLOMERACIÓN DE COQUE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (701,'C191003','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS DE HORNO DE COQUE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (702,'C192','FABRICACIÓN DE PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (703,'C1920','FABRICACIÓN DE PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (704,'C19200','FABRICACIÓN DE PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (705,'C192001','PRODUCCIÓN DE COMBUSTIBLES PARA MOTORES: GASOLINA, QUEROSENO ETCÉTERA; FUELOIL LIGERO, MEDIO Y PESADO, GASES DE REFINERÍA COMO ETANO, BUTANO O PROPANO, ETCÉTERA, RECUPERACIÓN DE GASES DE PETRÓLEO LICUADOS EN EL REFINAMIENTO DE PETRÓLEO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (706,'C192002','FABRICACIÓN DE ACEITES O GRASAS LUBRICANTES A BASE DE PETRÓLEO, INCLUIDO LOS FABRICADOS A PARTIR DE RESIDUOS DEL PETRÓLEO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (707,'C192003','FABRICACIÓN DE PRODUCTOS PARA LA INDUSTRIA PETROQUÍMICA Y PARA LA FABRICACIÓN DE PAVIMENTOS DE CARRETERAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (708,'C192004','FABRICACIÓN DE BRIQUETAS DE CARBÓN DE PIEDRA Y LIGNITO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (709,'C192005','FABRICACIÓN DE BIOCOMBUSTIBLES, ES DECIR LA MEZCLA DE ALCOHOLES CON PETRÓLEO POR EJEMPLO: GASOHOL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (710,'C192006','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (711,'C192009','FABRICACIÓN DE OTROS PRODUCTOS DE LA REFINACIÓN DEL PETRÓLEO: BENCINA MINERAL (AGUARRÁS), VASELINA, CERA DE PARAFINA, JALEA DE PETRÓLEO (PETROLATO), BRIQUETAS DE PETRÓLEO ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (712,'C20','FABRICACIÓN DE SUBSTANCIAS Y PRODUCTOS QUÍMICOS.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (713,'C201','FABRICACIÓN DE SUSTANCIAS QUÍMICAS BÁSICAS, DE ABONOS Y COMPUESTOS DE NITRÓGENO Y DE PLÁSTICOS Y CAUCHO SINTÉTICO EN FORMAS PRIMARIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (714,'C2011','FABRICACIÓN DE SUBSTANCIAS QUÍMICAS BÁSICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (715,'C20111','FABRICACIÓN DE GASES INDUSTRIALES, ELEMENTOS QUÍMICOS Y ÁCIDOS INORGÁNICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (716,'C201111','FABRICACIÓN DE GASES INDUSTRIALES O MÉDICOS INORGÁNICOS, LICUADOS O COMPRIMIDOS: GASES ELEMENTALES, AIRE LÍQUIDO O COMPRIMIDO (OXIGENO), GASES REFRIGERANTES, MEZCLAS DE GASES INDUSTRIALES (GASES CARBÓNICOS), GASES INERTES COMO EL DIÓXIDO DE CARBONO (ANHÍDRIDO CARBÓNICO), GASES AISLANTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (717,'C201112','FABRICACIÓN DE ÁLCALIS, LEJÍAS Y OTRAS BASES INORGÁNICAS EXCEPTO AMONÍACO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (718,'C201113','ELABORACIÓN DE ELEMENTOS QUÍMICOS (EXCEPTO GASES INDUSTRIALES Y METALES BÁSICOS).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (719,'C201114','FABRICACIÓN DE ÁCIDOS INORGÁNICOS EXCEPTO ACIDO NÍTRICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (720,'C201119','FABRICACIÓN DE OTROS COMPUESTOS QUÍMICOS INORGÁNICOS ( COMO CLORO DOMÉSTICO).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (721,'C20112','FABRICACIÓN DE SUSTANCIAS QUÍMICAS ORGÁNICAS BÁSICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (722,'C201121','FABRICACIÓN DE ALCOHOLES CÍCLICOS Y ACÍCLICOS, FENOLES Y FENOLES-ALCOHOLES, SORBITOL, METANOL Y ALCOHOLES SUPERIORES (INCLUSO ALCOHOL ETÍLICO SINTÉTICO).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (723,'C201122','FABRICACIÓN DE COMPUESTOS ORGÁNICOS DE FUNCIÓN NITRÓGENO, INCLUSO AMINAS (CUERPO DERIVADO DEL AMONÍACO) Y COMPUESTOS DE FUNCIÓN NITRILO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (724,'C201123','FABRICACIÓN DE HIDROCARBUROS CÍCLICOS Y ACÍCLICOS, SATURADOS Y NO SATURADOS, BENCENO, TOLUENO, XILENO Y OTROS PRODUCTOS DE LA DESTILACIÓN DE ALQUITRÁN, HULLA O ACEITE MINERAL, PRODUCCIÓN DE BREA Y COQUE DE BREA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (725,'C201124','FABRICACIÓN DE ÁCIDOS MONOCARBOXÍLICOS Y POLICARBOXÍLICOS, INCLUIDO ACIDO ACÉTICO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (726,'C201125','FERMENTACIÓN DE CAÑA DE AZÚCAR, MAÍZ O SIMILARES PARA PRODUCIR ALCOHOL Y ESTERES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (727,'C201126','FABRICACIÓN DE COMPUESTOS DE FUNCIÓN OXIGENO, INCLUSO ALDEHÍDOS, CETONAS, QUINONAS Y COMPUESTOS DUALES O MÚLTIPLES DE FUNCIÓN OXÍGENO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (728,'C201127','FABRICACIÓN DE CARBÓN VEGETAL Y OTROS PRODUCTOS DE LA DESTILACIÓN DE MADERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (729,'C201129','FABRICACIÓN DE OTROS COMPUESTOS ORGÁNICOS, GLICERINA SINTÉTICA, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (730,'C20113','SERVICIOS DE APOYO A LA FABRICACIÓN DE SUBSTANCIAS QUÍMICAS BÁSICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (731,'C201130','SERVICIOS DE APOYO A LA FABRICACIÓN DE SUBSTANCIAS QUÍMICAS BÁSICAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (732,'C20119','FABRICACIÓN DE OTRAS SUSTANCIAS QUÍMICAS BÁSICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (733,'C201191','FABRICACIÓN DE MATERIAS COLORANTES, TINTES Y PIGMENTOS DE CUALQUIER ORIGEN EN FORMA BÁSICA O COMO CONCENTRADO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (734,'C201192','FABRICACIÓN DE PRODUCTOS USADOS COMO AGENTES AVIVADORES FLUORESCENTES O COMO LUMINÓFOROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (735,'C201193','FABRICACIÓN DE PRODUCTOS AROMÁTICOS SINTÉTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (736,'C201194','FABRICACIÓN DE PRODUCTOS CURTIENTES SINTÉTICOS Y DE ORIGEN VEGETAL O ANIMAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (737,'C201195','ACTIVIDADES DE ENRIQUECIMIENTO DE MINERALES DE URANIO, PLUTONIO, TORIO Y PRODUCCIÓN DE ELEMENTOS COMBUSTIBLES PARA REACTORES NUCLEARES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (738,'C201196','FABRICACIÓN DE AGUA DESTILADA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (739,'C201197','ACTIVIDADES DE TOSTADO DE PIRITAS DE HIERRO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (740,'C2012','FABRICACIÓN DE ABONOS Y COMPUESTOS DE NITRÓGENO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (741,'C20120','FABRICACIÓN DE ABONOS Y COMPUESTOS DE NITRÓGENO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (742,'C201201','FABRICACIÓN DE ABONOS NITROGENADOS, FOSFATADOS Y POTÁSICOS PUROS O COMPLEJOS; UREA, FOSFATOS NATURALES EN CRUDO Y SALES DE POTASIO NATURALES CRUDAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (743,'C201202','FABRICACIÓN DE PRODUCTOS NITROGENADOS CONEXOS: ACIDO NÍTRICO Y SULFONÍTRICO, AMONÍACO, CLORURO DE AMONIO, CARBONATO DE AMONIO, NITRITOS Y NITRATOS DE POTASIO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (744,'C201203','FABRICACIÓN DE SUSTRATOS (TIERRA PARA MACETAS) HECHOS PRINCIPALMENTE DE TURBA; DE MEZCLAS DE TIERRA NATURAL, ARENA, ARCILLA Y MINERALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (745,'C201204','SERVICIOS DE APOYO A LA FABRICACIÓN DE ABONOS Y COMPUESTOS DE NITRÓGENO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (746,'C2013','FABRICACIÓN DE PLÁSTICOS Y CAUCHOS SINTÉTICOS EN FORMAS PRIMARIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (747,'C20131','FABRICACIÓN DE PLÁSTICOS EN FORMAS PRIMARIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (748,'C201311','FABRICACIÓN DE PLÁSTICOS EN FORMAS PRIMARIAS: POLÍMEROS, INCLUIDOS LOS POLÍMEROS DE ETILENO, PROPILENO, ESTIRENO, CLORURO DE VINILLO, ACETATO DE VINILLO Y ACRÍLICOS; POLIAMIDAS, RESINAS FENÓLICAS Y EPOXÍDICAS Y POLIURETANOS, RESINAS ALQUÍDICAS Y RESINAS DE POLIÉSTER Y POLIÉSTERES, SILICONAS, INTERCAMBIADORES DE IONES BASADOS EN POLÍMEROS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (749,'C201312','FABRICACIÓN DE CELULOSA Y SUS DERIVADOS QUÍMICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (750,'C20132','FABRICACIÓN DE CAUCHO SINTÉTICO EN FORMAS PRIMARIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (751,'C201321','FABRICACIÓN DE CAUCHO SINTÉTICO EN FORMAS PRIMARIAS: CAUCHO SINTÉTICO, ARTIFICIAL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (752,'C201322','FABRICACIÓN DE ACEITE VEGETAL VULCANIZADO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (753,'C201323','FABRICACIÓN DE MEZCLAS DE CAUCHO SINTÉTICO Y CAUCHO NATURAL O GOMAS SIMILARES AL CAUCHO (BALATA).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (754,'C20133','SERVICIOS DE APOYO A LA FABRICACIÓN DE PLÁSTICOS Y DE CAUCHOS SINTÉTICO EN FORMAS PRIMARIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (755,'C201330','SERVICIOS DE APOYO A LA FABRICACIÓN DE PLÁSTICOS Y DE CAUCHOS SINTÉTICO EN FORMAS PRIMARIAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (756,'C202','FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (757,'C2021','FABRICACIÓN DE PLAGUICIDAS Y OTROS PRODUCTOS QUÍMICOS DE USO AGROPECUARIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (758,'C20210','FABRICACIÓN DE PLAGUICIDAS Y OTROS PRODUCTOS QUÍMICOS DE USO AGROPECUARIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (759,'C202101','FABRICACIÓN DE INSECTICIDAS, RATICIDAS, FUNGICIDAS, HERBICIDAS, ANTIGERMINANTES, REGULADORES DEL CRECIMIENTO DE LAS PLANTAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (760,'C202102','FABRICACIÓN DE DESINFECTANTES DE USO AGROPECUARIO Y PARA OTROS USOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (761,'C202103','SERVICIOS DE APOYO A LA FABRICACIÓN DE PLAGUICIDAS Y OTROS PRODUCTOS QUÍMICOS DE USO AGROPECUARIO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (762,'C202109','FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS DE USO AGROPECUARIO N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (763,'C2022','FABRICACIÓN DE PINTURAS, BARNICES Y PRODUCTOS DE REVESTIMIENTO SIMILARES, TINTAS DE IMPRENTA Y MASILLAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (764,'C20220','FABRICACIÓN DE PINTURAS, BARNICES Y PRODUCTOS DE REVESTIMIENTO SIMILARES, TINTAS DE IMPRENTA Y MASILLAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (765,'C202201','FABRICACIÓN DE PINTURAS, BARNICES, ESMALTES O LACAS PIGMENTOS Y TINTES, OPACIFICADORES Y COLORES PREPARADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (766,'C202202','FABRICACIÓN DE ESMALTES VITRIFICABLES Y BARNICES PARA VIDRIAR Y ENLUCIDOS CERÁMICOS Y PREPARADOS SIMILARES; PIGMENTOS Y TINTES, OPACIFICADORES Y COLORES PREPARADOS','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (767,'C202203','FABRICACIÓN DE MASILLAS, COMPUESTOS PARA CALAFATEAR Y PREPARADOS SIMILARES NO REFRACTARIOS PARA RELLENO Y ENLUCIDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (768,'C202204','FABRICACIÓN DE DISOLVENTES Y DILUYENTES COMPUESTOS ORGÁNICOS: DECAPANTES (REMOVEDORES) DE PINTURA Y BARNIZ PREPARADOS (THIÑER).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (769,'C202205','FABRICACIÓN DE TINTA DE IMPRENTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (770,'C202206','SERVICIOS DE APOYO A LA FABRICACIÓN DE PINTURAS, BARNICES Y PRODUCTOS DE REVESTIMIENTO SIMILARES, TINTAS DE IMPRENTA Y MASILLAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (771,'C2023','FABRICACIÓN DE JABONES Y DETERGENTES, PREPARADOS PARA LIMPIAR Y PULIR, PERFUMES Y PREPARADOS DE TOCADOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (772,'C20231','FABRICACIÓN DE JABONES Y DETERGENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (773,'C202311','FABRICACIÓN DE AGENTES ORGÁNICOS TENSOACTIVOS Y PREPARADOS TENSOACTIVOS (DETERGENTES) PARA LAVAR EN POLVO O LÍQUIDOS; BARRAS (JABÓN), PASTILLAS, PIEZAS, PREPARADOS PARA FREGAR PLATOS (LAVAVAJILLAS); SUAVIZANTES TEXTILES, INCLUIDO JABÓN COSMÉTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (774,'C202312','FABRICACIÓN DE PAPEL, GUATA, FIELTRO Y OTROS MATERIALES IMPREGNADOS, REVESTIDOS O RECUBIERTOS CON JABÓN O DETERGENTES; INCLUSO FABRICACIÓN DE GLICERINA EN BRUTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (775,'C20232','FABRICACIÓN PREPARADOS PARA LIMPIAR Y PULIR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (776,'C202321','FABRICACIÓN DE PRODUCTOS DE LIMPIEZA: PREPARADOS PARA PERFUMAR Y DESODORIZAR AMBIENTES, POLVOS O PASTAS DE LIMPIEZA INCLUIDOS PAPEL, GUATA, ETCÉTERA, REVESTIDO O RECUBIERTO CON ESTOS PRODUCTOS DE LIMPIEZA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (777,'C202322','FABRICACIÓN DE PRODUCTOS PARA PULIR Y ABRILLANTAR: CERAS ARTIFICIALES Y CERAS PREPARADAS, LUSTRES Y CREMAS PARA CUERO, LUSTRES Y CREMAS PARA MADERA, LUSTRES PARA CARROCERÍAS DE AUTOMÓVILES, VIDRIO Y METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (778,'C20233','FABRICACIÓN DE PERFUMES Y PREPARADOS DE TOCADOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (779,'C202331','FABRICACIÓN DE PERFUMES Y COSMÉTICOS: PERFUMES Y AGUAS DE COLONIA, PREPARADOS DE BELLEZA Y DE MAQUILLAJE, CREMAS SOLARES Y PREPARADOS BRONCEADORES, PREPARADOS PARA MANICURA Y PEDICURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (780,'C202332','FABRICACIÓN DE PRODUCTOS PARA PELUQUERÍA Y CUIDADO DEL CABELLO: CHAMPÚ, TINTES, LACAS PARA EL CABELLO, PREPARADOS PARA ONDULAR Y ALISAR EL CABELLO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (781,'C202339','FABRICACIÓN DE OTROS PRODUCTOS DE PERFUMERÍA Y TOCADOR: DENTÍFRICO Y PREPARADOS DE HIGIENE BUCAL Y DENTAL, INCLUIDO PREPARADOS PARA LA FIJACIÓN DE DENTADURAS POSTIZAS, PREPARADOS PARA EL AFEITADO, INCLUSO PARA ANTES Y DESPUÉS DE AFEITAR; DESODORANTES Y SALES DE BAÑO; DEPILADORES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (782,'C20234','SERVICIOS DE APOYO A LA FABRICACIÓN DE JABONES Y DETERGENTES, PREPARADOS PARA LIMPIAR Y PULIR, PERFUMES Y PREPARADOS DE TOCADOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (783,'C202340','SERVICIOS DE APOYO A LA FABRICACIÓN DE JABONES Y DETERGENTES, PREPARADOS PARA LIMPIAR Y PULIR, PERFUMES Y PREPARADOS DE TOCADOR A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (784,'C2029','FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS N.C.P.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (785,'C20291','FABRICACIÓN DE PRODUCTOS QUÍMICOS PARA USOS INDUSTRIALES N.C.P.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (786,'C202911','FABRICACIÓN DE GRASAS Y ACEITES MODIFICADOS QUÍMICAMENTE; ACEITES ESENCIALES; RESINOIDES, AGUAS DESTILADAS AROMÁTICAS; FABRICACIÓN DE MEZCLAS DE PRODUCTOS ODORÍFEROS PARA LA ELABORACIÓN DE PERFUMES O ALIMENTOS; FABRICACIÓN DE EXTRACTOS DE PRODUCTOS AROMÁTICOS NATURALES.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (787,'C202912','FABRICACIÓN DE CARBÓN ACTIVADO, ADITIVOS PARA ACEITES LUBRICANTES, PREPARADOS PARA ACELERAR LA VULCANIZACIÓN DEL CAUCHO, CATALIZADORES; PREPARADOS ADITIVOS PARA CEMENTOS Y OTROS PRODUCTOS QUÍMICOS DE USO INDUSTRIAL.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (788,'C202913','FABRICACIÓN DE MATERIALES PARA EL ACABADO DE PRODUCTOS TEXTILES Y DE CUERO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (789,'C202914','FABRICACIÓN DE PREPARADOS ANTIDETONANTES, ANTICONGELANTES, LÍQUIDOS PARA TRANSMISIONES HIDRÁULICAS.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (790,'C202915','FABRICACIÓN DE REACTIVOS COMPUESTOS PARA DIAGNÓSTICO Y LABORATORIO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (791,'C202916','FABRICACIÓN DE GELATINA Y DERIVADOS DE LA GELATINA, PEGAMENTO (COLAS) Y PREPARADOS ADHESIVOS, INCLUYENDO PEGAMENTO Y ADHESIVO A BASE DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (792,'C20292','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS N.C.P.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (793,'C202920','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (794,'C20299','FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS N.C.P.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (795,'C202991','FABRICACIÓN DE EXPLOSIVOS Y PRODUCTOS PIROTÉCNICOS, INCLUIDOS CÁPSULAS FULMINANTES, DETONADORES, BENGALAS DE SEÑALES Y ARTÍCULOS SIMILARES, PÓLVORAS PROPULSORAS, CERILLAS (FÓSFOROS).','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (796,'C202992','FABRICACIÓN DE PRODUCTOS FOTOQUÍMICOS: PLACAS Y PELÍCULAS FOTOGRÁFICAS, PAPEL SENSIBLE Y OTROS MATERIALES SENSIBILIZADOS SIN IMPRIMIR; FABRICACIÓN DE PREPARADOS QUÍMICOS DE USO FOTOGRÁFICO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (797,'C202993','FABRICACIÓN DE TINTAS PARA ESCRIBIR Y DIBUJAR.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (798,'C202994','FABRICACIÓN DE GRANADAS Y BOMBAS EXTINTORAS DE FUEGO, PREPARACIÓN Y CARGA DE APARATOS EXTINTORES.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (799,'C202999','FABRICACIÓN DE OTROS PRODUCTOS QUÍMICOS: PEPTONAS Y SUS DERIVADOS, OTRAS SUSTANCIAS PROTEÍNICAS Y SUS DERIVADOS; SUBSTANCIAS PARA EL DECAPADO DE METALES; POLVOS Y PASTAS PARA SOLDADURA BLANDA, DURA O AUTÓGENA.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (800,'C203','FABRICACIÓN DE FIBRAS ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (801,'C2030','FABRICACIÓN DE FIBRAS ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (802,'C20300','FABRICACIÓN DE FIBRAS ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (803,'C203001','FABRICACIÓN DE ESTOPAS DE FILAMENTO ARTIFICIAL O SINTÉTICO (WAIPE).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (804,'C203002','FABRICACIÓN DE FIBRAS DISCONTINUAS SINTÉTICAS O ARTIFICIALES, SIN CARDAR, PEINAR NI ELABORAR DE OTRO MODO PARA SU HILADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (805,'C203003','FABRICACIÓN DE HILADOS (HILOS) DE FILAMENTO SINTÉTICO O ARTIFICIAL, INCLUIDOS HILADOS (HILOS) DE GRAN RESISTENCIA, MONOFILAMENTO O HEBRAS SINTÉTICAS O ARTIFICIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (806,'C203004','SERVICIOS DE APOYO A LA FABRICACIÓN DE FIBRAS ARTIFICIALES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (807,'C21','FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS, SUSTANCIAS QUÍMICAS MEDICINALES Y PRODUCTOS BOTÁNICOS DE USO FARMACÉUTICO.','S',0.19,'N',0.00,'S',0.58,'S',0.02,'S',0.08,0.87,8.90,'A'),
	 (808,'C210','FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS, SUSTANCIAS QUÍMICAS MEDICINALES Y PRODUCTOS BOTÁNICOS DE USO FARMACÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (809,'C2100','FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS, SUSTANCIAS QUÍMICAS MEDICINALES Y PRODUCTOS BOTÁNICOS DE USO FARMACÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (810,'C21000','FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS, SUBSTANCIAS QUÍMICAS MEDICINALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (811,'C210001','FABRICACIÓN DE SUSTANCIAS MEDICINALES ACTIVAS QUE SE UTILIZAN POR SUS PROPIEDADES FARMACOLÓGICAS EN LA FABRICACIÓN DE MEDICAMENTOS: ANTIBIÓTICOS, VITAMINAS BÁSICAS, ÁCIDO SALICÍLICO Y ACETILSALICÍLICO, ETCÉTERA, TRATAMIENTO DE LA SANGRE, FABRICACIÓN DE MEDICAMENTOS: ANTISUEROS Y OTRAS FRACCIONES DE SANGRE, AZÚCARES QUÍMICAMENTE PUROS, PRODUCTOS Y EXTRACTOS ENDOCRINOS,  VACUNAS. INCLUIDOS PREPARADOS HOMEOPÁTICOS, FABRICACIÓN Y PROCESAMIENTO DE GLÁNDULAS Y EXTRACTOS GLANDULARES, FABRICACIÓN DE PRODUCTOS QUÍMICOS ANTICONCEPTIVOS DE USO EXTERNO Y DE MEDICAMENTOS ANTICONCEPTIVOS HORMONALES, FABRICACIÓN DE PREPARADOS PARA EL DIAGNÓSTICO MÉDICO, INCLUIDAS PRUEBAS DE EMBARAZO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (812,'C210002','FABRICACIÓN DE SUSTANCIAS RADIACTIVAS PARA DIAGNÓSTICO EN VIVO, ETCÉTERA, PRODUCTOS DE BIOTECNOLOGÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (813,'C210003','FABRICACIÓN DE GUATAS, GASAS, HILOS, VENDAS Y APÓSITOS MÉDICOS IMPREGNADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (814,'C210004','PREPARACIÓN DE PRODUCTOS BOTÁNICOS (TRITURACIÓN, CRIBADO, MOLIDO) PARA USO FARMACÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (815,'C210005','FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS PARA USO VETERINARIO, SEAN GENÉRICOS O DE MARCA REGISTRADA, DE VENTA AL PÚBLICO EN GENERAL O REGLAMENTADA POR LAS AUTORIDADES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (816,'C210006','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS FARMACÉUTICOS, SUSTANCIAS QUÍMICAS MEDICINALES Y PRODUCTOS BOTÁNICOS DE USO FARMACÉUTICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (817,'C22','FABRICACIÓN DE PRODUCTOS DE CAUCHO Y PLÁSTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (818,'C221','FABRICACIÓN DE PRODUCTOS DE CAUCHO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (819,'C2211','FABRICACIÓN DE CUBIERTAS Y CÁMARAS DE CAUCHO; RECAUCHUTADO Y RENOVACIÓN DE CUBIERTAS DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (820,'C22110','FABRICACIÓN DE CUBIERTAS Y CÁMARAS DE CAUCHO; RECAUCHUTADO Y RENOVACIÓN DE CUBIERTAS DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (821,'C221101','FABRICACIÓN DE CUBIERTAS DE CAUCHO PARA: VEHÍCULOS, EQUIPO, MAQUINARIA MÓVIL, AERONAVES, JUGUETES, MUEBLES Y OTROS USOS: NEUMÁTICOS, LLANTAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (822,'C221102','FABRICACIÓN DE BANDAS DE RODADURA INTERCAMBIABLES, CÁMARAS PARA CUBIERTAS, FAJAS DE PROTECCIÓN DE LA CÁMARA, TIRAS DE REMIENDO PARA RECAUCHUTAR CUBIERTAS, ETCÉTERA, RENOVACIÓN Y RECAUCHUTADO DE CUBIERTAS DE NEUMÁTICOS SEAN CUBIERTAS SÓLIDAS Y MULLIDAS (ESPONJOSAS, BLANDAS).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (823,'C221103','SERVICIOS DE APOYO A LA FABRICACIÓN DE CUBIERTAS Y CÁMARAS DE CAUCHO; RECAUCHUTADO Y RENOVACIÓN DE CUBIERTAS DE CAUCHO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (824,'C2219','FABRICACIÓN DE OTROS PRODUCTOS DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (825,'C22190','FABRICACIÓN DE OTROS PRODUCTOS DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (826,'C221901','FABRICACIÓN DE PLANCHAS, HOJAS, TIRAS, VARILLAS Y PERFILES; TUBOS, CAÑOS Y MANGUERAS; ARANDELAS, EMPAQUES, CONECTORES, Y CIERRES DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (827,'C221902','FABRICACIÓN DE CORREAS Y CINTAS TRANSPORTADORAS Y DE TRANSMISIÓN DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (828,'C221903','FABRICACIÓN DE ARTÍCULOS HIGIÉNICOS Y CUIDADO PERSONAL DE CAUCHO: CEPILLOS DE CAUCHO, PEINES DE CAUCHO DURO, HORQUILLAS, RULOS Y ARTÍCULOS SIMILARES DE CAUCHO ENDURECIDO; PRESERVATIVOS, TETINAS, BOLSAS DE AGUA CALIENTE, ETCÉTERA, INCLUIDO LA FABRICACIÓN DE ARTÍCULOS ERÓTICOS DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (829,'C221904','FABRICACIÓN DE PRENDAS DE VESTIR DE CAUCHO (SOLO SI ESTÁN SELLADOS, Y NO COSIDOS): TRAJES DE BUCEO DE CAUCHO, GORRAS DE BAÑO, GUANTES Y DELANTALES DE CAUCHO, LIGAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (830,'C221905','FABRICACIÓN DE HILOS, CUERDAS, HILATURA, TEJIDOS DE CAUCHO, TEJIDOS TEXTILES IMPREGNADOS, REVESTIDOS, RECUBIERTOS O LAMINADOS DE CAUCHO EN LOS QUE EL CAUCHO ES EL PRINCIPAL COMPONENTE, CUBIERTAS DE CAUCHO PARA RODILLOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (831,'C221906','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS DE CAUCHO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (832,'C221909','FABRICACIÓN DE OTROS PRODUCTOS DE CAUCHO NATURAL O SINTÉTICO SIN VULCANIZAR, VULCANIZADO O ENDURECIDO: COLCHONES INFLABLES DE CAUCHO, COLCHONES DE CAUCHO PARA CAMAS DE AGUA, GLOBOS INFLABLES, CAÑONES DE PIPA DE CAUCHO ENDURECIDO, PARTES DE CALZADO DE CAUCHO, MATERIALES DE REPARACIÓN DE CAUCHO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (833,'C222','FABRICACIÓN DE PRODUCTOS DE PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (834,'C2220','FABRICACIÓN DE PRODUCTOS DE PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (835,'C22201','FABRICACIÓN DE PLACAS, HOJAS, TUBOS Y PERFILES DE PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (836,'C222011','FABRICACIÓN DE SEMIMANUFACTURAS (SEMIELABORADAS) DE PRODUCTOS DE PLÁSTICO: PLANCHAS, LÁMINAS, PELÍCULAS, HOJAS, TIRAS, ETCÉTERA (AUTOADHESIVAS O NO); LÁMINAS DE ACRÍLICOS, ESPONJA, ESPÚMAFLEX, PELÍCULA O LÁMINA DE CELOFÁN, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (837,'C222012','FABRICACIÓN DE PRODUCTOS ACABADOS DE PLÁSTICOS: TUBOS, CAÑOS Y MANGUERAS DE PLÁSTICO, ACCESORIOS PARA TUBERÍAS, CAÑOS Y MANGUERAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (838,'C22202','FABRICACIÓN DE PRODUCTOS DE PLÁSTICO PARA LA CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (839,'C222021','FABRICACIÓN DE ARTÍCULOS PLÁSTICOS PARA LA CONSTRUCCIÓN: PUERTAS, VENTANAS, MARCOS, CONTRAPUERTAS, PERSIANAS, ZÓCALOS, TANQUES PARA DEPÓSITOS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (840,'C222022','FABRICACIÓN DE CUBRIMIENTOS PLÁSTICOS PARA PISOS, PAREDES O TECHOS EN ROLLOS O EN FORMA DE LOSETAS, DOMOS, PIEDRA ARTIFICIAL (MÁRMOL ARTIFICIAL); CUBRIMIENTOS DE PISOS RESISTENTES, COMO VINILO, LINÓLEO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (841,'C222023','FABRICACIÓN DE ARTÍCULOS PLÁSTICOS SANITARIOS COMO BAÑERAS, PLATOS DE DUCHA, LAVABOS, INODOROS, CISTERNAS DE INODOROS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (842,'C22203','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS DE PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (843,'C222030','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS DE PLÁSTICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (844,'C22209','FABRICACIÓN DE OTROS PRODUCTOS DE PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (845,'C222091','FABRICACIÓN DE ARTÍCULOS DE PLÁSTICO PARA EL ENVASADO DE PRODUCTOS: BOLSAS, SACOS, CAJONES, CAJAS, GARRAFONES, BOTELLAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (846,'C222092','FABRICACIÓN DE UTENSILIOS DE MESA Y COCINA DE PLÁSTICO Y ARTÍCULOS DE TOCADOR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (847,'C222093','FABRICACIÓN DE ARTÍCULOS DE PLÁSTICO PARA OFICINA Y USO ESCOLAR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (848,'C222094','FABRICACIÓN DE CUBRECABEZAS, PRENDAS DE VESTIR (SÓLO SI LAS PIEZAS SE UNEN POR ADHESIÓN Y NO POR COSTURA).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (849,'C222095','FABRICACIÓN DE PIEZAS DE LÁMPARAS Y ACCESORIOS DE ILUMINACIÓN, ACCESORIOS PARA AISLAMIENTO; LETREROS O SEÑALES NO ELÉCTRICAS DE PLÁSTICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (850,'C222096','FABRICACIÓN DE ACCESORIOS DE PLÁSTICO PARA CARROCERÍAS DE VEHÍCULOS Y ARTÍCULOS SIMILARES DE RESINA DE POLIÉSTER Y FIBRA DE VIDRIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (851,'C222099','FABRICACIÓN DE OTROS ARTÍCULOS DE PLÁSTICO DIVERSOS: ACCESORIOS PARA MUEBLES, ESTATUILLAS, ARTESANÍAS, CORREAS DE TRANSPORTE Y TRANSMISIÓN, CINTAS AUTOADHESIVAS, PAPEL DE EMPAPELAR, HORMAS DE ZAPATO, BOQUILLAS DE CIGARROS Y CIGARRILLOS, PEINES, RULEROS, ARTÍCULOS DE FANTASÍA PROMOCIÓNALES Y DE REGALO DE PLÁSTICO, CANASTAS DE PLÁSTICO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (852,'C23','FABRICACIÓN DE OTROS PRODUCTOS MINERALES NO METÁLICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (853,'C231','FABRICACIÓN DE VIDRIO Y PRODUCTOS DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (854,'C2310','FABRICACIÓN DE VIDRIO Y PRODUCTOS DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (855,'C23101','FABRICACIÓN DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (856,'C231011','FABRICACIÓN DE VIDRIO PLANO, TEMPLADO O LAMINADO, INCLUIDO EL VIDRIO ARMADO DE ALAMBRE, COLOREADO O TEÑIDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (857,'C231012','FABRICACIÓN DE VIDRIO EN MASA, EN ESFERAS (EXCEPTO MICROESFERAS), VARILLAS O TUBOS, SEA O NO LABRADO, PERFILES DE VIDRIO Y VIDRIO LAMINADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (858,'C231013','FABRICACIÓN DE ESPEJOS DE VIDRIO, INCLUIDO ESPEJOS RETROVISORES PARA VEHÍCULOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (859,'C23102','FABRICACIÓN DE PRODUCTOS DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (860,'C231021','FABRICACIÓN DE ARTÍCULOS DOMÉSTICOS DE VIDRIO O CRISTAL: VASOS, BOTELLAS, COPAS, PLATOS, JARRONES Y OTROS RECIPIENTES DE VIDRIO O CRISTAL INCLUIDO PIEZAS DE VIDRIO UTILIZADAS EN BISUTERÍA FIGURILLAS DE VIDRIO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (861,'C231022','FABRICACIÓN DE BLOQUES DE VIDRIO PARA PAVIMENTAR U OTROS ELEMENTOS PARA LA CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (862,'C231023','FABRICACIÓN DE FIBRA DE VIDRIO, INCLUSO LANA DE VIDRIO, Y PRODUCTOS NO TEJIDOS DE LANA DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (863,'C231024','FABRICACIÓN DE CRISTALERÍA DE LABORATORIO: HIGIÉNICA Y FARMACÉUTICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (864,'C231025','FABRICACIÓN DE VIDRIO PARA RELOJES, VIDRIO ÓPTICO Y ELEMENTOS ÓPTICOS NO TRABAJADOS ÓPTICAMENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (865,'C231026','FABRICACIÓN DE AISLADORES DE VIDRIO Y ACCESORIOS AISLANTES DE VIDRIO; UNIDADES AISLANTES DE VIDRIO DE CAPAS MÚLTIPLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (866,'C231029','FABRICACIÓN DE OTROS PRODUCTOS Y MANUFACTURAS DE VIDRIO: AMPOLLAS DE VIDRIO PARA LÁMPARAS, TUBOS PARA LÁMPARAS FLUORESCENTES, ACCESORIOS PARA ALUMBRADO, FAROLES, RÓTULOS ILUMINADOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (867,'C23103','SERVICIOS DE APOYO A LA FABRICACIÓN DE VIDRIO Y PRODUCTOS DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (868,'C231030','SERVICIOS DE APOYO A LA FABRICACIÓN DE VIDRIO Y PRODUCTOS DE VIDRIO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (869,'C239','FABRICACIÓN DE PRODUCTOS MINERALES NO METÁLICOS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (870,'C2391','FABRICACIÓN DE PRODUCTOS REFRACTARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (871,'C23910','FABRICACIÓN DE PRODUCTOS DE CERÁMICA REFRACTARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (872,'C239101','FABRICACIÓN DE ARTÍCULOS PARA CONSTRUCCIÓN: LOSETAS, TEJAS, AZULEJOS Y OTROS DE CERÁMICA REFRACTARIA; MORTEROS, CEMENTOS Y OTROS MATERIALES REFRACTARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (873,'C239102','FABRICACIÓN DE RETORTAS, CRISOLES, MUFLAS (HORNOS), TOBERAS, TUBOS, CAÑOS, ETCÉTERA, DE CERÁMICA REFRACTARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (874,'C239103','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS REFRACTARIOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (875,'C239109','FABRICACIÓN DE OTROS ARTÍCULOS DE CERÁMICA PARA AISLAMIENTO TÉRMICO A BASE DE DIATOMITAS (TIERRAS) SILÍCEAS; ARTÍCULOS REFRACTARIOS QUE CONTIENEN MAGNESITA, DOLOMITA O CROMITA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (876,'C2392','FABRICACIÓN DE MATERIALES DE CONSTRUCCIÓN DE ARCILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (877,'C23920','FABRICACIÓN DE MATERIALES DE CONSTRUCCIÓN DE ARCILLA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (878,'C239201','FABRICACIÓN DE LOSETAS PARA LA PARED Y PARA CAÑONES DE CHIMENEAS, TESELAS DE MOSAICO, AZULEJOS, BALDOSAS Y LOSAS PARA PAVIMENTO ETCÉTERA, DE CERÁMICA NO REFRACTARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (879,'C239202','FABRICACIÓN DE MATERIALES DE CONSTRUCCIÓN DE ARCILLA NO REFRACTARIA PARA USO ESTRUCTURAL: LADRILLOS, TEJAS, SOMBRERETES DE CHIMENEA, TUBOS, CONDUCTOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (880,'C239203','FABRICACIÓN DE ARTÍCULOS SANITARIOS DE CERÁMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (881,'C239204','SERVICIOS DE APOYO A LA FABRICACIÓN DE MATERIALES DE CONSTRUCCIÓN DE ARCILLA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (882,'C2393','FABRICACIÓN DE OTROS PRODUCTOS DE PORCELANA Y DE CERÁMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (883,'C23930','FABRICACIÓN DE OTROS PRODUCTOS DE PORCELANA Y DE CERÁMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (884,'C239301','FABRICACIÓN DE VAJILLAS Y OTROS ARTÍCULOS DE USO DOMÉSTICOS Y DE ASEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (885,'C239302','FABRICACIÓN DE ESTATUILLAS, ARTESANÍAS Y OTROS ARTÍCULOS ORNAMENTALES DE CERÁMICA O PORCELANA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (886,'C239303','FABRICACIÓN DE AISLADORES ELÉCTRICOS Y ACCESORIOS AISLANTES DE CERÁMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (887,'C239304','FABRICACIÓN DE ARTÍCULOS DE CERÁMICA PARA LABORATORIOS, PARA LA INDUSTRIA QUÍMICA Y LA INDUSTRIA EN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (888,'C239305','FABRICACIÓN DE TARROS, VASIJAS Y ARTÍCULOS SIMILARES DE CERÁMICA, UTILIZADOS PARA TRANSPORTAR O ENVASAR PRODUCTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (889,'C239306','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS DE PORCELANA Y DE CERÁMICA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (890,'C239309','FABRICACIÓN DE OTROS PRODUCTOS DE CERÁMICA N.C.P: MUEBLES DE CERÁMICA; IMANES DE CERÁMICA Y FERRITA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (891,'C2394','FABRICACIÓN DE CEMENTO, CAL Y YESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (892,'C23940','FABRICACIÓN DE CEMENTO, CAL Y YESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (893,'C239401','FABRICACIÓN DE CEMENTOS HIDRÁULICOS, INCLUIDO CEMENTO DE PÓRTLAND, CEMENTO ALUMINOSO, CEMENTO DE ESCORIAS Y CEMENTO HIPERSULFATADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (894,'C239402','FABRICACIÓN DE CAL VIVA, APAGADA E HIDRÁULICA; YESOS CON YESO CALCINADO O SULFATO DE CALCIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (895,'C239403','FABRICACIÓN DE DOLOMITA CALCINADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (896,'C239404','SERVICIOS DE APOYO A LA FABRICACIÓN DE CEMENTO, CAL Y YESO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (897,'C2395','FABRICACIÓN DE ARTÍCULOS DE HORMIGÓN, DE CEMENTO Y YESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (898,'C23950','FABRICACIÓN DE ARTÍCULOS DE HORMIGÓN, DE CEMENTO Y YESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (899,'C239501','FABRICACIÓN DE COMPONENTES ESTRUCTURALES Y MATERIALES PREFABRICADOS PARA OBRAS DE CONSTRUCCIÓN O DE INGENIERÍA CIVIL DE HORMIGÓN, CEMENTO, PIEDRA ARTIFICIAL O YESO: LOSETAS, LOSAS, BALDOSAS, LADRILLOS, BLOQUES, PLANCHAS, PANELES, LÁMINAS, TABLEROS, CAÑOS, TUBOS, POSTES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (900,'C239502','FABRICACIÓN DE MATERIALES DE YESO PARA LA CONSTRUCCIÓN Y DE SUSTANCIAS VEGETALES (LANA DE MADERA, PAJA, CAÑAS, JUNCOS) AGLOMERADAS CON CEMENTO, YESO U OTRO AGLUTINANTE MINERAL: ESTUCADOS, CIELOS RASOS DE CARRIZO O YESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (901,'C239503','FABRICACIÓN DE ARTÍCULOS DE ASBESTO-CEMENTO, FIBRO-CEMENTO DE CELULOSA Y MATERIALES SIMILARES: LÁMINAS ONDULADAS, OTRAS LAMINAS, PANELES, TABLEROS, LOSETAS, TUBOS, CAÑOS, DEPÓSITOS, TANQUES DE AGUA, CISTERNAS, LAVABOS, LAVADEROS, VASIJAS, MUEBLES, MARCOS PARA VENTANAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (902,'C239504','FABRICACIÓN DE MEZCLAS PREPARADAS Y SECAS PARA HORMIGÓN Y MORTERO (INCLUSO MORTERO EN POLVO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (903,'C239505','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE HORMIGÓN, DE CEMENTO Y YESO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (904,'C239509','FABRICACIÓN DE OTROS ARTÍCULOS DE HORMIGÓN, YESO, CEMENTO O PIEDRA ARTIFICIAL, INCLUSO LOS USADOS CON FINES DECORATIVOS: ESTATUAS, MUEBLES, BAJORRELIEVES Y ALTORRELIEVES, JARRONES, MACETAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (905,'C2396','CORTE, TALLADO Y ACABADO DE LA PIEDRA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (906,'C23960','CORTE, TALLADO Y ACABADO DE LA PIEDRA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (907,'C239601','CORTE, TALLADO Y ACABADO DE LA PIEDRA PARA CONSTRUCCIÓN (INCLUSO MÁRMOL): CEMENTERIOS, CARRETERAS, TECHOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (908,'C239602','FABRICACIÓN DE MUEBLES DE PIEDRA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (909,'C239603','SERVICIOS DE APOYO AL CORTE, TALLADO Y ACABADO DE LA PIEDRA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (910,'C2399','FABRICACIÓN DE OTROS PRODUCTOS MINERALES NO METÁLICOS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (911,'C23990','FABRICACIÓN DE OTROS PRODUCTOS MINERALES NO METÁLICOS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (912,'C239901','FABRICACIÓN DE MUELAS DE MOLINO, PIEDRAS DE AMOLAR, PULIMENTAR Y PRODUCTOS ABRASIVOS NATURALES Y ARTIFICIALES, INCLUIDOS PRODUCTOS ABRASIVOS SOBRE UNA BASE FLEXIBLE COMO EL PAPEL LIJA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (913,'C239902','FABRICACIÓN DE MATERIALES DE FRICCIÓN Y ARTÍCULOS SIN MONTAR DE ESOS MATERIALES CON UNA BASE DE SUSTANCIAS MINERALES O DE CELULOSA. LANA DE ESCORIAS, LANA DE ROCA Y OTRAS LANAS MINERALES SIMILARES; VERMICULITA ESCAMADA, ARCILLAS DILATADAS Y MATERIALES SIMILARES PARA AISLAMIENTO TÉRMICO Y SONORO, Y PARA ABSORBER EL SONIDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (914,'C239903','FABRICACIÓN DE ARTÍCULOS DE DIVERSAS SUSTANCIAS MINERALES: MICA TRABAJADA Y ARTÍCULOS DE MICA, DE TURBA Y DE GRAFITO (QUE NO SEAN ARTÍCULOS ELÉCTRICOS), ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (915,'C239904','FABRICACIÓN DE ARTÍCULOS DE ASFALTO O DE MATERIALES SIMILARES, POR EJEMPLO ADHESIVOS A BASE DE ASFALTO (IMPERMEABILIZANTES PARA LA CONSTRUCCIÓN), BREA, ALQUITRÁN, HULLA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (916,'C239905','FABRICACIÓN DE FIBRAS Y PRODUCTOS DE CARBONO Y GRAFITO (EXCEPTO ELECTRODOS Y APLICACIONES ELÉCTRICAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (917,'C239906','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS MINERALES NO METÁLICOS N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (918,'C24','FABRICACIÓN DE METALES COMUNES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (919,'C241','INDUSTRIAS BÁSICAS DE HIERRO Y ACERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (920,'C2410','INDUSTRIAS BÁSICAS DE HIERRO Y ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (921,'C24101','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE HIERRO Y ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (922,'C241011','EXPLOTACIÓN DE ALTOS HORNOS, PRODUCCIÓN DE ARRABIO Y HIERRO ESPECULAR EN LINGOTES, BLOQUES Y OTRAS FORMAS PRIMARIAS, INCLUSO HIERRO EN GRANALLA (GRANOS) Y EN POLVO, CONVERTIDORES DE ACERO, TALLERES DE LAMINADO Y ACABADO, REFUNDICIÓN DE LINGOTES DE CHATARRA DE HIERRO O ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (923,'C241012','PRODUCCIÓN DE FERROALEACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (924,'C241013','PRODUCCIÓN DE HIERRO DE PUREZA EXCEPCIONAL POR ELECTROLISIS O MEDIANTE OTROS PROCESOS QUÍMICOS; FABRICACIÓN DE PRODUCTOS SEMIACABADOS DE HIERRO POR REDUCCIÓN DIRECTA DE MINERALES DE HIERRO (MENA) Y OTROS PRODUCTOS FERROSOS ESPONJOSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (925,'C241014','PRODUCCIÓN DE ACERO EN LINGOTES U OTRAS FORMAS PRIMARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (926,'C241015','FABRICACIÓN DE PRODUCTOS SEMIACABADOS DE ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (927,'C24102','FABRICACIÓN DE PRODUCTOS ACABADOS DE HIERRO Y ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (928,'C241021','FABRICACIÓN DE PRODUCTOS DE ACERO LAMINADOS PLANOS EN CALIENTE Y FRÍO, SECCIONES LAMINADAS, ACERO EN LINGOTES Y SECCIONES SÓLIDAS DE ACERO POR TREFILADO, MOLIDO O DOBLADO EN FRÍO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (929,'C241022','FABRICACIÓN DE BARRAS, VARILLAS Y SECCIONES SÓLIDAS DE HIERRO Y ACERO LAMINADAS EN CALIENTE Y MEDIANTE ESTIRADO EN FRÍO Y EN CALIENTE, RECTIFICACIÓN O TORNEADO; FABRICACIÓN DE ALAMBRE DE ACERO MEDIANTE ESTIRADO O ALARGAMIENTO EN FRÍO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (930,'C241023','FABRICACIÓN DE MATERIALES PARA VÍAS DE FERROCARRIL (CARRILES NO ENSAMBLADOS) DE ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (931,'C241024','FABRICACIÓN DE TUBOS, TUBERÍAS PERFILES, HUECOS DE ACERO SIN COSTURA Y CAÑOS SOLDADOS MEDIANTE CONFORMACIÓN EN FRÍO O EN CALIENTE Y SOLDADURA, ENTREGADOS EN ESE ESTADO O TRANSFORMADOS POSTERIORMENTE MEDIANTE EXTRUSIÓN O ESTIRADO O LAMINACIÓN EN FRÍO O MEDIANTE CONFORMACIÓN EN CALIENTE, SOLDADURA Y REDUCCIÓN. FABRICACIÓN DE CONEXIONES DE SOLDADURA A TOPE, ROSCADAS, CON SOLDADURA MACHIHEMBRADA, CONEXIONES DE TUBO DE ACERO, COMO: CONEXIONES DE BRIDA PLANAS Y CONEXIONES DE BRIDA CON COLLARES DE ACERO DE FORJA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (932,'C241025','FABRICACIÓN DE ÁNGULOS, PERFILES Y SECCIONES ABIERTAS DE ACERO LAMINADAS EN CALIENTE Y MEDIANTE CONFORMACIÓN PROGRESIVA EN UN LAMINADOR DE RULOS O MEDIANTE PLEGADO EN UNA PRENSA DE PRODUCTOS LAMINADOS PLANOS DE ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (933,'C241029','FABRICACIÓN DE OTROS PRODUCTOS DE HIERRO O ACERO: TABLESTACAS DE ACERO Y SECCIONES ABIERTAS SOLDADAS DE ACERO, VIRUTA DE HOJAS DE ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (934,'C24103','SERVICIOS DE APOYO A LA INDUSTRIAS BÁSICAS DE HIERRO Y ACERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (935,'C241030','SERVICIOS DE APOYO A LAS INDUSTRIAS BÁSICAS DE HIERRO Y ACERO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (936,'C242','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS Y METALES NO FERROSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (937,'C2420','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS Y METALES NO FERROSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (938,'C24201','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (939,'C242011','PRODUCCIÓN DE METALES PRECIOSOS BÁSICOS: PRODUCCIÓN Y REFINACIÓN DE METALES PRECIOSOS SIN LABRAR Y LABRADOS: ORO, PLATA, PLATINO, ETCÉTERA A PARTIR DE MINERALES Y RESIDUOS, PRODUCCIÓN DE SEMIPRODUCTOS DE METALES PRECIOSOS; FABRICACIÓN DE LAMINADOS CON HOJAS DE METALES PRECIOSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (940,'C242012','PRODUCCIÓN DE ALEACIONES DE METALES PRECIOSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (941,'C242013','FABRICACIÓN DE ENCHAPADOS: DE METALES COMUNES CON PLATA; DE METALES COMUNES Ó PLATA CON ORO; DE METALES COMUNES, ORO Y PLATA CON PLATINO O CON METALES DEL GRUPO DEL PLATINO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (942,'C24202','FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (943,'C242021','PRODUCCIÓN DE METALES COMUNES NO FERROSOS A PARTIR DE MINERALES EN BRUTO O EN MATA, ALÚMINA U ÓXIDOS: ALUMINIO, PLOMO ZINC, ESTAÑO, COBRE, CROMO, MANGANESO, NÍQUEL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (944,'C242022','PRODUCCIÓN DE METALES COMUNES NO FERROSOS A PARTIR DE MINERALES O MEDIANTE LA REFINACIÓN ELECTROLÍTICA DE DESECHOS Y CHATARRA DE PLOMO, ZINC, ESTAÑO, COBRE, CROMO, MANGANESO, NÍQUEL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (945,'C242023','PRODUCCIÓN DE ALEACIONES DE: ALUMINIO; PLOMO, ZINC, ESTAÑO, COBRE, CROMO, MANGANESO, NÍQUEL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (946,'C242024','FABRICACIÓN DE PRODUCTOS SEMIELABORADOS DE ALUMINIO, PLOMO, ZINC, ESTAÑO, COBRE, CROMO, MANGANESO, NÍQUEL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (947,'C242025','FABRICACIÓN DE ALAMBRE DE METALES COMUNES NO FERROSOS: ALUMINIO; PLOMO, ZINC Y ESTAÑO COBRE CROMO, MANGANESO, NÍQUEL, ETCÉTERA MEDIANTE TREFILADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (948,'C242026','PRODUCCIÓN DE ALUMINIO A PARTIR DE ALÚMINA Y DE LA REFINACIÓN ELECTROLÍTICA DE DESECHOS Y CHATARRA DE ALUMINIO INCLUIDO LA PRODUCCIÓN DE OXIDO DE ALUMINIO (ALÚMINA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (949,'C242029','FABRICACIÓN DE OTROS PRODUCTOS DE METALES NO FERROSOS: ALAMBRE PARA FUSIBLES O LÁMINA FUSIBLE; PAPEL DE ALUMINIO, LAMINADOS CON HOJAS DE ALUMINIO (ESTAÑO) COMO COMPONENTE PRINCIPAL; FABRICACIÓN DE ALAMBRE DE METALES NO FERROSOS MEDIANTE EL TREFILADO; PRODUCCIÓN DE METAL DE URANIO A PARTIR DE PECHBLENDA U OTROS MINERALES FUNDICIÓN Y REFINAMIENTO DE URANIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (950,'C24203','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS Y METALES NO FERROSOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (951,'C242030','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS PRIMARIOS DE METALES PRECIOSOS Y METALES NO FERROSOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.85,8.70,'A'),
	 (952,'C243','FUNDICIÓN DE METALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (953,'C2431','FUNDICIÓN DE HIERRO Y ACERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (954,'C24310','FUNDICIÓN DE HIERRO Y ACERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (955,'C243101','FUNDICIÓN DE HIERRO GRIS, HIERRO GRAFITO ESFEROIDAL, PRODUCTOS DE HIERRO MALEABLE; PRODUCTOS SEMIACABADOS DE HIERRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (956,'C243102','FUNDICIÓN DE PIEZAS DE ACERO; PRODUCTOS SEMIACABADOS DE ACERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (957,'C243103','FABRICACIÓN DE TUBOS, CAÑOS, PERFILES HUECOS, CONEXIONES DE TUBOS Y CAÑOS DE HIERRO Y ACERO SIN COSTURA MEDIANTE FUNDICIÓN CENTRÍFUGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (958,'C2432','FUNDICIÓN DE METALES NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (959,'C24320','FUNDICIÓN DE METALES NO FERROSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (960,'C243201','FUNDICIÓN DE PIEZAS Y PRODUCTOS SEMIACABADOS DE METALES NO FERROSOS INCLUIDA LA FUNDICIÓN A PRESIÓN DE: ALUMINIO, MAGNESIO, TITANIO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (961,'C243202','FUNDICIÓN DE METALES PRECIOSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (962,'C25','FABRICACIÓN DE PRODUCTOS ELABORADOS DE METAL, EXCEPTO MAQUINARIA Y EQUIPO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (963,'C251','FABRICACIÓN DE PRODUCTOS METÁLICOS PARA USO ESTRUCTURAL, TANQUES, DEPÓSITOS, RECIPIENTES DE METAL Y GENERADORES DE VAPOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (964,'C2511','FABRICACIÓN DE PRODUCTOS METÁLICOS PARA USO ESTRUCTURAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (965,'C25110','FABRICACIÓN DE ESTRUCTURAS METÁLICAS Y SUS PARTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (966,'C251101','FABRICACIÓN DE ESTRUCTURAS DE METAL MARCOS O ARMAZONES PARA CONSTRUCCIÓN Y PARTES DE ESAS ESTRUCTURAS: TORRES, MÁSTILES, ARMADURAS, PUENTES, ETCÉTERA; MARCOS INDUSTRIALES DE METAL: MARCOS PARA ALTOS HORNOS, EQUIPOS DE ELEVACIÓN Y MANIPULACIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (967,'C251102','FABRICACIÓN DE EDIFICIOS PREFABRICADOS PRINCIPALMENTE DE METAL: CASETAS, MÓDULOS DE EXHIBICIÓN DE ELEMENTOS, CABINAS TELEFÓNICAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (968,'C251103','FABRICACIÓN DE PUERTAS Y VENTANAS DE METAL Y SUS MARCOS (INCLUSO ENROLLABLES), POSTIGOS(PUERTAS) Y PORTALES, BALCONES, ESCALERAS, REJAS, TABIQUES DE METAL PARA FIJAR AL SUELO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (969,'C251104','SERVICIOS DE APOYO A LA FABRICACIÓN DE PRODUCTOS METÁLICOS PARA USO ESTRUCTURAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (970,'C2512','FABRICACIÓN DE TANQUES, DEPÓSITOS Y RECIPIENTES DE METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (971,'C25120','FABRICACIÓN DE TANQUES, DEPÓSITOS Y RECIPIENTES DE METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (972,'C251201','FABRICACIÓN DE TANQUES, DEPÓSITOS Y RECIPIENTES SIMILARES DE METAL, DEL TIPO HABITUALMENTE UTILIZADO PARA ALMACENAMIENTO Y ELABORACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (973,'C251202','FABRICACIÓN DE RECIPIENTES DE METAL PARA GASES COMPRIMIDOS O LICUADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (974,'C251203','FABRICACIÓN DE CALDERAS Y RADIADORES PARA CALEFACCIÓN CENTRAL, PARTES Y PIEZAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (975,'C251204','SERVICIOS DE APOYO A LA FABRICACIÓN DE TANQUES, DEPÓSITOS Y RECIPIENTES DE METAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (976,'C2513','FABRICACIÓN DE GENERADORES DE VAPOR, EXCEPTO CALDERAS DE AGUA CALIENTE PARA CALEFACCIÓN CENTRAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (977,'C25130','FABRICACIÓN DE GENERADORES DE VAPOR, EXCEPTO CALDERAS DE AGUA CALIENTE PARA CALEFACCIÓN CENTRAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (978,'C251301','FABRICACIÓN DE GENERADORES (CALDERAS) DE VAPOR DE AGUA Y OTROS VAPORES; INSTALACIONES AUXILIARES PARA GENERADORES (CALDERAS) DE VAPOR: CONDENSADORES, ECONOMIZADORES, RECALENTADORES, RECOLECTORES Y ACUMULADORES DE VAPOR, INCLUSO DESHOLLINADORES, RECUPERADORES DE GASES SACABARROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (979,'C251302','FABRICACIÓN DE REACTORES NUCLEARES, EXCEPTO SEPARADORES DE ISÓTOPOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (980,'C251303','FABRICACIÓN DE PIEZAS PARA CALDERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (981,'C251304','SERVICIOS DE APOYO A LA FABRICACIÓN DE GENERADORES DE VAPOR, EXCEPTO CALDERAS DE AGUA CALIENTE PARA CALEFACCIÓN CENTRAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (982,'C252','FABRICACIÓN DE ARMAS Y MUNICIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (983,'C2520','FABRICACIÓN DE ARMAS Y MUNICIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (984,'C25200','FABRICACIÓN DE ARMAS Y MUNICIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (985,'C252001','FABRICACIÓN DE ARMAS PESADAS (ARTILLERÍA, CAÑONES MÓVILES, LANZACOHETES, TUBOS LANZATORPEDOS, AMETRALLADORAS PESADAS, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (986,'C252002','FABRICACIÓN DE ARMAS LIGERAS (REVÓLVERES, ESCOPETAS, AMETRALLADORAS LIGERAS); ARMAS DE FUEGO Y MUNICIONES DE CAZA, DE DEPORTE O DE PROTECCIÓN; ARMAS QUE DISPARAN BALAS DE FOGUEO, PISTOLAS PARA LANZAR BENGALAS DE SEÑALES, PISTOLAS DE MATARIFE, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (987,'C252003','FABRICACIÓN DE ESCOPETAS Y PISTOLAS DE AIRE Y GAS COMPRIMIDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (988,'C252004','FABRICACIÓN DE MUNICIONES DE GUERRA; APARATOS EXPLOSIVOS TALES COMO BOMBAS, MINAS Y TORPEDOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (989,'C252005','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARMAS Y MUNICIONES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (990,'C259','FABRICACIÓN DE OTROS PRODUCTOS ELABORADOS DE METAL, ACTIVIDADES DE TRABAJOS DE METALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (991,'C2591','FORJA, PRENSADO, ESTAMPADO Y LAMINADO DE METALES; PULVIMETALURGIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (992,'C25910','FORJA, PRENSADO, ESTAMPADO Y LAMINADO DE METALES; PULVIMETALURGIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (993,'C259100','ACTIVIDADES DE FORJA, PRENSADO, ESTAMPADO Y LAMINADO DE METALES; PULVIMETALURGIA, PRODUCCIÓN DE OBJETOS DE METAL DIRECTAMENTE A PARTIR DE POLVOS DE METAL QUE SE SOMETEN A TRATAMIENTO CALORÍFICO (SINTERIZACIÓN) O DE COMPRESIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (994,'C2592','TRATAMIENTO Y REVESTIMIENTO DE METALES; MAQUINADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (995,'C25920','TRATAMIENTO, REVESTIMIENTO Y MAQUINADO DE METALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (996,'C259201','ACTIVIDADES DE SERVICIO DE TRATAMIENTO CALORÍFICO DE METALES, ENDURECIMIENTO DE METALES REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (997,'C259202','ACTIVIDADES DE SERVICIO DE REVESTIMIENTO DE METALES: ENCHAPADO, ANODIZACIÓN, COLOREADO, PLASTIFICADO, ESMALTADO, LACADO, CROMADO, ETCÉTERA, REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (998,'C259203','ACTIVIDADES DE SERVICIO DE LIMPIEZA DE METALES: DESBARBADO, LIMPIEZA CON CHORRO DE ARENA, PULIMENTO EN TAMBOR GIRATORIO, BRUÑIDO, PULIDO, LIMPIEZA DE METALES, REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (999,'C259204','ACTIVIDADES DE SERVICIO DE MAQUINADO DE METALES: TALADRADO, TORNEADO, FRESADO, EROSIÓN, ALISADO, LAPIDADO, BROCHADO, APLANADO, ASERRADO, ESMERILADO, AFILADO, SOLDADURA, EMPALME, CORTADO, GRABADO, ETCÉTERA, DE PIEZAS DE METAL REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1000,'C2593','FABRICACIÓN DE ARTÍCULOS DE CUCHILLERÍA, HERRAMIENTAS DE MANO Y ARTÍCULOS DE FERRETERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1001,'C25931','FABRICACIÓN DE ARTÍCULOS DE CUCHILLERÍA Y CUBERTERÍA DE METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1002,'C259311','FABRICACIÓN DE CUBERTERÍA DE USO DOMÉSTICO, COMO CUCHILLOS, TENEDORES, CUCHARAS, ETCÉTERA INCLUSO REVESTIDOS DE METALES PRECIOSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1003,'C259312','FABRICACIÓN DE OTROS ARTÍCULOS DE CUCHILLERÍA: DESTRALES, CUCHILLOS, NAVAJAS, MAQUINILLAS DE AFEITAR Y HOJAS DE AFEITAR, TIJERAS COMUNES Y DE PELUQUERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1004,'C259313','FABRICACIÓN DE CUCHILLAS Y CIZALLAS PARA MÁQUINAS Y PARA APARATOS MECÁNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1005,'C259314','FABRICACIÓN DE MACHETES, ESPADAS, BAYONETAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1006,'C25932','FABRICACIÓN DE HERRAMIENTAS DE MANO Y ARTÍCULOS DE FERRETERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1007,'C259321','FABRICACIÓN DE HERRAMIENTAS DE MANO TALES COMO ALICATE, DESTORNILLADORES, LIMAS, LLAVES INGLESAS, MARTILLOS, OTRAS HERRAMIENTAS MANUALES Y HERRAMIENTAS DE MANO DE USO DOMÉSTICO N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1008,'C259322','FABRICACIÓN DE SIERRAS Y HOJAS PARA SIERRAS, INCLUIDAS SIERRAS CIRCULARES Y DE CADENA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1009,'C259323','FABRICACIÓN DE ACCESORIOS INTERCAMBIABLES PARA HERRAMIENTAS DE MANO MOTORIZADAS O NO, Y PARA MÁQUINAS HERRAMIENTAS: BROCAS, PUNZONES, FRESAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1010,'C259324','FABRICACIÓN DE HERRAMIENTAS DE HERRERÍA: MACHOS DE FORJA, YUNQUES, ETCÉTERA; MOLDES Y CAJAS DE MOLDEO (EXCEPTO LINGOTERAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1011,'C259325','FABRICACIÓN DE CANDADOS, CERRADURAS, PASADORES, LLAVES, DUPLICACIÓN DE LLAVES, BISAGRAS Y ARTÍCULOS SIMILARES, ACCESORIOS DE FERRETERÍA PARA EDIFICIOS, MUEBLES, VEHÍCULOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1012,'C259326','FABRICACIÓN DE HERRAMIENTAS DE MANO NO MOTORIZADAS: (AZADONES, PICOS, PALAS, ETCÉTERA) PARA USO AGRÍCOLA, CONSTRUCCIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1013,'C259327','FABRICACIÓN DE MORDAZAS, ABRAZADERAS, ESTAMPAS Y TROQUELES DE PRENSA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1014,'C25933','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE CUCHILLERÍA, HERRAMIENTAS DE MANO Y ARTÍCULOS DE FERRETERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1015,'C259330','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE CUCHILLERÍA, HERRAMIENTAS DE MANO Y ARTÍCULOS DE FERRETERÍA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1016,'C2599','FABRICACIÓN DE OTROS PRODUCTOS ELABORADOS DE METAL N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1017,'C25991','FABRICACIÓN DE PRODUCTOS DE TORNILLERÍA, SUJETADORES Y OTROS ARTÍCULOS DE ALAMBRE O METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1018,'C259911','FABRICACIÓN DE RECIPIENTES METÁLICOS UTILIZADOS PARA EL ENVASE O TRANSPORTE DE MERCANCÍAS: BARRILES, LATAS, TAMBORES, CUBOS, CAJAS, TARROS, INCLUSO TAPAS CORONA (CIERRES METÁLICOS) Y LATAS PARA PRODUCTOS ALIMENTICIOS, TUBOS Y CAJAS PLEGABLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1019,'C259912','FABRICACIÓN DE CABLES DE METAL CON O SIN AISLAMIENTO QUE NO SE PUEDEN UTILIZAR COMO CONDUCTORES DE ELECTRICIDAD, TRENZAS DE METAL, ALAMBRE Y ARTÍCULOS SIMILARES DE HIERRO, ACERO, ALUMINIO O COBRE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1020,'C259913','FABRICACIÓN DE ARTÍCULOS DE ALAMBRE: ALAMBRE DE PÚAS, CERCAS DE ALAMBRE, REJILLAS, REDES, TELAS METÁLICAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1021,'C259914','FABRICACIÓN DE MUELLES (EXCEPTO MUELLES PARA RELOJES): DE BALLESTA, HELICOIDALES, BARRAS DE TORSIÓN, BALLESTAS PARA MUELLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1022,'C259915','FABRICACIÓN DE PRODUCTOS DE TORTILLERÍA: TORNILLOS, TUERCAS, PERNOS Y ARTÍCULOS CON ROSCA SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1023,'C259916','FABRICACIÓN DE SUJETADORES HECHOS DE METAL: CLAVOS, ALFILERES, TACHUELAS, REMACHES, ABRAZADERAS, ARANDELAS Y ARTÍCULOS SIN ROSCAS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1024,'C259917','FABRICACIÓN DE CADENAS, EXCEPTO LAS DE TRANSMISIÓN DE ENERGÍA (MECÁNICA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1025,'C25992','FABRICACIÓN DE VAJILLAS, ARTÍCULOS SANITARIOS, ETCÉTERA, DE METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1026,'C259921','FABRICACIÓN DE ARTÍCULOS DE METAL DE USO DOMESTICO: VAJILLA DE MESA Y DE COCINA, SEAN O NO DE METALES COMUNES Y ENCHAPADOS O NO CON METALES PRECIOSOS: PLATOS, TAZAS, ETCÉTERA; SERVICIO DE MESA: BOLES, BANDEJAS, ETCÉTERA; BATERÍAS DE COCINA: CACEROLAS, RECIPIENTES PARA HERVIR AGUA, ETCÉTERA, CAZOS (CAZUELAS), SARTENES Y OTROS UTENSILIOS NO ELÉCTRICOS PARA USAR EN LA MESA O EN LA COCINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1027,'C259922','FABRICACIÓN DE PEQUEÑOS APARATOS Y ACCESORIOS MANUALES DE COCINA ACCIONADOS A MANO PARA PREPARAR, ACONDICIONAR O SERVIR ALIMENTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1028,'C259923','FABRICACIÓN DE ARTÍCULOS SANITARIOS DE METAL, BAÑERAS, PILAS (FUENTES), LAVABOS Y ARTÍCULOS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1029,'C25993','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS ELABORADOS DE METAL N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1030,'C259930','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS PRODUCTOS ELABORADOS DE METAL N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1031,'C25999','FABRICACIÓN DE OTROS PRODUCTOS DE METAL N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1032,'C259991','FABRICACIÓN DE ACCESORIOS PARA VÍAS DE FERROCARRIL O TRANVÍA POR EJEMPLO: CARRILES ENSAMBLADOS, PLATAFORMAS GIRATORIAS, POTROS DE CONTENCIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1033,'C259992','FABRICACIÓN DE HÉLICES PARA EMBARCACIONES Y SUS PALAS, ANCLAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1034,'C259993','FABRICACIÓN DE CAJAS FUERTES O DE SEGURIDAD, CAJAS DE CAUDALES, PÓRTICOS, PUERTAS BLINDADAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1035,'C259994','FABRICACIÓN DE IMANES METÁLICOS PERMANENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1036,'C259995','FABRICACIÓN DE ARTÍCULOS DE METAL PARA OFICINA, EXCEPTO MUEBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1037,'C259996','FABRICACIÓN DE SEÑALES METÁLICAS (LETREROS NO ELÉCTRICOS), MARCOS DE METAL PARA CUADROS, PLACAS DE METAL E INSIGNIAS MILITARES; ARTÍCULOS SIMILARES DE METAL (EXCEPTO METALES PRECIOSOS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1038,'C259999','FABRICACIÓN DE OTROS ARTÍCULOS DE METAL: CIERRES, HEBILLAS, CORCHETES; CAMPANAS, ALMOHADILLAS METÁLICAS PARA FREGAR (ESTROPAJOS); TERMOS Y OTROS RECIPIENTES HERMÉTICOS DE METAL: JARROS Y BOTELLAS DE METAL; RULOS PARA EL PELO, EMPUÑADURAS Y SOPORTES PARA PARAGUAS Y PEINES DE METAL, CASCOS DE SEGURIDAD, BOLSAS DE PAPEL ALUMINIO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1039,'C26','FABRICACIÓN DE PRODUCTOS DE INFORMÁTICA, ELECTRÓNICA Y ÓPTICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1040,'C261','FABRICACIÓN DE COMPONENTES Y TABLEROS ELECTRÓNICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1041,'C2610','FABRICACIÓN DE COMPONENTES Y TABLEROS ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1042,'C26101','FABRICACIÓN DE COMPONENTES Y TABLEROS ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1043,'C261011','FABRICACIÓN DE SEMICONDUCTORES, CONDENSADORES ELECTRÓNICOS, MICROPROCESADORES, TABLEROS DE CIRCUITOS IMPRESOS Y TABLEROS SIN IMPRIMIR, INCLUIDO LA CARGA DE COMPONENTES EN TABLEROS DE CIRCUITOS IMPRESOS Y OTROS COMPONENTES PARA APLICACIONES ELECTRÓNICAS DE ELECTRODOMÉSTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1044,'C261012','FABRICACIÓN DE RESISTORES ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1045,'C261013','FABRICACIÓN DE TUBOS ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1046,'C26102','SERVICIOS DE APOYO A LA FABRICACIÓN DE COMPONENTES Y TABLEROS ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1047,'C261020','SERVICIOS DE APOYO A LA FABRICACIÓN DE COMPONENTES Y TABLEROS ELECTRÓNICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1048,'C26109','FABRICACIÓN DE OTROS PRODUCTOS ELECTRÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1049,'C261091','FABRICACIÓN DE CIRCUITOS INTEGRADOS (ANÁLOGOS, DIGITALES O HÍBRIDOS), TARJETAS INTELIGENTES (TARJETAS BANCARIAS, DE IDENTIFICACIÓN Y ACCESO, FIDELIZACIÓN, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1050,'C261092','FABRICACIÓN DE DIODOS, TRANSISTORES Y DISPOSITIVOS SEMICONDUCTORES SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1051,'C261093','FABRICACIÓN DE INDUCTORES (AUTOINDUCTORES, BOBINAS, TRANSFORMADORES) DEL TIPO DE LOS UTILIZADOS COMO COMPONENTES ELECTRÓNICO; CRISTALES Y JUEGOS DE CRISTALES ELECTRÓNICOS; PLAQUETAS U OBLEAS, DE SEMICONDUCTORES, ACABADOS O SEMIACABADOS; SOLENOIDES, CONMUTADORES Y TRANSDUCTORES PARA APLICACIONES ELÉCTRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1052,'C261094','FABRICACIÓN DE TARJETAS DE INTERFAZ (DE SONIDO, VIDEO, CONTROL, RED, MÓDEMS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1053,'C261095','FABRICACIÓN DE COMPONENTES DE PANTALLAS (PLASMA, POLÍMEROS, CRISTAL LÍQUIDO LCD) Y DIODOS EMISORES DE LUZ (LED).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1054,'C261099','FABRICACIÓN DE OTROS PRODUCTOS ELECTRÓNICOS: CABLES DE IMPRESORA, MONITOR, CABLES USB, CONECTORES ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1055,'C262','FABRICACIÓN DE ORDENADORES Y EQUIPO PERIFÉRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1056,'C2620','FABRICACIÓN DE COMPUTADORAS Y EQUIPO PERIFÉRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1057,'C26200','FABRICACIÓN DE COMPUTADORAS Y EQUIPO PERIFÉRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1058,'C262001','FABRICACIÓN DE ORDENADORES (COMPUTADORAS) CENTRALES, MICROCOMPUTADORAS; DE ESCRITORIO, PORTÁTILES (LAPTOPS, NOTEBOOKS); ORDENADORES DE MANO (ASISTENTES DIGITALES PERSONALES), SERVIDORES INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1059,'C262002','FABRICACIÓN DE UNIDADES DE DISCO MAGNÉTICO, UNIDADES DE USB: MP3, MP4, PEN DRIVES Y OTROS DISPOSITIVOS DE ALMACENAMIENTO; UNIDADES DE DISCO ÓPTICO (CD-RW, CD-ROM, DVD-ROM, DVD-RW).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1060,'C262003','FABRICACIÓN DE IMPRESORAS; MONITORES, TECLADOS, TODO TIPO DE RATONES, PALANCAS DE MANDO Y BOLAS RODANTES, EQUIPO DE OFICINA MULTIFUNCIONES COMO COMBINACIONES DE FAX-ESCÁNER-COPIADORA, ESCÁNERES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1061,'C262004','FABRICACIÓN DE TERMINALES INFORMÁTICAS ESPECIALIZADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1062,'C262005','FABRICACIÓN DE TERMINALES COMO CAJEROS AUTOMÁTICOS (ATM); TERMINALES DE PUNTOS DE VENTA, NO ACCIONADOS MECÁNICAMENTE, MONEDEROS AUTOMÁTICOS, LECTORES DE CÓDIGOS DE BARRA; LECTORES DE TARJETAS INTELIGENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1063,'C262006','SERVICIOS DE APOYO A LA FABRICACIÓN DE ORDENADORES Y EQUIPO PERIFÉRICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1064,'C262009','FABRICACIÓN DE OTROS EQUIPOS INFORMÁTICOS: CASCOS DE REALIDAD VIRTUAL; PROYECTORES INFORMÁTICOS (PROYECTORES DE VÍDEO) ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1065,'C263','FABRICACIÓN DE EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1066,'C2630','FABRICACIÓN DE EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1067,'C26300','FABRICACIÓN DE EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1068,'C263001','FABRICACIÓN DE APARATOS PARA LA CONMUTACIÓN Y TRANSMISIÓN DE DATOS: CENTRALES TELEFÓNICAS - PBX; MÓDEMS, BRIDGES, ROUTERS, GATEWAYS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1069,'C263002','FABRICACIÓN DE TELÉFONOS INALÁMBRICOS; EQUIPOS TELEFÓNICOS Y DE FAX, INCLUIDOS LOS CONTESTADORES AUTOMÁTICOS, EQUIPO MÓVIL DE COMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1070,'C263003','FABRICACIÓN DE TELÉFONOS CELULARES, MENSÁFONOS, LOCALIZADORES (BUSCAPERSONAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1071,'C263004','FABRICACIÓN DE TRANSMISORES DE RADIO Y TELEVISIÓN, EQUIPOS DE ESTUDIOS INCLUYENDO CÁMARAS DE TELEVISIÓN, EQUIPOS DE TELEVISIÓN POR CABLE (DECODIFICADORES), DISPOSITIVOS DE INFRARROJOS (CONTROL REMOTO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1072,'C263005','FABRICACIÓN DE SISTEMAS DE ALARMA CONTRA INCENDIO Y ROBO, QUE TRANSMITEN SEÑALES A UN CENTRO DE CONTROL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1073,'C263006','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPO DE COMUNICACIONES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1074,'C263009','FABRICACIÓN DE OTROS EQUIPOS DE TELECOMUNICACIONES DIVERSOS: ANTENAS DE TRANSMISIÓN Y RECEPCIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1075,'C264','FABRICACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1076,'C2640','FABRICACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1077,'C26400','FABRICACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1078,'C264001','FABRICACIÓN DE EQUIPO DE GRABACIÓN Y REPRODUCCIÓN DE VIDEO, INCLUSO CÁMARAS DE VIDEO DE TIPO FAMILIAR; REPRODUCTORES DE DVD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1079,'C264002','FABRICACIÓN DE TELEVISORES, INCLUSO MONITORES Y PANTALLAS DE TELEVISIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1080,'C264003','FABRICACIÓN DE EQUIPO DE GRABACIÓN Y REPRODUCCIÓN DE SONIDO; REPRODUCTORES DE CD; EQUIPOS ESTEREOFÓNICOS; EQUIPOS DE SONIDO, ETCÉTERA; RECEPTORES DE RADIO, INCLUSO CON DISPOSITIVOS DE GRABACIÓN O REPRODUCCIÓN DE SONIDO O CON UN RELOJ.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1081,'C264004','FABRICACIÓN DE AMPLIFICADORES PARA INSTRUMENTOS MUSICALES Y SISTEMAS DE MEGAFONÍA; MICRÓFONOS; AUDÍFONOS (PARA RADIOS, EQUIPOS ESTEREOFÓNICOS, ORDENADORES); PARLANTES, SISTEMAS DE ALTAVOCES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1082,'C264005','SERVICIOS DE APOYO A LA FABRICACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1083,'C264009','FABRICACIÓN DE OTROS APARATOS ELECTRÓNICOS DIVERSOS: APARATOS DE KARAOKE; CONSOLAS DE VIDEOJUEGOS, ROCOLAS (JUKEBOXES), ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1084,'C265','FABRICACIÓN DE EQUIPOS DE MEDICIÓN, PRUEBA, NAVEGACIÓN, CONTROL Y DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1085,'C2651','FABRICACIÓN DE EQUIPOS DE MEDICIÓN, PRUEBA, NAVEGACIÓN, CONTROL Y DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1086,'C26511','FABRICACIÓN DE EQUIPOS DE MEDICIÓN, PRUEBA, NAVEGACIÓN, CONTROL Y DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1087,'C265111','FABRICACIÓN DE INSTRUMENTOS PARA MOTORES DE AERONAVES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1088,'C265112','FABRICACIÓN DE EQUIPO DE PRUEBA DE EMISIONES DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1089,'C265113','FABRICACIÓN DE INSTRUMENTOS METEOROLÓGICOS, GEODESIA, GEOFÍSICOS, HIDROGRÁFICOS, HIDROLÓGICOS, PROSPECCIÓN, OCEANOGRÁFICOS Y DE NIVELAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1090,'C265114','FABRICACIÓN DE EQUIPOS DE PRUEBAS E INSPECCIÓN DE PROPIEDADES FÍSICAS O QUÍMICAS; POLÍGRAFOS (MÁQUINAS DETECTORAS DE MENTIRAS); INSTRUMENTOS DE ANÁLISIS DE LABORATORIO (EQUIPOS DE ANÁLISIS DE SANGRE).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1091,'C265115','FABRICACIÓN DE INSTRUMENTOS PARA MEDICIÓN Y PRUEBAS DE ELECTRICIDAD Y SEÑALES ELÉCTRICAS (INCLUIDOS LOS DESTINADOS A ACTIVIDADES DE TELECOMUNICACIONES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1092,'C265116','FABRICACIÓN DE INSTRUMENTOS DE DETECCIÓN Y VIGILANCIA DE RADIACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1093,'C26512','FABRICACIÓN DE EQUIPOS PARA MEDICIÓN Y VERIFICACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1094,'C265121','FABRICACIÓN DE TERMÓMETROS DE BOLA DE VIDRIO RELLENA CON LÍQUIDO Y DE TERMÓMETROS BIMETÁLICOS (EXCEPTO TERMÓMETROS DE USO MÉDICO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1095,'C265122','FABRICACIÓN DE MEDIDORES DE FLUJÓMETRO Y DISPOSITIVOS CONTADORES, MANÓMETROS, CONTADORES TOTALIZADORES, CONTADORES DE CONSUMO DE AGUA, DE GAS, ETCÉTERA','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1096,'C265123','FABRICACIÓN DE BALANZAS Y BÁSCULAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1097,'C265124','FABRICACIÓN DE MICROSCOPIOS ELECTRÓNICOS Y PROTÓNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1098,'C265129','FABRICACIÓN DE OTROS EQUIPOS PARA MEDICIÓN Y VERIFICACIÓN: REGISTRADORES DE VUELO (CAJA NEGRA), ESPECTRÓMETROS, MEDIDORES DE NEUMÁTICOS, INCUBADORAS Y APARATOS DE LABORATORIO SIMILARES PARA MEDICIONES, PRUEBAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1099,'C26513','FABRICACIÓN DE EQUIPOS DE CONTROL Y BÚSQUEDA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1100,'C265131','FABRICACIÓN DE EQUIPO AERONÁUTICO Y NÁUTICO DE BÚSQUEDA, DETECCIÓN Y NAVEGACIÓN, INCLUIDAS SONARES, SONOBOYAS, EQUIPOS DE RADAR Y FABRICACIÓN DE DISPOSITIVOS GPS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1101,'C265132','FABRICACIÓN DE DETECTORES DE MOVIMIENTO; DETECTORES DE MINAS, GENERADORES DE IMPULSOS (SEÑALES); DETECTORES DE METAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1102,'C265139','FABRICACIÓN DE OTROS DISPOSITIVOS: DISPOSITIVOS DE CLIMATIZACIÓN Y DISPOSITIVOS AUTOMÁTICOS DE CONTROL PARA APARATOS DE USO DOMÉSTICO, LIMITADORES HIDRÓNICOS, DISPOSITIVOS DE CONTROL DE LA LLAMA Y DEL QUEMADOR, CONTROLES MEDIOAMBIENTALES Y CONTROLES AUTOMÁTICOS PARA DIVERSOS APARATOS, INSTRUMENTOS DE MEDIDA DE LA HUMEDAD (HIGROSTATOS), ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1103,'C26514','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPOS DE MEDICIÓN, PRUEBA, NAVEGACIÓN, CONTROL Y DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1104,'C265140','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPOS DE MEDICIÓN, PRUEBA, NAVEGACIÓN, CONTROL Y DE RELOJES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1105,'C2652','FABRICACIÓN DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1106,'C26520','FABRICACIÓN DE RELOJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1107,'C265201','FABRICACIÓN DE RELOJES DE TODO TIPO, INCLUIDO RELOJES PARA PANELES DE INSTRUMENTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1108,'C265202','FABRICACIÓN DE CAJAS DE RELOJES, INCLUIDAS CAJAS DE METALES PRECIOSOS Y SUS PARTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1109,'C265203','FABRICACIÓN DE APARATOS PARA REGISTRAR LA HORA DEL DÍA Y APARATOS PARA MEDIR, REGISTRAR O INDICAR DE OTRO MODO INTERVALOS DE TIEMPO MEDIANTE UN MECANISMO DE RELOJERÍA O UN MOTOR SINCRÓNICO COMO: PARQUÍMETROS, RELOJES DE CONTROL DE ENTRADA, MARCADORES DE FECHA Y HORA, CRONÓMETROS DE TIEMPOS DE FABRICACIÓN, CONMUTADORES HORARIOS Y OTROS DISPOSITIVOS DE PUESTA EN MARCHA CON MECANISMO DE RELOJERÍA O CON MOTOR SINCRÓNICO (CERRADURAS TEMPORIZADAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1110,'C265204','FABRICACIÓN DE PIEZAS SUELTAS PARA RELOJES: MUELLES, RUBÍES, ESFERAS, CHAPAS, PUENTES Y OTRAS PIEZAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1111,'C265205','SERVICIOS DE APOYO A LA FABRICACIÓN DE RELOJES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1112,'C266','FABRICACIÓN DE EQUIPO DE IRRADIACIÓN, Y EQUIPO ELECTRÓNICO DE USO MEDICO Y TERAPÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1113,'C2660','FABRICACIÓN DE EQUIPO DE IRRADIACIÓN, Y EQUIPO ELECTRÓNICO DE USO MEDICO Y TERAPÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1114,'C26600','FABRICACIÓN DE EQUIPO DE IRRADIACIÓN, Y EQUIPO ELECTRÓNICO DE USO MEDICO Y TERAPÉUTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1115,'C266001','FABRICACIÓN DE APARATOS DE IRRADIACIÓN SIMILARES (INDUSTRIALES O DE USO DIAGNÓSTICO, TERAPÉUTICO, CIENTÍFICO O DE INVESTIGACIÓN): EQUIPO DE RAYOS BETA, DE RAYOS GAMMA, DE RAYOS X Y OTROS TIPOS DE EQUIPO DE RADIACIÓN; ESCÁNERES DE TOMOGRAFÍA COMPUTADORIZADA (CT) Y POR EMISIÓN DE POSITRONES (PET); EQUIPO DE IRRADIACIÓN DE ALIMENTOS Y LECHE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1116,'C266002','FABRICACIÓN DE EQUIPO MEÉDICO PARA ELECTRODIAGNÓSTICO: EQUIPO DE TOMOGRAFÍA POR RESONANCIA MAGNÉTICA MRI, EQUIPO MÉDICO DE ULTRASONIDO, ELECTROCARDIÓGRAFOS, EQUIPO ELECTRÓNICO DE ENDOSCOPIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1117,'C266003','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPO DE IRRADIACIÓN, Y EQUIPO ELECTRÓNICO DE USO MÉDICO Y TERAPÉUTICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1118,'C266009','FABRICACIÓN DE OTROS EQUIPOS ELECTROMÉDICOS: MARCAPASOS, AUDÍFONOS, EQUIPO MÉDICO DE LÁSER, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1119,'C267','FABRICACIÓN DE INSTRUMENTOS ÓPTICOS Y EQUIPO FOTOGRÁFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1120,'C2670','FABRICACIÓN DE INSTRUMENTOS ÓPTICOS Y EQUIPO FOTOGRÁFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1121,'C26701','FABRICACIÓN DE INSTRUMENTOS ÓPTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1122,'C267011','FABRICACIÓN DE EQUIPOS DE POSICIONAMIENTO ÓPTICOS; ESPEJOS ÓPTICOS, LENTES, PRISMAS, ETCÉTERA, INCLUIDO EL REVESTIMIENTO, PULIDO Y MONTADURA DE LENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1123,'C267012','FABRICACIÓN DE INSTRUMENTOS DE AUMENTO ÓPTICOS; DISPOSITIVOS ÓPTICOS DE PUNTERÍA (MIRAS PARA ARMAS); INSTRUMENTOS ÓPTICOS DE PRECISIÓN PARA MECÁNICOS; COMPARADORES ÓPTICOS; ENSAMBLADOS DE LÁSER.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1124,'C267013','FABRICACIÓN DE MICROSCOPIOS ÓPTICOS, TELESCOPIOS Y BINOCULARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1125,'C26702','FABRICACIÓN DE EQUIPO FOTOGRÁFICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1126,'C267021','FABRICACIÓN DE CÁMARAS DE PELÍCULA Y CÁMARAS DIGITALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1127,'C267022','FABRICACIÓN DE PROYECTORES DE PELÍCULAS Y DIAPOSITIVAS; RETROPROYECTORES DE TRANSPARENCIAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1128,'C267023','FABRICACIÓN DE DISPOSITIVOS E INSTRUMENTOS ÓPTICOS DE MEDICIÓN Y VERIFICACIÓN (EQUIPOS DE CONTROL DE TIRO, FOTÓMETROS Y TELÉMETROS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1129,'C26703','SERVICIOS DE APOYO A LA FABRICACIÓN DE INSTRUMENTOS ÓPTICOS Y EQUIPO FOTOGRÁFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1130,'C267030','SERVICIOS DE APOYO A LA FABRICACIÓN DE INSTRUMENTOS ÓPTICOS Y EQUIPO FOTOGRÁFICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1131,'C268','FABRICACIÓN DE SOPORTES MAGNÉTICOS Y ÓPTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1132,'C2680','FABRICACIÓN DE SOPORTES MAGNÉTICOS Y ÓPTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1133,'C26800','FABRICACIÓN DE SOPORTES MAGNÉTICOS Y ÓPTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1134,'C268001','FABRICACIÓN DE CINTAS, CASSETTES, DISQUETES, TARJETAS CON BANDAS MAGNÉTICAS, SOPORTES PARA DISCO DURO VÍRGENES (EN BLANCO) DE: SONIDO, VIDEO Y DATOS','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1135,'C268002','FABRICACIÓN DE DISCOS ÓPTICOS VÍRGENES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1136,'C268003','SERVICIOS DE APOYO A LA FABRICACIÓN DE SOPORTES MAGNÉTICOS Y ÓPTICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1137,'C27','FABRICACIÓN DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1138,'C271','FABRICACIÓN DE MOTORES, GENERADORES, TRANSFORMADORES ELÉCTRICOS Y APARATOS DE DISTRIBUCIÓN Y CONTROL DE LA ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1139,'C2710','FABRICACIÓN DE MOTORES, GENERADORES, TRANSFORMADORES ELÉCTRICOS Y APARATOS DE DISTRIBUCIÓN Y CONTROL DE LA ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1140,'C27101','FABRICACIÓN DE MOTORES, GENERADORES, TRANSFORMADORES ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1141,'C271011','FABRICACIÓN DE TRANSFORMADORES DE DISTRIBUCIÓN, PARA SOLDADURA CON ARCO ELÉCTRICO, DE SUBESTACIÓN PARA LA DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA, DE REACTANCIAS (ES DECIR, TRANSFORMADORES) PARA LÁMPARAS FLUORESCENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1142,'C271012','FABRICACIÓN DE MOTORES ELÉCTRICOS (EXCEPTO LOS MOTORES DE ARRANQUE PARA MOTORES DE COMBUSTIÓN INTERNA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1143,'C271013','FABRICACIÓN DE GENERADORES DE FUERZA (EXCEPTO LOS ALTERNADORES CARGADOS POR BATERÍAS PARA MOTORES DE COMBUSTIÓN INTERNA); MOTORES GENERADORES (EXCEPTO TURBOGENERADORES); GENERADORES DE IMPULSIÓN, GRUPOS ELECTRÓGENOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1144,'C271014','FABRICACIÓN DE REGULADORES DEL VOLTAJE DE TRANSMISIÓN Y DISTRIBUCIÓN; REBOBINADO DE INDUCIDOS EN FÁBRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1145,'C271015','FABRICACIÓN DE PARTES DE: GENERADORES, MOTORES Y TRANSFORMADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1146,'C27102','FABRICACIÓN DE APARATOS DE DISTRIBUCIÓN Y CONTROL DE LA ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1147,'C271021','FABRICACIÓN DE DISYUNTORES DE CIRCUITOS ELÉCTRICOS; LIMITADORES DE SOBRETENSIÓN (PARA VOLTAJES DE DISTRIBUCIÓN); FUSIBLES ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1148,'C271022','FABRICACIÓN DE PANELES DE CONTROL PARA LA DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA; CONDUCTOS PARA CUADROS DE DISTRIBUCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1149,'C271023','FABRICACIÓN DE RELÉS ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1150,'C271024','FABRICACIÓN DE CONMUTADORES (EXCEPTO LOS DE PULSADOR, DE RESORTE, SOLENOIDALES, OSCILANTES), EQUIPOS DE CONMUTACIÓN, PORTALÁMPARAS, CLAVIJAS, TERMINALES Y OTROS CONECTORES ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1151,'C27103','SERVICIOS DE APOYO A LA FABRICACIÓN DE MOTORES, GENERADORES, TRANSFORMADORES ELÉCTRICOS Y APARATOS DE DISTRIBUCIÓN Y CONTROL DE LA ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1152,'C271030','SERVICIOS DE APOYO A LA FABRICACIÓN DE MOTORES, GENERADORES, TRANSFORMADORES ELÉCTRICOS Y APARATOS DE DISTRIBUCIÓN Y CONTROL DE LA ENERGÍA ELÉCTRICA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1153,'C272','FABRICACIÓN DE PILAS, BATERÍAS Y ACUMULADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1154,'C2720','FABRICACIÓN DE PILAS, BATERÍAS Y ACUMULADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1155,'C27200','FABRICACIÓN DE PILAS, BATERÍAS Y ACUMULADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1156,'C272001','FABRICACIÓN DE PILAS Y BATERÍAS PRIMARIAS: PILAS DE DIÓXIDO DE MANGANESO, DIÓXIDO DE MERCURIO, ÓXIDO DE PLATA, PLOMO-ÁCIDO, NÍQUEL-CADMIO, NÍQUEL E HIDRURO METÁLICO, LITIO, PILAS SECAS Y HÚMEDAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1157,'C272002','FABRICACIÓN DE ACUMULADORES ELÉCTRICOS Y PARTES DE ACUMULADORES, SEPARADORES, CONTENEDORES, TAPAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1158,'C272003','SERVICIOS DE APOYO A LA FABRICACIÓN DE PILAS, BATERÍAS Y ACUMULADORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1159,'C273','FABRICACIÓN DE CABLES Y DISPOSITIVOS DE CABLEADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1160,'C2731','FABRICACIÓN DE CABLES DE FIBRA ÓPTICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1161,'C27310','FABRICACIÓN DE CABLES DE FIBRA ÓPTICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1162,'C273101','FABRICACIÓN DE CABLES DE FIBRA ÓPTICA PARA LA TRANSMISIÓN DE DATOS O LA TRANSMISIÓN DE IMÁGENES EN DIRECTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1163,'C273102','SERVICIOS DE APOYO A LA FABRICACIÓN DE CABLES DE FIBRA ÓPTICA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1164,'C2732','FABRICACIÓN DE OTROS HILOS Y CABLES ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1165,'C27320','FABRICACIÓN DE OTROS HILOS Y CABLES ELÉCTRICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1166,'C273201','FABRICACIÓN DE HILOS Y CABLES AISLADOS DE ACERO, COBRE, ALUMINIO Y OTROS JUEGOS DE CABLES ELÉCTRICOS AISLADOS Y ENCHUFE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1167,'C273202','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS HILOS Y CABLES ELÉCTRICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1168,'C2733','FABRICACIÓN DE DISPOSITIVOS DE CABLEADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1169,'C27330','FABRICACIÓN DE DISPOSITIVOS DE CABLEADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1170,'C273301','FABRICACIÓN DE BARRAS COLECTORAS Y OTROS CONDUCTORES ELÉCTRICOS (EXCEPTO DEL TIPO DE LOS UTILIZADOS EN CONMUTADORES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1171,'C273302','FABRICACIÓN DE INTERRUPTORES DE CIRCUITO POR FALTA DE CONEXIÓN A TIERRA (GFCI).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1172,'C273303','FABRICACIÓN DE PORTALÁMPARAS, PARARRAYOS, CONMUTADORES (DE PRESIÓN, DE BOTÓN, DE RESORTE, OSCILANTES), ENCHUFES Y TOMAS DE CORRIENTE, CAJAS PARA CABLEADO (DE CONEXIONES, DE TOMA DE CORRIENTE, DE CONMUTACIÓN).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1173,'C273304','SERVICIOS DE APOYO A LA FABRICACIÓN DE DISPOSITIVOS DE CABLEADO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1174,'C273309','FABRICACIÓN DE OTROS DISPOSITIVOS DE CABLEADO: DISPOSITIVOS DE CABLEADO DE PLÁSTICO NO PORTADORES DE CORRIENTE, COMO CAJAS DE CONEXIONES, CHAPAS FRONTALES Y ARTÍCULOS SIMILARES, ACCESORIOS DE PLÁSTICO PARA TENDIDOS AÉREOS, DISPOSITIVOS PARA POSTES Y LÍNEAS DE TRANSMISIÓN, CONDUCTOS Y ACCESORIOS ELÉCTRICOS (CANALETAS), ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1175,'C274','FABRICACIÓN DE EQUIPO ELÉCTRICO DE ILUMINACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1176,'C2740','FABRICACIÓN DE EQUIPO ELÉCTRICO DE ILUMINACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1177,'C27400','FABRICACIÓN DE EQUIPO ELÉCTRICO DE ILUMINACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1178,'C274001','FABRICACIÓN DE LÁMPARAS, TUBOS Y BOMBILLAS DE DESCARGA, INCANDESCENTES, FLUORESCENTES, DE RAYOS ULTRAVIOLETAS, DE RAYOS INFRARROJOS, LÁMPARAS DE DESTELLOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1179,'C274002','FABRICACIÓN DE LÁMPARAS DE TECHO, ARAÑAS COLGANTES, LÁMPARAS DE MESA, JUEGOS DE LUCES PARA DECORAR ÁRBOLES DE NAVIDAD, LÁMPARAS ELÉCTRICAS CONTRA INSECTOS, TRONCOS ELÉCTRICOS PARA CHIMENEA, LÁMPARAS PARA LA ILUMINACIÓN DE LAS CALLES (EXCEPTO SEÑALES DE TRÁFICO), PROYECTORES DE TEATRO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1180,'C274003','FABRICACIÓN DE LINTERNAS (DE CARBURO, ELÉCTRICAS, DE GAS, DE GASOLINA, DE QUEROSENO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1181,'C274004','FABRICACIÓN DE EQUIPO DE ILUMINACIÓN PARA EQUIPO DE TRANSPORTE (VEHÍCULOS AUTOMOTORES, AERONAVES, EMBARCACIONES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1182,'C274005','FABRICACIÓN DE EQUIPO DE ILUMINACIÓN NO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1183,'C274006','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPO ELÉCTRICO DE ILUMINACIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1184,'C275','FABRICACIÓN DE APARATOS DE USO DOMÉSTICO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1185,'C2750','FABRICACIÓN DE APARATOS DE USO DOMÉSTICO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1186,'C27500','FABRICACIÓN DE APARATOS DE USO DOMÉSTICO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1187,'C275001','FABRICACIÓN DE APARATOS ELÉCTRICOS DE USO DOMÉSTICO: REFRIGERADORES, CONGELADORES, LAVAPLATOS, LAVADORAS Y SECADORAS, ASPIRADORAS, ENCERADORAS DE PISOS, TRITURADORAS DE DESPERDICIOS, MOLINILLOS DE CAFÉ, LICUADORAS, EXPRIMIDORAS, ABRELATAS, MÁQUINAS DE AFEITAR ELÉCTRICAS, CEPILLOS DENTALES ELÉCTRICOS Y OTROS APARATOS ELÉCTRICOS DE CUIDADO PERSONAL, AFILADORAS DE CUCHILLOS, CAMPANAS DE VENTILACIÓN O DE ABSORCIÓN DE HUMOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1188,'C275002','FABRICACIÓN DE APARATOS TERMOELÉCTRICOS DE USO DOMÉSTICO: CALENTADORES DE AGUA ELÉCTRICOS, MANTAS ELÉCTRICAS, SECADORES, PEINES, CEPILLOS Y TENACILLAS ELÉCTRICOS, PLANCHAS ELÉCTRICAS, CALENTADORES DE AMBIENTE Y VENTILADORES PORTÁTILES, HORNOS ELÉCTRICOS, HORNOS DE MICROONDAS, COCINILLAS Y PLANCHAS DE COCINAR ELÉCTRICAS, TOSTADORAS, CAFETERAS Y TETERAS, SARTENES, ASADORES, PARRILLAS, CAMPANAS, CALENTADORES ELÉCTRICOS DE RESISTENCIA, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1189,'C275003','FABRICACIÓN DE EQUIPO DE COCINA Y CALEFACCIÓN DE USO DOMÉSTICO NO ELÉCTRICO: CALENTADORES DE AMBIENTE, COCINILLAS, PARRILLAS, COCINAS, HORNOS, CALENTADORES DE AGUA (CALEFONES), APARATOS DE COCINA Y CALENTADORES DE PLATOS NO ELÉCTRICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1190,'C275004','SERVICIOS DE APOYO A LA FABRICACIÓN DE APARATOS DE USO DOMÉSTICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1191,'C279','FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1192,'C2790','FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1193,'C27901','FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1194,'C279011','FABRICACIÓN DE INVERTIDORES, RECTIFICADORES, CÉLULAS ENERGÉTICAS, UNIDADES DE SUMINISTRO DE POTENCIA REGULADA Y NO REGULADA DE ESTADO SÓLIDO; FABRICACIÓN DE CARGADORES DE PILAS, BATERÍAS DE ESTADO SÓLIDO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1195,'C279012','FABRICACIÓN DE EQUIPO ELÉCTRICO DE SEÑALIZACIÓN COMO: SEMÁFOROS Y SEÑALES PEATONALES, SEÑALES ELÉCTRICAS, MARCADORES ELECTRÓNICOS, DISPOSITIVOS ELÉCTRICOS DE APERTURA Y CIERRE DE PUERTAS, TIMBRES ELÉCTRICOS, SIRENAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1196,'C279013','FABRICACIÓN DE EQUIPO ELÉCTRICO DE SOLDADURA AUTÓGENA Y DE SOLDADURA BLANDA, INCLUIDOS SOLDADORES MANUALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1197,'C279019','FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO: LIMPIADORES ULTRASÓNICOS (EXCEPTO LOS DE USO ODONTOLÓGICO Y DE LABORATORIO), CAMAS BRONCEADORAS, LIMITADORES DE SOBRETENSIÓN (EXCEPTO PARA VOLTAJES DE DISTRIBUCIÓN), ACELERADORES DE PARTÍCULAS, UNIDADES DE SUMINISTRO ININTERRUMPIDO DE ENERGÍA, APARATOS ELÉCTRICOS CON FUNCIONES ESPECIALES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1198,'C27902','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1199,'C279020','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE EQUIPO ELÉCTRICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1200,'C27909','FABRICACIÓN DE OTRO MATERIAL ELÉCTRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1201,'C279091','FABRICACIÓN DE CAPACITORES, RESISTORES, CONDENSADORES Y COMPONENTES ELÉCTRICOS SIMILARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1202,'C279092','FABRICACIÓN DE ELECTROIMANES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1203,'C279094','FABRICACIÓN DE ELECTRODOS Y CONTACTOS DE CARBONO Y GRAFITO Y OTROS PRODUCTOS ELÉCTRICOS DE CARBÓN Y GRAFITO, AISLADORES ELÉCTRICOS (EXCEPTO LOS DE VIDRIO O PORCELANA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1204,'C28','FABRICACIÓN DE MAQUINARIA Y EQUIPO N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1205,'C281','FABRICACIÓN DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAVES, VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1206,'C2811','FABRICACIÓN DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAVES, VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1207,'C28110','FABRICACIÓN DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAVES, VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1208,'C281101','FABRICACIÓN DE MOTORES DE COMBUSTIÓN INTERNA DE PISTONES, EXCEPTO MOTORES DE PROPULSIÓN DE VEHÍCULOS AUTOMOTORES, AERONAVES Y MOTOCICLETAS: MOTORES MARINOS, MOTORES PARA LOCOMOTORAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1209,'C281102','FABRICACIÓN DE PISTONES, AROS DE PISTÓN, VÁLVULAS DE ADMISIÓN, ESCAPES, CARBURADORES Y PIEZAS SIMILARES PARA TODO TIPO DE MOTORES DE COMBUSTIÓN INTERNA, MOTORES DIESEL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1210,'C281103','FABRICACIÓN DE TURBINAS Y PARTES DE TURBINAS: TURBINAS DE VAPOR DE AGUA Y OTROS TIPOS DE VAPOR, TURBINAS HIDRÁULICAS, RUEDAS HIDRÁULICAS Y MAQUINARIA PARA SU REGULACIÓN, TURBINAS EÓLICAS, TURBINAS DE GAS, EXCEPTO TURBOPROPULSORES DE REACCIÓN O DE HÉLICE PARA LA PROPULSIÓN DE AERONAVES,  TURBOCALDERAS (CONJUNTOS DE CALDERA Y TURBINA), TURBOALTERNADORES, GRUPOS TURBOGENERADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1211,'C281104','SERVICIOS DE APOYO A LA FABRICACIÓN DE MOTORES Y TURBINAS, EXCEPTO MOTORES PARA AERONAVES, VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1212,'C2812','FABRICACIÓN DE EQUIPO DE PROPULSIÓN DE FLUIDOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1213,'C28120','FABRICACIÓN DE EQUIPO DE PROPULSIÓN DE FLUIDOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1214,'C281201','FABRICACIÓN DE COMPONENTES HIDRÁULICOS Y NEUMÁTICOS: BOMBAS Y SISTEMAS DE PROPULSIÓN DE FLUIDOS, EQUIPO DE TRANSMISIÓN HIDRÁULICO, TRANSMISIONES HIDROSTÁTICAS, MOTORES HIDRÁULICOS; EQUIPO DE PREPARACIÓN DEL AIRE PARA SISTEMAS NEUMÁTICOS, CILINDROS, VÁLVULAS, TUBOS Y EMPALMES HIDRÁULICOS Y NEUMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1215,'C281202','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPO DE PROPULSIÓN DE FLUIDOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1216,'C2813','FABRICACIÓN DE OTRAS BOMBAS, COMPRESORES, GRIFOS Y VÁLVULAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1217,'C28130','FABRICACIÓN DE OTRAS BOMBAS, COMPRESORES, GRIFOS Y VÁLVULAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1218,'C281301','FABRICACIÓN DE BOMBAS DE AIRE O DE VACÍO, COMPRESORES DE AIRE Y OTROS COMPRESORES DE GAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1219,'C281302','FABRICACIÓN DE BOMBAS PARA LÍQUIDOS, TENGAN O NO DISPOSITIVOS DE MEDICIÓN; BOMBAS PARA MOTORES DE COMBUSTIÓN INTERNA: BOMBAS DE ACEITE, AGUA Y COMBUSTIBLE PARA VEHÍCULOS AUTOMOTORES, ETCÉTERA; BOMBAS MANUALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1220,'C281303','FABRICACIÓN DE GRIFOS Y VÁLVULAS INDUSTRIALES, SANITARIOS, CALEFACCIÓN, INCLUIDOS VÁLVULAS DE REGULACIÓN Y GRIFOS DE ADMISIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1221,'C281304','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTRAS BOMBAS, COMPRESORES, GRIFOS Y VÁLVULAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1222,'C2814','FABRICACIÓN DE COJINETES, ENGRANAJES, TRENES DE ENGRANAJES Y PIEZAS DE TRANSMISIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1223,'C28140','FABRICACIÓN DE COJINETES, ENGRANAJES, TRENES DE ENGRANAJES Y PIEZAS DE TRANSMISIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1224,'C281401','FABRICACIÓN DE COJINETES DE BOLA Y DE RODILLO Y DE PARTES DE COJINETES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1225,'C281402','FABRICACIÓN DE EQUIPO MECÁNICO DE TRANSMISIÓN: EJES Y MANIVELAS DE TRANSMISIÓN, EJES DE LEVAS, CIGÜEÑALES, MANIVELAS, ETCÉTERA, CAJAS DE COJINETES Y COJINETES SIMPLES PARA EJES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1226,'C281403','FABRICACIÓN DE ENGRANAJES, TRENES DE ENGRANAJES, CAJAS DE ENGRANAJES Y OTROS DISPOSITIVOS PARA CAMBIOS DE MARCHAS; EMBRAGUES Y ACOPLAMIENTOS DE EJES; VOLANTES Y POLEAS; ESLABONES ARTICULADOS Y CADENAS DE TRANSMISIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1227,'C281404','SERVICIOS DE APOYO A LA FABRICACIÓN DE COJINETES, ENGRANAJES, TRENES DE ENGRANAJES Y PIEZAS DE TRANSMISIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1228,'C2815','FABRICACIÓN DE HORNOS Y QUEMADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1229,'C28150','FABRICACIÓN DE HORNOS Y QUEMADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1230,'C281501','FABRICACIÓN DE HORNOS ELÉCTRICOS Y DE OTRO TIPO PARA USO INDUSTRIAL Y DE LABORATORIO, INCLUIDOS INCINERADORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1231,'C281502','FABRICACIÓN DE EQUIPO FIJO DE CALEFACCIÓN DE USO DOMÉSTICO COMO CALEFACCIÓN: SOLAR, POR VAPOR, DE FUEL Y EQUIPO SIMILAR, CALENTADORES DE AMBIENTE ELÉCTRICOS FIJOS Y CALENTADORES ELÉCTRICOS PARA PISCINAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1232,'C281503','FABRICACIÓN DE CARGADORES MECÁNICOS, PARRILLAS MECÁNICAS, DESCARGADORES MECÁNICOS DE CENIZAS, QUEMADORES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1233,'C281504','SERVICIOS DE APOYO A LA FABRICACIÓN DE HORNOS Y QUEMADORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1234,'C2816','FABRICACIÓN DE EQUIPO DE ELEVACIÓN Y MANIPULACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1235,'C28160','FABRICACIÓN DE EQUIPO DE ELEVACIÓN Y MANIPULACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1236,'C281601','FABRICACIÓN DE MAQUINARIA DE ELEVACIÓN, MANIPULACIÓN, CARGA O DESCARGA, MANUAL O ELÉCTRICA: POLIPASTOS Y ELEVADORES, CABRIAS, CABRESTANTES Y GATOS, GRÚAS DE BRAZO MÓVIL, GRÚAS CORRIENTES, BASTIDORES ELEVADORES MÓVILES, CAMIONES DE PÓRTICO ALTO, ETCÉTERA, CARRETILLAS DE FAENA, ESTÉN PROVISTAS O NO DE EQUIPO DE ELEVACIÓN O MANIPULACIÓN, Y SEAN AUTOPROPULSADAS O NO, COMO LAS QUE SE UTILIZAN EN FÁBRICAS (INCLUIDOS CARRETILLAS Y CARROS DE MANO); MANIPULADORES MECÁNICOS Y ROBOTS INDUSTRIALES DISEÑADOS ESPECIALMENTE PARA OPERACIONES DE ELEVACIÓN, MANIPULACIÓN, CARGA O DESCARGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1237,'C281602','FABRICACIÓN DE ASCENSORES, ESCALERAS MECÁNICAS Y PASILLOS RODANTES, CINTAS TRANSPORTADORAS, TELEFÉRICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1238,'C281603','FABRICACIÓN DE PARTES Y PIEZAS ESPECIALES PARA EQUIPO DE ELEVACIÓN Y MANIPULACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1239,'C281604','SERVICIOS DE APOYO A LA FABRICACIÓN DE EQUIPO DE ELEVACIÓN Y MANIPULACIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1240,'C2817','FABRICACIÓN DE MAQUINARIA Y EQUIPO DE OFICINA (EXCEPTO COMPUTADORAS Y EQUIPO PERIFÉRICO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1241,'C28170','FABRICACIÓN DE MAQUINARIA Y EQUIPO DE OFICINA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1242,'C281701','FABRICACIÓN DE MÁQUINAS CALCULADORAS ELECTRÓNICAS O NO, MÁQUINAS DE SUMAR Y MÁQUINAS REGISTRADORAS INCLUSO ACCIONADAS MECÁNICAMENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1243,'C281702','FABRICACIÓN DE MÁQUINAS DE ESCRIBIR, MÁQUINAS DE ESTENOTIPIA, MÁQUINAS PARA RELLENAR CHEQUES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1244,'C281703','FABRICACIÓN DE MÁQUINAS PARA EL FRANQUEO Y LA MANIPULACIÓN DE CORRESPONDENCIA (MÁQUINAS PARA LLENAR Y CERRAR SOBRES Y PARA IMPRIMIR DIRECCIONES, MÁQUINAS PARA ABRIR, CLASIFICAR Y ESCANEAR CORRESPONDENCIA), MÁQUINAS DE ENCOLAR, MÁQUINAS PARA CONTAR Y ENVOLVER MONEDAS, MÁQUINAS DISTRIBUIDORAS DE BILLETES, MÁQUINAS DE VOTACIÓN, DICTÁFONOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1245,'C281704','FABRICACIÓN DE FOTOCOPIADORAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1246,'C281705','FABRICACIÓN DE EQUIPO DE ENCUADERNACIÓN DEL TIPO UTILIZADO EN OFICINAS (ES DECIR, PARA ENCUADERNAR CON PLÁSTICO O CON CINTA ADHESIVA), PUNZONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1247,'C281706','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA Y EQUIPO DE OFICINA (EXCEPTO ORDENADORES Y EQUIPO PERIFÉRICO) A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1248,'C281709','FABRICACIÓN DE AFILADORES DE LÁPICES, GRAPADORAS, QUITAGRAPAS, PORTARROLLOS PARA CINTA ADHESIVA, CARTUCHOS DE TINTA (TONER), PIZARRAS, ENCERADOS Y TABLEROS PARA ESCRIBIR CON ROTULADOR, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1249,'C2818','FABRICACIÓN DE HERRAMIENTAS DE MANO MOTORIZADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1250,'C28180','FABRICACIÓN DE HERRAMIENTAS DE MANO MOTORIZADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1251,'C281801','FABRICACIÓN DE HERRAMIENTAS DE MANO CON MOTOR AUTÓNOMO ELÉCTRICO O NO ELÉCTRICO, COMO: SIERRAS CIRCULARES O CON MOVIMIENTO ALTERNATIVO, TALADROS, PULIDORAS, TUPÍES, LIJADORAS, AFILADORAS, CLAVADORAS MOTORIZADAS, CEPILLADORAS, CIZALLAS Y RECORTADORAS DE CHAPA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1252,'C281802','FABRICACIÓN DE HERRAMIENTAS DE MANO DE AIRE COMPRIMIDO, COMO: PERFORADORAS DE PERCUSIÓN, CLAVADORAS NEUMÁTICAS, ENGRAPADORAS, REMACHADORAS NEUMÁTICAS, APRIETA TUERCAS NEUMÁTICOS DE PERCUSIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1253,'C281803','SERVICIOS DE APOYO A LA FABRICACIÓN DE HERRAMIENTAS DE MANO MOTORIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1254,'C2819','FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1255,'C28191','FABRICACIÓN DE EQUIPO DE REFRIGERACIÓN, MAQUINARIA PARA PESAR Y EMBALAJE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1256,'C281911','FABRICACIÓN DE EQUIPO INDUSTRIAL DE REFRIGERACIÓN O DE CONGELACIÓN, INCLUIDOS CONJUNTOS MONTADOS DE COMPONENTES PRINCIPALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1257,'C281912','FABRICACIÓN DE BÁSCULAS Y BALANZAS (EXCEPTO BALANZAS DE PRECISIÓN PARA LABORATORIOS): BALANZAS DE USO DOMÉSTICO, BALANZAS DE PLATAFORMA, BALANZAS DE PESADA CONTINUA, BÁSCULAS PARA VEHÍCULOS, PESAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1258,'C281913','FABRICACIÓN DE MAQUINARIA PARA EMPAQUETAR Y ENVOLVER: MÁQUINAS PARA LLENAR, CERRAR, SELLAR, ENCAPSULAR, ETIQUETAR, ETCÉTERA; MAQUINARIA PARA LIMPIAR O SECAR BOTELLAS Y PARA LA AIREACIÓN DE BEBIDAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1259,'C28192','FABRICACIÓN DE MAQUINAS Y APARATOS PARA VENTILACIÓN, FILTRACIÓN, DEPURACIÓN Y DISTRIBUCIÓN DE LÍQUIDOS, GASES O POLVOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1260,'C281921','FABRICACIÓN DE APARATOS DE ACONDICIONAMIENTO DE AIRE, INCLUIDOS LOS UTILIZADOS EN VEHÍCULOS AUTOMOTORES; VENTILADORES DISTINTOS DE LOS DE USO DOMÉSTICO, DISPOSITIVOS DE VENTILACIÓN DE DESVANES (VENTILADORES DE TEJADO, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1261,'C281922','FABRICACIÓN DE MAQUINARIA Y APARATOS DE FILTRADO O DEPURACIÓN DE LÍQUIDOS, INCLUSO FILTROS DE ACEITE, AIRE, GAS PARA MOTORES DE COMBUSTIÓN INTERNA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1262,'C281923','FABRICACIÓN DE EQUIPO PARA PROYECTAR, DISPERSAR O PULVERIZAR LÍQUIDOS O POLVOS: PISTOLAS DE PULVERIZACIÓN, EXTINTORES DE INCENDIOS, MÁQUINAS DE LIMPIEZA POR CHORRO DE ARENA, MÁQUINAS DE LIMPIEZA AL VAPOR, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1263,'C281924','FABRICACIÓN DE PLANTAS DESTILADORAS Y RECTIFICADORAS PARA LAS REFINERÍAS DE PETRÓLEO, LA INDUSTRIA QUÍMICA, LA INDUSTRIA DE ELABORACIÓN DE BEBIDAS, ETCÉTERA; MAQUINARIA PARA LICUAR AIRE O GAS, GENERADORES DE GAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1264,'C281925','FABRICACIÓN DE INTERCAMBIADORES DE CALOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1265,'C28193','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1266,'C281930','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO GENERAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1267,'C28199','FABRICACIÓN DE OTRAS MAQUINAS DE USO GENERAL N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1268,'C281991','FABRICACIÓN DE CALANDRIAS Y OTRAS MÁQUINAS DE LAMINADO, Y DE RODILLOS PARA ESAS MÁQUINAS (EXCEPTO LAS LAMINADORAS DE METAL Y VIDRIO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1269,'C281992','FABRICACIÓN DE CENTRIFUGADORAS (EXCEPTO DESCREMADORAS Y SECADORAS DE ROPA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1270,'C281993','FABRICACIÓN DE JUNTAS Y PIEZAS DE EMPALME SIMILARES HECHAS DE UNA COMBINACIÓN DE MATERIALES Y DE CAPAS DE UN MISMO MATERIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1271,'C281994','FABRICACIÓN DE MÁQUINAS AUTOMÁTICAS DE VENTA DE PRODUCTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1272,'C281995','FABRICACIÓN DE NIVELES, CINTAS MÉTRICAS Y HERRAMIENTAS DE MANO SIMILARES, HERRAMIENTAS DE PRECISIÓN PARA MECÁNICOS (EXCEPTO INSTRUMENTOS ÓPTICOS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1273,'C281996','FABRICACIÓN DE EQUIPO NO ELÉCTRICO DE SOLDADURA AUTÓGENA Y DE SOLDADURA BLANDA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1274,'C281997','FABRICACIÓN DE PARTES Y PIEZAS DE MAQUINARIA DE USO GENERAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1275,'C282','FABRICACIÓN DE MAQUINARIA DE USO ESPECIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1276,'C2821','FABRICACIÓN DE MAQUINARIA AGROPECUARIA Y FORESTAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1277,'C28210','FABRICACIÓN DE MAQUINARIA AGROPECUARIA Y FORESTAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1278,'C282101','FABRICACIÓN DE TRACTORES UTILIZADOS EN ACTIVIDADES AGROPECUARIAS Y SILVÍCOLA: TRACTORES DE MANEJO A PIE (DIRIGIDOS POR UNA PERSONA DESDE FUERA), MOTOCULTORES, SEGADORAS, INCLUIDAS SEGADORAS DE CÉSPED, REMOLQUES Y SEMIRREMOLQUES DE CARGA Y DESCARGA AUTOMÁTICA PARA USO AGRÍCOLA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1279,'C282102','FABRICACIÓN DE MÁQUINAS UTILIZADAS EN LA AGRICULTURA PARA PREPARAR LOS SUELOS, PLANTAR O ABONAR: ARADOS, ESPARCIDORAS DE ESTIÉRCOL, SEMBRADORAS, RASTRILLADORAS, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1280,'C282103','FABRICACIÓN DE MÁQUINAS PARA LA RECOLECCIÓN Y TRILLA: COSECHADORAS, TRILLADORAS, CRIBADORAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1281,'C282104','FABRICACIÓN DE MÁQUINAS DE ORDEÑAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1282,'C282105','FABRICACIÓN DE ASPERSORES DE USO AGRÍCOLA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1283,'C282106','FABRICACIÓN DE OTRA MAQUINARIA DE USO AGROPECUARIO: MÁQUINAS UTILIZADAS EN LA AVICULTURA Y LA APICULTURA, EQUIPO PARA LA PREPARACIÓN DE PIENSO, ETCÉTERA, MÁQUINAS PARA LIMPIAR, SELECCIONAR Y CLASIFICAR HUEVOS, FRUTA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1284,'C282107','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA AGROPECUARIA Y FORESTAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1285,'C2822','FABRICACIÓN DE MAQUINARIA PARA LA CONFORMACIÓN DE METALES Y DE MÁQUINAS HERRAMIENTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1286,'C28220','FABRICACIÓN DE MAQUINARIA PARA LA CONFORMACIÓN DE METALES Y DE MÁQUINAS HERRAMIENTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1287,'C282201','FABRICACIÓN DE MÁQUINAS HERRAMIENTA PARA TRABAJAR METALES Y OTROS MATERIALES (MADERA, HUESO, PIEDRA, CAUCHO ENDURECIDO, PLÁSTICOS DUROS, VIDRIO EN FRÍO, ETCÉTERA), INCLUIDAS LAS QUE UTILIZAN RAYOS LÁSER, ONDAS ULTRASÓNICAS, ARCOS DE PLASMA, IMPULSOS MAGNÉTICOS, ETCÉTERA; MÁQUINAS FIJAS PARA CLAVAR, ENGRAPAR, ENCOLAR Y MONTAR DE OTRA MANERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1288,'C282202','FABRICACIÓN DE MÁQUINAS HERRAMIENTA PARA TORNEAR, PERFORAR, FRESAR, CONFORMAR, CEPILLAR, RECTIFICAR, TALADRAR (TALADRADORAS ROTATORIAS Y DE PERCUSIÓN), LIMADORAS, REMACHADORAS, CORTADORAS DE LÁMINAS DE METAL, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1289,'C282203','FABRICACIÓN DE MÁQUINAS HERRAMIENTA PARA ESTAMPAR Y PRENSAR, PUNZONADORAS, PRENSAS HIDRÁULICAS, MACHACADORAS HIDRÁULICAS, MARTINETES, MÁQUINAS DE FORJAR, ETCÉTERA, FABRICACIÓN DE BANCOS DE TREFILAR, MÁQUINAS DE ATERRAJAR POR LAMINADO A PRESIÓN Y MÁQUINAS PARA TRABAJAR ALAMBRE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1290,'C282204','FABRICACIÓN DE PRENSAS PARA LA FABRICACIÓN DE TABLEROS DE PARTÍCULAS Y PRODUCTOS SIMILARES; MAQUINARIA PARA GALVANOPLASTIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1291,'C282205','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA LAS MÁQUINAS HERRAMIENTA ANTERIORMENTE ENUMERADAS: MANDRILES DE SUJECIÓN, CABEZALES DIVISORIOS Y OTROS ACCESORIOS ESPECIALES PARA MÁQUINAS HERRAMIENTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1292,'C282206','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA PARA LA CONFORMACIÓN DE METALES Y DE MÁQUINAS HERRAMIENTA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1293,'C2823','FABRICACIÓN DE MAQUINARIA METALÚRGICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1294,'C28230','FABRICACIÓN DE MAQUINARIA METALÚRGICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1295,'C282301','FABRICACIÓN DE MÁQUINAS Y EQUIPO PARA LA MANIPULACIÓN DE METALES EN CALIENTE: CONVERTIDORES, LINGOTERAS, CALDEROS DE COLADA, MÁQUINAS DE FUNDIR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1296,'C282302','FABRICACIÓN DE MÁQUINAS LAMINADORAS DE METAL Y DE RODILLOS PARA ESAS MÁQUINAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1297,'C282303','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA METALÚRGICA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1298,'C2824','FABRICACIÓN DE MAQUINARIA PARA LA EXPLOTACIÓN DE MINAS Y CANTERAS Y PARA OBRAS DE CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1299,'C28240','FABRICACIÓN DE MAQUINARIA PARA LA EXPLOTACIÓN DE MINAS Y CANTERAS Y PARA OBRAS DE CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1300,'C282401','FABRICACIÓN DE ELEVADORES Y CINTAS TRANSPORTADORAS DE MARCHA CONTINÚA PARA USO EN OBRAS SUBTERRÁNEAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1301,'C282402','FABRICACIÓN DE MAQUINARIA PARA PERFORAR, CORTAR, HINCAR Y TUNELAR (DESTINADA O NO A OBRAS SUBTERRÁNEAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1302,'C282403','FABRICACIÓN DE MAQUINARIA PARA EL TRATAMIENTO DE MINERALES MEDIANTE CRIBADO, CLASIFICACIÓN, SEPARACIÓN, LAVADO, TRITURACIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1303,'C282404','FABRICACIÓN DE MÁQUINAS PARA HINCAR Y ARRANCAR PILOTES, ESPARCIDORAS DE HORMIGÓN, ESPARCIDORAS DE ASFALTO, MAQUINARIA PARA PAVIMENTAR CON HORMIGÓN, MEZCLADORAS DE HORMIGÓN Y MORTERO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1304,'C282405','FABRICACIÓN DE MAQUINARIA PARA EL MOVIMIENTO DE TIERRAS: TOPADORAS CORRIENTES, TOPADORAS DE PALA ANGULAR, EXPLANADORAS, NIVELADORAS, TRABILLAS, PALAS MECÁNICAS, CARGADORAS DE CUCHARÓN, PALAS PARA TOPADORAS CORRIENTES Y DE PALA ANGULAR, TRACTORES DE ORUGA, TRACTORES UTILIZADOS EN OBRAS DE CONSTRUCCIÓN Y EN LA EXPLOTACIÓN DE MINAS Y CANTERAS, CAMIONES CON VOLQUETE PARA TODO TERRENO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1305,'C282406','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA PARA LA EXPLOTACIÓN DE MINAS Y CANTERAS Y PARA OBRAS DE CONSTRUCCIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1306,'C2825','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1307,'C28250','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1308,'C282501','FABRICACIÓN DE SECADORAS AGRÍCOLAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1309,'C282502','FABRICACIÓN DE MAQUINARIA PARA LA INDUSTRIA LECHERA: DESCREMADORAS, MAQUINARIA PARA LA ELABORACIÓN DE LA LECHE (HOMOGENEIZADORAS), PARA LA TRANSFORMACIÓN DE LA LECHE (MANTEQUERAS, MALAXADORAS Y MOLDEADORAS), PARA HACER QUESOS (HOMOGENIZADORAS, MOLDEADORAS, PRENSAS), ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1310,'C282503','FABRICACIÓN DE MAQUINARIA PARA LA MOLIENDA DE GRANOS: MAQUINARIA PARA LIMPIAR, SELECCIONAR Y CLASIFICAR SEMILLAS, GRANOS Y LEGUMINOSAS SECAS (AVENTADORAS, CRIBADORAS, CINTAS CRIBADORAS, SEPARADORAS, CEPILLADORAS, ETCÉTERA) MAQUINARIA PARA LA PRODUCCIÓN DE HARINAS Y SÉMOLAS, ETCÉTERA (TRITURADORAS, ALIMENTADORAS, CRIBADORAS, DEPURADORAS DE AFRECHO (SALVADO), MEZCLADORAS, DESCASCARILLADORAS DE ARROZ, PARTIDORAS DE GUISANTES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1311,'C282504','FABRICACIÓN DE PRENSAS, TRITURADORAS, TRAPICHES, ETCÉTERA, UTILIZADAS EN LA ELABORACIÓN DE VINO, SIDRA, JUGOS DE FRUTAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1312,'C282505','FABRICACIÓN DE MAQUINARIA PARA USO EN PANADERÍA Y PARA HACER MACARRONES, ESPAGUETIS O PRODUCTOS SIMILARES: HORNOS DE PANADERÍA, AMASADORAS, FRACCIONADORAS Y MOLDEADORAS DE MASA, CORTADORAS, MÁQUINAS PARA DEPOSITAR TARTAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1313,'C282506','FABRICACIÓN DE MAQUINARIA PARA LA EXTRACCIÓN O PREPARACIÓN DE GRASAS Y ACEITES ANIMALES O VEGETALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1314,'C282507','FABRICACIÓN DE MAQUINARIA PARA LA PREPARACIÓN DEL TABACO Y LA ELABORACIÓN DE CIGARRILLOS Y CIGARROS, TABACO PARA PIPA, TABACO DE MASCAR Y RAPÉ.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1315,'C282508','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1316,'C282509','FABRICACIÓN DE OTRA MAQUINARIA Y EQUIPO PARA LA ELABORACIÓN DE DIVERSOS ALIMENTOS: MAQUINARIA PARA LA ELABORACIÓN DE CACAO, CHOCOLATE Y PRODUCTOS DE CONFITERÍA; LA FABRICACIÓN DE AZÚCAR; PARA FÁBRICAS DE CERVEZA; LA ELABORACIÓN DE CARNE DE BOVINO Y DE AVES DE CORRAL; LA PREPARACIÓN DE FRUTAS, NUECES Y HORTALIZAS Y LEGUMBRES; LA PREPARACIÓN DE PESCADO, CRUSTÁCEOS Y MOLUSCOS Y OTROS PRODUCTOS MARINOS COMESTIBLES, MAQUINARIA PARA FILTRAR Y DEPURAR, OTROS TIPOS DE MAQUINARIA PARA LA PREPARACIÓN Y LA ELABORACIÓN INDUSTRIAL DE ALIMENTOS Y BEBIDAS, MAQUINARIA PARA LA PREPARACIÓN DE ALIMENTOS EN HOTELES Y RESTAURANTES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1317,'C2826','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CUEROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1318,'C28261','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1319,'C282611','FABRICACIÓN DE MAQUINARIA TEXTIL: MÁQUINAS PARA PREPARAR, PRODUCIR, EXTRUIR, ESTIRAR, TEXTURIZAR O CORTAR FIBRAS Y MATERIALES TEXTILES E HILADOS ARTIFICIALES; MÁQUINAS PARA PREPARAR FIBRAS TEXTILES: DESMOTADORAS DE ALGODÓN, ABRIDORAS DE BALAS, TRANSFORMADORAS DE HILACHAS EN FIBRA, BATANES DE ALGODÓN, DESENGRASADORAS Y CARBONIZADORAS DE LANA, PEINADORAS, CARDADORAS, MECHERAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1320,'C282612','MÁQUINAS PARA TRANSFORMAR LAS MECHAS EN HILOS, PREPARAR HILADOS TEXTILES: DEVANADORAS, URDIDORAS Y MÁQUINAS SIMILARES TELARES CORRIENTES, INCLUIDOS TELARES MANUALES TELARES PARA TEJIDOS DE PUNTO, MÁQUINAS PARA HACER TEJIDOS DE MALLAS ANUDADAS, TULES, ENCAJES, TRENCILLAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1321,'C282613','FABRICACIÓN DE MÁQUINAS Y EQUIPO AUXILIAR PARA LA MAQUINARIA TEXTIL: LIZOS, MECANISMOS DE JACQUARD, MECANISMOS DE PARADA AUTOMÁTICOS, MECANISMOS DE CAMBIO DE LANZADERA, HUSOS Y ALETAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1322,'C282614','FABRICACIÓN DE MAQUINARIA PARA EL TRATAMIENTO DE TEJIDOS: MAQUINARIA PARA LAVAR, BLANQUEAR, TEÑIR, APRESTAR, ACABAR, REVESTIR E IMPREGNAR TELAS, MÁQUINAS PARA ENROLLAR, DESENROLLAR, PLEGAR, CORTAR Y CALAR TELAS; MAQUINARIA PARA EL ESTAMPADO DE TEXTILES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1323,'C282615','FABRICACIÓN DE MAQUINARIA DE LAVANDERÍA: MÁQUINAS DE PLANCHAR, INCLUIDAS PLANCHAS DE FUSIÓN, LAVADORAS Y SECADORAS COMERCIALES, MÁQUINAS DE LIMPIEZA EN SECO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1324,'C282616','FABRICACIÓN DE MÁQUINAS DE COSER, DE CABEZALES Y AGUJAS PARA MÁQUINAS DE COSER (SEAN O NO DE USO DOMÉSTICO), MAQUINAS PARA LA MANUFACTURA Y EL ACABADO DE FIELTROS Y DE TEXTILES NO TEJIDOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1325,'C28262','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS DE CUERO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1326,'C282621','FABRICACIÓN DE MÁQUINAS PARA CUEROS: MAQUINARIA PARA PREPARAR, CURTIR Y TRABAJAR CUEROS Y PIELES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1327,'C282622','FABRICACIÓN DE MAQUINARIA PARA FABRICAR Y REPARAR CALZADO Y OTROS ARTÍCULOS DE CUERO O PIEL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1328,'C28263','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CUEROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1329,'C282630','SERVICIOS DE APOYO A LA FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CUEROS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1330,'C2829','FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO ESPECIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1331,'C28291','FABRICACIÓN DE MAQUINARIA PARA LA INDUSTRIA DEL PAPEL, CARTÓN, PLÁSTICO Y CAUCHO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1332,'C282911','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE PASTA DE MADERA, FABRICACIÓN DE PAPEL Y CARTÓN, SECADORAS PARA MADERA, PASTA DE MADERA, PAPEL O CARTÓN Y FABRICACIÓN DE ARTÍCULOS DE PAPEL O CARTÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1333,'C282912','FABRICACIÓN DE MAQUINARIA PARA TRABAJAR EL CAUCHO Y LOS PLÁSTICOS BLANDOS Y PARA FABRICAR PRODUCTOS DE ESOS MATERIALES: MÁQUINAS PARA EXTRUIR, MOLDEAR, FABRICAR Y RECAUCHUTAR CUBIERTAS NEUMÁTICAS Y OTRAS MÁQUINAS PARA FABRICAR DETERMINADOS PRODUCTOS DE CAUCHO O PLÁSTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1334,'C28292','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO ESPECIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1335,'C282920','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE MAQUINARIA DE USO ESPECIAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1336,'C28299','FABRICACIÓN DE OTRA MAQUINARIA DE USO ESPECIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1337,'C282991','FABRICACIÓN DE MAQUINARIA PARA IMPRIMIR Y ENCUADERNAR Y DE MÁQUINAS AUXILIARES PARA LA IMPRESIÓN SOBRE DIVERSOS MATERIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1338,'C282992','FABRICACIÓN DE MAQUINARIA PARA PRODUCIR BALDOSAS, LADRILLOS, PASTAS DE CERÁMICA MOLDEADAS, TUBOS, ELECTRODOS DE GRAFITO, TIZA DE PIZARRÓN, MOLDES DE FUNDICIÓN, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1339,'C282993','FABRICACIÓN DE MAQUINARIA PARA LA ELABORACIÓN DE SEMICONDUCTORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1340,'C282994','FABRICACIÓN DE MÁQUINAS PARA MONTAR LÁMPARAS, TUBOS (VÁLVULAS) Y BOMBILLAS ELÉCTRICAS Y ELECTRÓNICAS MÁQUINAS PARA LA PRODUCCIÓN Y EL TRABAJO EN CALIENTE DE VIDRIO Y PRODUCTOS DE CRISTALERÍA, FIBRAS E HILADOS DE VIDRIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1341,'C282995','FABRICACIÓN DE MÁQUINAS DE FUNCIONES ESPECIALES, SISTEMAS CENTRALES DE ENGRASADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1342,'C282996','FABRICACIÓN DE TIOVIVOS, COLUMPIOS, GALERÍAS DE TIRO Y ATRACCIONES DE FERIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1343,'C282999','FABRICACIÓN DE OTRO TIPO DE MAQUINARIA Y EQUIPO DE USO ESPECIAL: MAQUINARIA O APARATOS PARA LA SEPARACIÓN DE ISÓTOPOS, ROBOTS INDUSTRIALES DE USO ESPECIAL PARA LA REALIZACIÓN DE MÚLTIPLES TAREAS, SECADORES DE OTROS MATERIALES, MAQUINAS PARA FABRICAR CUERDAS, EQUIPO DE ALINEACIÓN Y EQUILIBRADO (BALANCEO) DE NEUMÁTICOS; EQUIPO DE EQUILIBRADO (EXCEPTO EL DE EQUILIBRADO DE RUEDAS), EQUIPO AUTOMÁTICO PARA BOLERAS, ARTEFACTOS DE LANZAMIENTO PARA AERONAVES, CATAPULTAS PARA PORTAAVIONES Y EQUIPO CONEXO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1344,'C29','FABRICACIÓN DE VEHÍCULOS AUTOMOTORES, REMOLQUES Y SEMIRREMOLQUES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1345,'C291','FABRICACIÓN DE VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1346,'C2910','FABRICACIÓN DE VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1347,'C29100','FABRICACIÓN DE VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1348,'C291001','FABRICACIÓN DE AUTOMÓVILES DE PASAJEROS, VEHÍCULOS PARA TODO TERRENO, AUTOBUSES, TROLEBUSES, GO-CARTS Y VEHÍCULOS SIMILARES, INCLUIDOS VEHÍCULOS DE CARRERAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1349,'C291002','FABRICACIÓN DE VEHÍCULOS PARA EL TRANSPORTE DE MERCANCÍAS: CAMIONETAS, CAMIONES, TRACTORES PARA SEMIRREMOLQUES DE CIRCULACIÓN POR CARRETERA, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1350,'C291003','FABRICACIÓN DE MOTORES PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1351,'C291004','FABRICACIÓN DE CHASIS EQUIPADOS CON MOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1352,'C291005','FABRICACIÓN DE OTROS VEHÍCULOS AUTOMOTORES: TRINEOS MOTORIZADOS, CARRITOS AUTOPROPULSADOS PARA CAMPOS DE GOLF, VEHÍCULOS ANFIBIOS, CAMIONES DE BOMBEROS, CAMIONES BARREDORES, BIBLIOTECAS MÓVILES, VEHÍCULOS BLINDADOS, CAMIONES HORMIGONERA, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1353,'C291006','SERVICIOS DE APOYO A LA FABRICACIÓN DE VEHÍCULOS AUTOMOTORES, RECONSTRUCCIÓN, RECTIFICACIÓN EN FÁBRICA DE SUS MOTORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1354,'C292','FABRICACIÓN DE CARROCERÍAS PARA VEHÍCULOS AUTOMOTORES; FABRICACIÓN DE REMOLQUES Y SEMIRREMOLQUES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1355,'C2920','FABRICACIÓN DE CARROCERÍAS PARA VEHÍCULOS AUTOMOTORES; FABRICACIÓN DE REMOLQUES Y SEMIRREMOLQUES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1356,'C29200','FABRICACIÓN DE CARROCERÍAS PARA VEHÍCULOS AUTOMOTORES; FABRICACIÓN DE REMOLQUES Y SEMIRREMOLQUES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1357,'C292001','FABRICACIÓN DE CARROCERÍAS, INCLUIDAS CABINAS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1358,'C292002','FABRICACIÓN DE REMOLQUES Y SEMIRREMOLQUES: PARA EL TRANSPORTE DE MERCANCÍAS: CAMIONES CISTERNA, DE MUDANZAS, ETCÉTERA, PARA EL TRANSPORTE DE PASAJEROS: CARAVANAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1359,'C292003','FABRICACIÓN DE CONTENEDORES PARA SU ACARREO POR UNO O MÁS MEDIOS DE TRANSPORTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1360,'C292004','SERVICIOS DE APOYO A LA FABRICACIÓN, ENSAMBLAJE Y EQUIPAMIENTO DE CARROCERÍAS PARA VEHÍCULOS AUTOMOTORES, REMOLQUES Y SEMIRREMOLQUES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1361,'C293','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1362,'C2930','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1363,'C29300','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1364,'C293001','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS DE CARROCERÍAS PARA VEHÍCULOS AUTOMOTORES: CINTURONES DE SEGURIDAD, DISPOSITIVOS INFLABLES DE SEGURIDAD (AIRBAG), PUERTAS, PARACHOQUES, ASIENTOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1365,'C293002','FABRICACIÓN DE EQUIPO ELÉCTRICO PARA VEHÍCULOS AUTOMOTORES, COMO GENERADORES, ALTERNADORES, BUJÍAS, CABLEADOS PREFORMADOS PARA EL SISTEMA DE ENCENDIDO, SISTEMAS ELÉCTRICOS DE APERTURA Y CIERRE DE VENTANILLAS Y PUERTAS, MONTAJE DE TABLEROS DE INSTRUMENTOS, REGULADORES DE TENSIÓN, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1366,'C293003','SERVICIOS DE APOYO A LA FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1367,'C293009','FABRICACIÓN DE OTRAS PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES: FRENOS, CAJAS DE CAMBIOS, EJES, AROS DE RUEDAS, AMORTIGUADORES, RADIADORES, SILENCIADORES, TUBOS DE ESCAPE, CATALIZADORES, EMBRAGUES, VOLANTES, COLUMNAS Y CAJAS DE DIRECCIÓN, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1368,'C30','FABRICACIÓN DE OTROS TIPOS DE EQUIPOS DE TRANSPORTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1369,'C301','CONSTRUCCIÓN DE BUQUES Y OTRAS EMBARCACIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1370,'C3011','CONSTRUCCIÓN DE BUQUES Y ESTRUCTURAS FLOTANTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1371,'C30110','CONSTRUCCIÓN DE BUQUES Y ESTRUCTURAS FLOTANTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1372,'C301101','CONSTRUCCIÓN DE BUQUES COMERCIALES: BUQUES DE PASAJEROS, TRANSBORDADORES, BUQUES MERCANTES, PETROLEROS, REMOLCADORES, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1373,'C301102','CONSTRUCCIÓN DE BUQUES DE GUERRA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1374,'C301103','CONSTRUCCIÓN DE PESQUEROS Y BUQUES-FACTORÍA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1375,'C301104','CONSTRUCCIÓN DE ESTRUCTURAS FLOTANTES: PANTALANES FLOTANTES, PONTONES, DIQUES FLOTANTES, EMBARCADEROS FLOTANTES, BOYAS, DEPÓSITOS FLOTANTES, BARCAZAS, GABARRAS, GRÚAS FLOTANTES, BALSAS INFLABLES DISTINTAS DE LAS DE RECREO, ETCÉTERA, CONSTRUCCIÓN DE PLATAFORMAS DE PERFORACIÓN FLOTANTES O SUMERGIBLES, AERODESLIZADORES (EXCEPTO LOS DE RECREO), SECCIONES PARA BUQUES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1376,'C301105','SERVICIOS DE APOYO A LA CONSTRUCCIÓN DE BUQUES Y ESTRUCTURAS FLOTANTES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1377,'C3012','CONSTRUCCIÓN DE EMBARCACIONES DE RECREO Y DEPORTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1378,'C30120','CONSTRUCCIÓN DE EMBARCACIONES DE RECREO Y DEPORTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1379,'C301201','FABRICACIÓN DE BOTES Y BALSAS INFLABLES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1380,'C301202','CONSTRUCCIÓN DE VELEROS, PROVISTOS O NO DE MOTOR AUXILIAR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1381,'C301203','SERVICIOS DE APOYO A LA CONSTRUCCIÓN DE EMBARCACIONES DE RECREO Y DEPORTE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1382,'C301209','FABRICACIÓN DE OTRAS EMBARCACIONES DE RECREO Y DEPORTE: EMBARCACIONES PERSONALES, CANOAS, KAYAKS, BOTES DE REMO, ESQUIFES AERODESLIZADORES DE RECREO, MOTOS ACUÁTICAS, EMBARCACIONES DE MOTOR, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1383,'C302','FABRICACIÓN DE LOCOMOTORAS Y MATERIAL RODANTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1384,'C3020','FABRICACIÓN DE LOCOMOTORAS Y MATERIAL RODANTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1385,'C30200','FABRICACIÓN DE LOCOMOTORAS Y MATERIAL RODANTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1386,'C302001','FABRICACIÓN DE LOCOMOTORAS ELÉCTRICAS, DIESEL, DE VAPOR Y DE OTROS TIPOS, INCLUIDO VAGONES PARA FERROCARRILES MINEROS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1387,'C302002','FABRICACIÓN DE VAGONES DE PASAJEROS, FURGONES Y VAGONES DE PLATAFORMA AUTOPROPULSADOS DE TRANVÍA Y DE FERROCARRIL, VEHÍCULOS AUTOPROPULSADOS DE MANTENIMIENTO Y DE SERVICIO PARA TRANVÍAS Y FERROCARRILES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1388,'C302003','FABRICACIÓN DE MATERIAL RODANTE NO AUTOPROPULSADO PARA TRANVÍAS Y FERROCARRILES: VAGONES DE PASAJEROS, FURGONES DE CARGA, VAGONES CISTERNA, FURGONES Y VAGONES DE VOLTEO, FURGONES TALLER, VAGONES GRÚA, TÉNDERES, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1389,'C302004','FABRICACIÓN DE PARTES Y PIEZAS ESPECIALES DE LOCOMOTORAS Y TRANVÍAS Y DE SU MATERIAL RODANTE: BOGIES, EJES Y RUEDAS, FRENOS Y PIEZAS DE FRENOS, GANCHOS Y MECANISMOS DE ENGANCHE, TOPES Y PIEZAS DE TOPES, AMORTIGUADORES, BASTIDORES DE VAGONES Y LOCOMOTORAS, CARROCERÍAS, PLATAFORMAS DE INTERCOMUNICACIÓN, ETCÉTERA, INCLUIDO ASIENTOS PARA VAGONES DE FERROCARRIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1390,'C302005','FABRICACIÓN DE EQUIPO MECÁNICO Y ELECTROMECÁNICO DE SEÑALIZACIÓN, SEGURIDAD Y CONTROL DE TRÁFICO PARA FERROCARRILES, TRANVÍAS, CARRETERAS, VÍAS DE NAVEGACIÓN INTERIORES, APARCAMIENTOS, AEROPUERTOS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1391,'C302006','SERVICIOS DE APOYO A LA FABRICACIÓN DE LOCOMOTORAS Y MATERIAL RODANTE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1392,'C303','FABRICACIÓN DE AERONAVES Y NAVES ESPACIALES Y MAQUINARIA CONEXA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1393,'C3030','FABRICACIÓN DE AERONAVES Y NAVES ESPECIALES Y MAQUINARIA CONEXA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1394,'C30300','FABRICACIÓN DE AERONAVES Y NAVES ESPACIALES SUS MOTORES, PARTES Y ACCESORIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1395,'C303001','FABRICACIÓN DE AERONAVES PARA EL TRANSPORTE DE MERCANCÍAS O DE PASAJEROS, PARA DEFENSA MILITAR, DEPORTE U OTROS FINES: AVIONES, HELICÓPTEROS; FABRICACIÓN APARATOS DE ENTRENAMIENTO DE VUELO EN TIERRA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1396,'C303002','FABRICACIÓN DE PLANEADORES, ALAS DELTA, DIRIGIBLES Y GLOBOS DE AIRE CALIENTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1397,'C303003','FABRICACIÓN DE NAVES ESPACIALES Y VEHÍCULOS DE LANZAMIENTO DE NAVES ESPACIALES, SATÉLITES, SONDAS PLANETARIAS, ESTACIONES ORBITALES Y TRANSBORDADORES ESPACIALES INCLUIDO MISILES BALÍSTICOS INTERCONTINENTALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1398,'C303004','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS PARA AERONAVES DE ESTA CLASE: ENSAMBLADURAS PRINCIPALES, COMO FUSELAJES, ALAS, PUERTAS, ASIENTOS PARA AERONAVES, PANELES DE MANDO, TRENES DE ATERRIZAJE, DEPÓSITOS DE COMBUSTIBLE, GÓNDOLAS, ETCÉTERA, HÉLICES, ROTORES DE HELICÓPTERO Y PALAS DE HÉLICE PROPULSADAS, MOTORES DEL TIPO UTILIZADO GENERALMENTE EN AERONAVES, PARTES DE TURBOPROPULSORES DE REACCIÓN Y DE HÉLICE PARA AERONAVES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1399,'C303005','SERVICIOS DE APOYO A LA FABRICACIÓN DE AERONAVES Y NAVES ESPECIALES Y MAQUINARIA CONEXA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1400,'C304','FABRICACIÓN DE VEHÍCULOS MILITARES DE COMBATE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1401,'C3040','FABRICACIÓN DE VEHÍCULOS MILITARES DE COMBATE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1402,'C30400','FABRICACIÓN DE VEHÍCULOS MILITARES DE COMBATE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1403,'C304001','FABRICACIÓN DE VEHÍCULOS MILITARES DE COMBATE: TANQUES DE COMBATE, VEHÍCULOS ANFIBIOS BLINDADOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1404,'C304002','SERVICIOS DE APOYO A LA FABRICACIÓN DE VEHÍCULOS MILITARES DE COMBATE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1405,'C309','FABRICACIÓN DE EQUIPO DE TRANSPORTE N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1406,'C3091','FABRICACIÓN DE MOTOCICLETAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1407,'C30910','FABRICACIÓN DE MOTOCICLETAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1408,'C309101','FABRICACIÓN DE MOTOCICLETAS, VELOMOTORES Y BICICLETAS CON MOTOR AUXILIAR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1409,'C309102','FABRICACIÓN DE MOTORES PARA MOTOCICLETAS, PIEZAS, PARTES Y ACCESORIOS DE MOTOCICLETAS INCLUIDO SIDECARS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1410,'C309103','SERVICIOS DE APOYO A LA FABRICACIÓN DE MOTOCICLETAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1411,'C3092','FABRICACIÓN DE BICICLETAS Y DE SILLAS DE RUEDAS PARA INVÁLIDOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1412,'C30920','FABRICACIÓN DE BICICLETAS Y DE SILLAS DE RUEDAS PARA INVÁLIDOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1413,'C309201','FABRICACIÓN DE BICICLETAS NO MOTORIZADAS Y OTROS VEHÍCULOS SIMILARES, COMO TRICICLOS DE REPARTO O PARA OTROS USOS, TÁNDEMS, BICICLETAS Y TRICICLOS PARA NIÑOS, FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS DE BICICLETAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1414,'C309202','FABRICACIÓN DE SILLAS DE RUEDAS PARA INVÁLIDOS, MOTORIZADOS O NO, FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS DE SILLAS DE RUEDAS PARA INVÁLIDOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1415,'C309203','FABRICACIÓN DE COCHECITOS PARA BEBÉS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1416,'C309204','SERVICIOS DE APOYO A LA FABRICACIÓN DE BICICLETAS Y DE SILLAS DE RUEDAS PARA INVÁLIDOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1417,'C3099','FABRICACIÓN DE OTROS TIPOS DE EQUIPO DE TRANSPORTE N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1418,'C30990','FABRICACIÓN DE OTROS TIPOS DE EQUIPO DE TRANSPORTE N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1419,'C309901','FABRICACIÓN DE VEHÍCULOS DE PROPULSIÓN MANUAL: CARRITOS PARA EQUIPAJE, CARRETILLAS, TRINEOS, CARRITOS PARA SUPERMERCADOS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1420,'C309902','FABRICACIÓN DE VEHÍCULOS DE TRACCIÓN ANIMAL: CALESAS, CALESINES, CARROZAS FÚNEBRES, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1421,'C309903','SERVICIOS DE APOYO A LA FABRICACIÓN DE OTROS TIPOS DE EQUIPO DE TRANSPORTE N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1422,'C31','FABRICACIÓN DE MUEBLES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1423,'C310','FABRICACIÓN DE MUEBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1424,'C3100','FABRICACIÓN DE MUEBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1425,'C31000','FABRICACIÓN DE MUEBLES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1426,'C310001','FABRICACIÓN DE MUEBLES DE MADERA Y SUS PARTES: PARA EL HOGAR, OFICINAS, TALLERES, HOTELES, RESTAURANTES, IGLESIAS, ESCUELAS, MUEBLES ESPECIALES PARA LOCALES COMERCIALES, MUEBLES PARA MÁQUINAS DE COSER, TELEVISIONES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1427,'C310002','FABRICACIÓN DE MUEBLES DE METAL Y SUS PARTES: PARA EL HOGAR, OFICINA, TALLERES, HOTELES, RESTAURANTES, IGLESIAS, ESCUELAS, MUEBLES ESPECIALES PARA LOCALES COMERCIALES Y OTROS USOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1428,'C310003','FABRICACIÓN DE MUEBLES DE MATERIALES PLÁSTICOS Y SUS PARTES PARA CUALQUIER USO (EXCEPTO MUEBLES PARA USO MÉDICO O AFINES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1429,'C310004','FABRICACIÓN DE MUEBLES DE OTROS MATERIALES Y SUS PARTES (EXCEPTO DE CERÁMICA, HORMIGÓN O PIEDRA) PARA CUALQUIER USO COMO: SILLAS Y ASIENTOS DE JARDÍN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1430,'C310005','FABRICACIÓN DE COLCHONES: COLCHONES DE MUELLES Y RELLENOS O PROVISTOS DE ALGÚN MATERIAL DE SUSTENTACIÓN, COLCHONES DE CAUCHO CELULAR Y DE PLÁSTICO SIN FORRO, FABRICACIÓN DE BASES DE COLCHÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1431,'C310006','SERVICIOS DE APOYO A LA FABRICACIÓN Y ACABADO (TAPIZADO DE SILLAS Y SILLONES, LACADO, PINTADO, BARNIZADO CON MUÑEQUILLA, ETCÉTERA) DE MUEBLES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1432,'C32','OTRAS INDUSTRIAS MANUFACTURERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1433,'C321','FABRICACIÓN DE JOYAS, BISUTERÍA Y ARTÍCULOS CONEXOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1434,'C3211','FABRICACIÓN DE JOYAS Y ARTÍCULOS CONEXOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1435,'C32110','FABRICACIÓN DE JOYAS Y ARTÍCULOS CONEXOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1436,'C321101','PRODUCCIÓN DE PERLAS LABRADAS, PIEDRAS PRECIOSAS Y SEMIPRECIOSAS LABRADAS, INCLUIDA LA PRODUCCIÓN DE PIEDRAS DE CALIDAD INDUSTRIAL Y DE PIEDRAS PRECIOSAS Y SEMIPRECIOSAS SINTÉTICAS Y RECONSTRUIDAS, TALLA DE DIAMANTES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1437,'C321102','FABRICACIÓN DE JOYAS DE METALES PRECIOSOS O DE METALES COMUNES CHAPADOS CON METALES PRECIOSOS, DE PIEDRAS PRECIOSAS Y SEMIPRECIOSAS; Y DE COMBINACIONES DE METALES PRECIOSOS Y PIEDRAS PRECIOSAS Y SEMIPRECIOSAS Y OTROS MATERIALES, INCLUIDO LA FABRICACIÓN DE CORREAS Y CINTAS PARA RELOJES, PULSERAS Y PITILLERAS DE METALES PRECIOSOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1438,'C321103','FABRICACIÓN DE ARTÍCULOS DE ORFEBRERÍA ELABORADOS CON METALES PRECIOSOS O METALES COMUNES CHAPADOS CON METALES PRECIOSOS: CUBERTERÍAS, VAJILLAS Y SERVICIOS DE MESA, ARTÍCULOS DE TOCADOR, ARTÍCULOS DE ESCRITORIO Y OFICINA, ARTÍCULOS DE USO RELIGIOSO, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1439,'C321104','FABRICACIÓN DE ARTÍCULOS DE USO TÉCNICO Y DE LABORATORIO ELABORADOS CON METALES PRECIOSOS (EXCEPTO INSTRUMENTOS Y PIEZAS DE INSTRUMENTOS): CRISOLES, ESPÁTULAS, ÁNODOS DE GALVANOPLASTIA, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1440,'C321105','FABRICACIÓN DE MONEDAS, INCLUIDAS MONEDAS DE CURSO LEGAL, SEAN O NO DE METALES PRECIOSOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1441,'C321106','SERVICIOS DE APOYO A LA FABRICACIÓN DE JOYAS Y ARTÍCULOS CONEXOS COMO: EL GRABADO DE OBJETOS PERSONALES DE METALES PRECIOSOS Y DE METALES NO PRECIOSOS, A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1442,'C3212','FABRICACIÓN DE BISUTERÍA Y ARTÍCULOS CONEXOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1443,'C32120','FABRICACIÓN DE BISUTERÍA Y ARTÍCULOS CONEXOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1444,'C321201','FABRICACIÓN DE ARTÍCULOS DE BISUTERÍA: ANILLOS, BRAZALETES, COLLARES Y ARTÍCULOS DE BISUTERÍAS SIMILARES DE METALES COMUNES CHAPADOS CON METALES PRECIOSOS, JOYAS QUE CONTIENEN PIEDRAS DE IMITACIÓN, COMO DIAMANTES U OTRAS GEMAS DE IMITACIÓN Y SIMILARES, INCLUIDO LA FABRICACIÓN DE CORREAS DE METAL PARA RELOJES (EXCEPTO LAS DE METALES PRECIOSOS).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1445,'C321202','SERVICIOS DE APOYO A LA FABRICACIÓN DE BISUTERÍA Y ARTÍCULOS CONEXOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1446,'C322','FABRICACIÓN DE INSTRUMENTOS MUSICALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1447,'C3220','FABRICACIÓN DE INSTRUMENTOS MUSICALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1448,'C32200','FABRICACIÓN DE INSTRUMENTOS MUSICALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1449,'C322001','FABRICACIÓN DE INSTRUMENTOS DE CUERDA, INSTRUMENTOS DE CUERDA CON TECLADO, INCLUIDOS PIANOS AUTOMÁTICOS, GUITARRAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1450,'C322002','FABRICACIÓN DE ÓRGANOS DE TUBO Y TECLADO, INCLUIDOS ARMONIOS E INSTRUMENTOS DE TECLADO SIMILARES CON LENGÜETAS METÁLICAS LIBRES, CAJAS DE MÚSICA, ORGANILLOS, ÓRGANOS DE VAPOR, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1451,'C322003','FABRICACIÓN DE INSTRUMENTOS DE VIENTO: SILBATOS, CUERNOS DE LLAMADA Y OTROS INSTRUMENTOS SONOROS DE BOCA PARA LLAMADA, ACORDEONES E INSTRUMENTOS SIMILARES, INCLUIDAS ARMÓNICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1452,'C322004','FABRICACIÓN DE INSTRUMENTOS DE PERCUSIÓN: TAMBORES, XILÓFONOS, CASTAÑUELAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1453,'C322005','FABRICACIÓN DE PARTES, PIEZAS Y ACCESORIOS DE INSTRUMENTOS: METRÓNOMOS, DIAPASONES DE PERCUSIÓN Y DE BOCA, TARJETAS, DISCOS Y ROLLOS PARA INSTRUMENTOS MECÁNICOS AUTOMÁTICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1454,'C322006','SERVICIOS DE APOYO A LA FABRICACIÓN DE INSTRUMENTOS MUSICALES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1455,'C322009','FABRICACIÓN DE OTROS INSTRUMENTOS MUSICALES, INSTRUMENTOS MUSICALES CUYO SONIDO SE PRODUCE ELECTRÓNICAMENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1456,'C323','FABRICACIÓN DE ARTÍCULOS DE DEPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1457,'C3230','FABRICACIÓN DE ARTÍCULOS DE DEPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1458,'C32300','FABRICACIÓN DE ARTÍCULOS DE DEPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1459,'C323001','FABRICACIÓN DE ARTÍCULOS Y EQUIPO DE CUALQUIER MATERIAL PARA LA PRÁCTICA DE DEPORTES Y JUEGOS AL AIRE LIBRE Y BAJO TECHO: BALONES DUROS, BLANDOS E INFLABLES, RAQUETAS, BATES Y MAZOS, ESQUÍES, FIJACIONES Y BASTONES DE ESQUÍ, BOTAS DE ESQUÍ, TABLAS DE VELA Y DE SURF, PATINES DE HIELO, PATINES DE RUEDAS, ETCÉTERA, EQUIPO PARA GIMNASIO Y DE ATLETISMO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1460,'C323002','FABRICACIÓN DE ARTÍCULOS PARA LA PESCA DEPORTIVA, CAZA, ALPINISMO: REDES DE MANO, ARCOS Y BALLESTAS, GUANTES Y TOCADOS DE CUERO PARA LA PRÁCTICA DE DEPORTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1461,'C323003','SERVICIOS DE APOYO A LA FABRICACIÓN DE ARTÍCULOS DE DEPORTE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1462,'C324','FABRICACIÓN DE JUEGOS Y JUGUETES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1463,'C3240','FABRICACIÓN DE JUEGOS Y JUGUETES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1464,'C32400','FABRICACIÓN DE JUEGOS Y JUGUETES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1465,'C324001','FABRICACIÓN DE MUÑECOS QUE REPRESENTAN PERSONAJES, ANIMALES DE JUGUETE, MUÑECAS, PIEZAS Y ACCESORIOS(VESTIDOS) PARA MUÑECAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1466,'C324002','FABRICACIÓN DE INSTRUMENTOS MUSICALES DE JUGUETE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1467,'C324003','FABRICACIÓN DE ARTÍCULOS PARA FERIAS DE ATRACCIONES, JUEGOS DE MESA O JUEGOS DE SALÓN, JUEGOS ACCIONADOS CON MONEDAS, BILLARES, MESAS ESPECIALES PARA JUEGOS DE CASINO, JUEGOS ELECTRÓNICOS, AJEDREZ, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1468,'C324004','FABRICACIÓN DE JUGUETES CON RUEDAS UTILIZABLES COMO VEHÍCULOS, MONOPATINES, INCLUIDOS BICICLETAS Y TRICICLOS DE PLÁSTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1469,'C324005','SERVICIOS DE APOYO A LA FABRICACIÓN DE JUEGOS Y JUGUETES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1470,'C324009','FABRICACIÓN DE OTROS JUEGOS Y JUGUETES: ARMAS DE JUGUETES, JUGUETES PARA MASCOTAS, MODELOS A ESCALA REDUCIDA Y MODELOS RECREATIVOS SIMILARES, TRENES ELÉCTRICOS, JUEGOS DE CONSTRUCCIONES, JUEGOS DE TABLERO, ROMPECABEZAS Y ARTÍCULOS SIMILARES, NAIPES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1471,'C325','FABRICACIÓN DE INSTRUMENTOS Y MATERIALES MÉDICOS Y ODONTOLÓGICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1472,'C3250','FABRICACIÓN DE INSTRUMENTOS Y MATERIALES MÉDICOS Y ODONTOLÓGICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1473,'C32501','FABRICACIÓN DE INSTRUMENTOS MÉDICOS Y ODONTOLÓGICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1474,'C325011','FABRICACIÓN DE HORNOS PARA LABORATORIOS DENTALES, APARATOS DE DESTILACIÓN Y CENTRIFUGADORAS PARA LABORATORIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1475,'C325012','FABRICACIÓN DE MAQUINARIA DE LIMPIEZA POR ULTRASONIDOS  Y ESTERILIZADORES PARA LABORATORIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1476,'C325013','FABRICACIÓN DE MUEBLES, INSTRUMENTOS, Y APARATOS PARA MEDICINA, CIRUGÍA, ODONTOLOGÍA Y VETERINARIA, COMO: MESAS DE OPERACIONES, CAMILLAS DE RECONOCIMIENTO MÉDICO, CAMAS DE HOSPITAL CON DISPOSITIVOS MECÁNICOS, BISTURÍS, ALICATES DE CIRUGÍA, PINZAS DE CIRUGÍA, INSTRUMENTOS DE ODONTOLOGÍA (INCLUIDOS SILLONES DE DENTISTA CON EQUIPO ODONTOLÓGICO), TERMÓMETROS DE USO MÉDICO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1477,'C325014','FABRICACIÓN DE APARATOS ORTOPÉDICOS Y PROSTÉTICOS, OJOS DE CRISTAL, DIENTES POSTIZOS, PUENTES, ETCÉTERA, EN LABORATORIOS MÉDICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1478,'C325015','FABRICACIÓN DE APARATOS DE MECANOTERAPIA, MÁQUINAS DE MASAJE; APARATOS PARA PRUEBAS PSICOLÓGICAS, APARATOS DE OZONOTERAPIA, OXIGENOTERAPIA Y RESPIRACIÓN ARTIFICIAL, APARATOS RESPIRATORIOS TERAPÉUTICOS Y OTROS APARATOS DE RESPIRACIÓN Y MÁSCARAS DE GAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1479,'C32502','FABRICACIÓN DE MATERIALES MÉDICOS Y ODONTOLÓGICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1480,'C325021','FABRICACIÓN DE SABANILLAS, HILOS Y GASAS ESTÉRILES DE USO QUIRÚRGICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1481,'C325022','FABRICACIÓN DE EMPASTES Y CEMENTOS DENTALES (EXCEPTO ADHESIVOS PARA DENTADURAS), CERAS DENTALES Y OTRAS PREPARACIONES DE USO ODONTOLÓGICO; FABRICACIÓN DE CEMENTOS PARA LA RECONSTRUCCIÓN DE HUESO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1482,'C325023','FABRICACIÓN DE PLACAS Y TORNILLOS PARA FIJACIÓN DE HUESOS, JERINGUILLAS, AGUJAS, CATÉTERES, CÁNULAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1483,'C325024','FABRICACIÓN DE PRODUCTOS OFTÁLMICOS, GAFAS, GAFAS DE SOL, LENTES DE GRADUACIÓN, LENTES DE CONTACTO, ANTEOJOS DE PROTECCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1484,'C32503','SERVICIOS DE APOYO A LA FABRICACIÓN DE INSTRUMENTOS Y MATERIALES MÉDICOS Y ODONTOLÓGICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1485,'C325030','SERVICIOS DE APOYO A LA FABRICACIÓN DE INSTRUMENTOS Y MATERIALES MÉDICOS Y ODONTOLÓGICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1486,'C329','OTRAS INDUSTRIAS MANUFACTURERAS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1487,'C3290','OTRAS INDUSTRIAS MANUFACTURERAS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1488,'C32901','FABRICACIÓN DE ÚTILES DE OFICINA Y ESCRITORIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1489,'C329011','FABRICACIÓN DE SELLOS PARA FECHAR, CERRAR O NUMERAR, APARATOS MANUALES PARA IMPRIMIR Y ESTAMPAR EN RELIEVE, MEMBRETES, APARATOS DE IMPRESIÓN MANUAL, CINTAS PREPARADAS PARA MÁQUINAS DE ESCRIBIR Y ALMOHADILLAS ENTINTADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1490,'C329012','FABRICACIÓN DE PLUMAS Y LÁPICES DE TODA CLASE, SEAN O NO MECÁNICOS, INCLUIDO MINAS PARA LÁPICES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1491,'C329013','FABRICACIÓN DE GLOBOS TERRÁQUEOS Y OTROS INSTRUMENTOS, APARATOS Y MODELOS DISEÑADOS PARA DEMOSTRACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1492,'C32902','FABRICACIÓN DE ARTÍCULOS DE USO PERSONAL Y BAZAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1493,'C329021','FABRICACIÓN DE BOTONES, BROCHES DE PRESIÓN, CORCHETES DE PRESIÓN, CIERRES DE CREMALLERA (EXCEPTO METÁLICOS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1494,'C329022','FABRICACIÓN DE ENCENDEDORES SEAN O NO MECÁNICOS, ELÉCTRICOS Y DE OTRO TIPO INCLUIDO SUS REPUESTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1495,'C329023','FABRICACIÓN DE PARAGUAS, SOMBRILLAS, BASTONES, BASTONES-ASIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1496,'C329024','FABRICACIÓN DE ARTÍCULOS DE USO PERSONAL: PIPAS, VAPORIZADORES DE PERFUME, PELUCAS, BARBAS Y CEJAS POSTIZAS, PEINES, PASADORES PARA EL CABELLO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1497,'C329025','FABRICACIÓN DE TERMOS Y OTROS RECIPIENTES HERMÉTICOS PARA USO PERSONAL Y DOMÉSTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1498,'C32903','FABRICACIÓN DE OTROS ARTÍCULOS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1499,'C329031','FABRICACIÓN DE EQUIPO DE PROTECCIÓN Y SEGURIDAD: ROPA IGNÍFUGA Y OTRAS PRENDAS DE PROTECCIÓN, CINTURONES DE SEGURIDAD PARA INSTALADORES Y CELADORES DE LÍNEAS TELEFÓNICAS Y DE ELECTRICIDAD Y OTROS CINTURONES DE USO OCUPACIONAL, SALVAVIDAS DE CORCHO, CASCOS DE PLÁSTICO Y OTRO EQUIPO PERSONAL DE SEGURIDAD DE PLÁSTICO (POR EJEMPLO, CASCOS PARA DEPORTES), ROPA DE PROTECCIÓN PARA BOMBEROS, CASCOS DE METAL Y OTRO EQUIPO PERSONAL DE SEGURIDAD DE METAL, TAPONES PARA LOS OÍDOS Y LA NARIZ (POR EJEMPLO, PARA NADAR O PARA PROTEGERSE DEL RUIDO), MÁSCARAS DE GAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1500,'C329032','FABRICACIÓN DE ESCOBAS Y CEPILLOS, INCLUIDOS CEPILLOS QUE FORMAN PARTE DE MÁQUINAS, BARREDORAS, MOPAS Y PLUMEROS MECÁNICOS MANUALES, BROCHAS, ALMOHADILLAS Y RODILLOS PARA PINTAR, ESCOBILLAS DE GOMA Y OTROS CEPILLAS, ESCOBAS, CEPILLOS DE CALZADO Y DE ROPA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1501,'C329033','FABRICACIÓN DE ARTÍCULOS DE MATERIALES ANIMALES: HUESOS, MARFIL, CAREY, PLUMAS, HUESOS, TRIPAS, VEJIGAS, ETCÉTERA, INCLUIDO ACTIVIDADES DE TAXIDERMIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1502,'C329034','FABRICACIÓN DE ATAÚDES Y URNAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1503,'C329035','FABRICACIÓN DE VELAS, CIRIOS Y ARTÍCULOS SIMILARES, MANUFACTURAS MOLDEADAS DE CERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1504,'C329036','FABRICACIÓN DE ARTÍCULOS DE BROMA Y ARTÍCULOS DE FANTASÍA (PIÑATAS).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1505,'C329039','FABRICACIÓN DE OTROS ARTÍCULOS DIVERSOS: PRODUCTOS DE TAGUA, ARTESANÍAS DE OTROS MATERIALES (EXCEPTO PLÁSTICO, PORCELANA, CERÁMICA Y MADERA), CEDAZOS Y CRIBAS MANUALES; RAMILLETES Y CORONAS DE FLORES, CESTAS CON ARREGLOS FLORALES; FLORES, FRUTAS Y PLANTAS ARTIFICIALES; MANIQUÍES DE SASTRE, GELATINAS, MATERIAS VEGETALES O MINERALES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1506,'C32904','SERVICIOS DE APOYO A OTRAS INDUSTRIAS MANUFACTURERAS N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1507,'C329040','SERVICIOS DE APOYO A OTRAS INDUSTRIAS MANUFACTURERAS N.C.P A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1508,'C33','REPARACIÓN E INSTALACIÓN DE MAQUINARIA Y EQUIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1509,'C331','REPARACIÓN DE PRODUCTOS ELABORADOS DE METAL, MAQUINARIA Y EQUIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1510,'C3311','REPARACIÓN DE PRODUCTOS ELABORADOS DE METAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1511,'C33110','REPARACIÓN DE PRODUCTOS ELABORADOS DE METAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1512,'C331101','SERVICIOS DE REPARACIÓN DE: TANQUES, CISTERNAS, DEPÓSITOS, TAMBORES, CONTENEDORES DE METAL Y RECIPIENTES DE METAL, INCLUIDO LA REPARACIÓN DE LA CHAPA DE CALDERAS Y RADIADORES DE CALEFACCIÓN CENTRAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1513,'C331102','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE CAÑOS Y TUBERÍAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1514,'C331103','SERVICIOS DE REPARACIÓN MEDIANTE SERVICIOS MÓVILES DE SOLDADURA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1515,'C331104','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE GENERADORES DE VAPOR DE AGUA Y OTROS VAPORES, INSTALACIONES AUXILIARES PARA GENERADORES DE VAPOR: CONDENSADORES, ECONOMIZADORES, RECALENTADORES, RECOLECTORES Y ACUMULADORES DE VAPOR, REACTORES NUCLEARES (EXCEPTO SEPARADORES DE ISÓTOPOS), PARTES PARA CALDERAS MARINAS O DE POTENCIA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1516,'C331109','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE OTROS PRODUCTOS ELABORADOS DE METAL: CARRITOS DE COMPRAS Y EQUIPO DE MANEJO DE MATERIALES, ARMAS DE FUEGO Y MUNICIONES (INCLUIDA LA REPARACIÓN DE ESCOPETAS DEPORTIVAS Y DE RECREO) A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1517,'C3312','REPARACIÓN DE MAQUINARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1518,'C33121','REPARACIÓN DE MAQUINARIA PARA LA INDUSTRIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1519,'C331211','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA Y TRACTORES DE USO AGROPECUARIO, FORESTAL Y PARA LA EXPLOTACIÓN MADERERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1520,'C331212','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA PARA LA MINERÍA, LA CONSTRUCCIÓN Y LA EXTRACCIÓN DE PETRÓLEO Y GAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1521,'C331213','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1522,'C331214','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA PARA LA PRODUCCIÓN DE TEXTILES, PRENDAS DE VESTIR Y ARTÍCULOS DE CUERO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1523,'C331215','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MAQUINARIA PARA LA FABRICACIÓN DE PAPEL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1524,'C331216','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE HORNOS PARA PROCESOS INDUSTRIALES, MAQUINARIA METALÚRGICA, HERRAMIENTAS Y ACCESORIOS PARA CORTAR Y CONFORMAR METALES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1525,'C331217','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE BOMBAS, EQUIPO DE PROPULSIÓN DE FLUIDOS Y EQUIPOS AFINES, ELEMENTOS DE TRANSMISIÓN E IMPULSIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1526,'C331218','SERVICIOS DE REPARACIÓN DE VÁLVULAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1527,'C33129','REPARACIÓN DE OTRO TIPO DE MAQUINARIA Y EQUIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1528,'C331291','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MÁQUINAS Y HERRAMIENTAS DE OFICINA Y CONTABILIDAD A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: MÁQUINAS DE ESCRIBIR, FOTOCOPIADORAS, BÁSCULAS, CALCULADORAS, SEAN O NO ELECTRÓNICAS ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1529,'C331292','SERVICIOS DE REPARACIÓN DE MAQUINARIA DE USO COMERCIAL, MÁQUINAS DE VENTA AUTOMÁTICA, MÁQUINAS REGISTRADORAS, EQUIPO COMERCIAL DE REFRIGERACIÓN Y PURIFICACIÓN DE AIRE A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1530,'C331293','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MOTORES DISTINTOS DE LOS DE VEHÍCULOS AUTOMOTORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: MOTORES DE BUQUES O DE LOCOMOTORAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1531,'C331299','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE OTROS TIPOS DE MAQUINARIA DE USO ESPECIAL DE LA DIVISIÓN 28 (FABRICACIÓN DE MAQUINARIA Y EQUIPO N.C.P.): EQUIPO DE MANIPULACIÓN DE MATERIALES (EQUIPO DE ELEVACIÓN Y MANIPULACIÓN, CARGA Y DESCARGA) Y OTRAS HERRAMIENTAS DE MANO MOTORIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1532,'C3313','REPARACIÓN DE EQUIPO ELECTRÓNICO Y ÓPTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1533,'C33130','REPARACIÓN DE EQUIPO ELECTRÓNICO Y ÓPTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1534,'C331301','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DEL EQUIPO DE MEDICIÓN, PRUEBA, NAVEGACIÓN Y CONTROL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: INSTRUMENTOS DE MOTORES DE AERONAVES, EQUIPO DE MEDICIÓN DE EMISIONES DE VEHÍCULOS AUTOMOTORES, INSTRUMENTOS METEOROLÓGICOS, EQUIPO DE ENSAYO E INSPECCIÓN DE PROPIEDADES FÍSICAS, ELÉCTRICAS Y QUÍMICAS, INSTRUMENTOS DE PROSPECCIÓN, INSTRUMENTOS DE DETECCIÓN Y VIGILANCIA DE RADIACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1535,'C331302','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE EQUIPO DE IRRADIACIÓN Y EQUIPO ELECTRÓNICO DE USO MÉDICO Y TERAPÉUTICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: EQUIPO DE TOMOGRAFÍA POR RESONANCIA MAGNÉTICA, ULTRASONIDOS DE USO MÉDICO, MARCAPASOS, APARATOS PARA SORDOS, ELECTROCARDIÓGRAFOS, EQUIPO ELECTRÓNICO DE ENDOSCOPIA, APARATOS DE IRRADIACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1536,'C331303','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE INSTRUMENTOS Y EQUIPO ÓPTICO DE LA CLASE SI SE UTILIZAN PRINCIPALMENTE CON FINES COMERCIALES, A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO COMO: BINOCULARES, MICROSCOPIOS (EXCEPTO LOS ELECTRÓNICOS Y PROTÓNICOS), TELESCOPIOS, PRISMAS Y LENTES (EXCEPTO LAS OFTÁLMICAS), EQUIPO FOTOGRÁFICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1537,'C3314','REPARACIÓN DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1538,'C33140','REPARACIÓN DE EQUIPO ELÉCTRICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1539,'C331401','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE TRANSFORMADORES DE FUERZA Y DE DISTRIBUCIÓN,  TRANSFORMADORES PARA USOS ESPECIALES, MOTORES ELÉCTRICOS, GENERADORES Y MOTORES GENERADORES, CONVERTIDORES ELÉCTRICOS COMO: RECTIFICADORES E INVERSORES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1540,'C331402','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE DISPOSITIVOS Y APARATOS DE CONMUTACIÓN, RELÉS Y CONTROLES INDUSTRIALES, DISPOSITIVOS DE CABLEADO PORTADORES DE CORRIENTE Y DISPOSITIVOS DE CABLEADO NO PORTADORES DE CORRIENTE PARA CIRCUITOS ELÉCTRICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1541,'C331403','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE EQUIPO DE ILUMINACIÓN (ALUMBRADO) ELÉCTRICO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1542,'C331409','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE OTROS EQUIPOS ELÉCTRICOS: BATERÍAS PRIMARIAS Y DE ALMACENAMIENTO, ETCÉTERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO: MULTIMETROS, ELECTRÓMETROS ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1543,'C3315','REPARACIÓN DE EQUIPO DE TRANSPORTE, EXCEPTO VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1544,'C33150','REPARACIÓN DE EQUIPO DE TRANSPORTE, EXCEPTO VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1545,'C331501','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO CORRIENTE DE BUQUES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1546,'C331502','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE EMBARCACIONES DE RECREO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1547,'C331503','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE LOCOMOTORAS Y VAGONES (EXCEPTO LA RECONSTRUCCIÓN O CONVERSIÓN EN FÁBRICA) A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1548,'C331504','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE AERONAVES (EXCEPTO LA CONVERSIÓN, EL REACONDICIONAMIENTO Y LA RECONSTRUCCIÓN EN FÁBRICA) A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1549,'C331505','SERVICIOS DE REPARACIÓN Y MANTENIMIENTO DE MOTORES DE AERONAVES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1550,'C331506','SERVICIOS DE REPARACIÓN DE VAGONES Y VAGONETAS DE TRACCIÓN ANIMAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1551,'C3319','REPARACIÓN DE OTROS TIPOS DE EQUIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1552,'C33190','REPARACIÓN DE OTROS TIPOS DE EQUIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1553,'C331901','SERVICIOS DE REPARACIÓN DE REDES DE PESCA, INCLUIDO SU REMIENDO, CORDAJES, APAREJOS, LONAS Y LONAS IMPERMEABLES, SACOS DE ALMACENAMIENTO DE ABONOS Y PRODUCTOS QUÍMICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1554,'C331902','SERVICIOS DE REPARACIÓN O REACONDICIONAMIENTO DE PALETAS, TONELES, BARRICAS Y EQUIPO SIMILAR DE MADERA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1555,'C331903','SERVICIOS DE REPARACIÓN DE MÁQUINAS TRAGAMONEDAS Y OTROS JUEGOS ACCIONADOS CON MONEDAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1556,'C331904','SERVICIOS DE RESTAURACIÓN DE ÓRGANOS Y OTROS INSTRUMENTOS MUSICALES HISTÓRICOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1557,'C332','INSTALACIÓN DE MAQUINARIA Y EQUIPO INDUSTRIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1558,'C3320','INSTALACIÓN DE MAQUINARIA Y EQUIPO INDUSTRIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1559,'C33200','INSTALACIÓN DE MAQUINARIA Y EQUIPO INDUSTRIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1560,'C332001','SERVICIOS DE INSTALACIÓN DE MAQUINARIA INDUSTRIAL EN PLANTAS INDUSTRIALES, EQUIPO DE CONTROL DE PROCESOS INDUSTRIALES, ACTIVIDADES DE MECÁNICOS INSTALADORES, MONTAJE DE MÁQUINAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1561,'C332002','SERVICIOS DE DESMANTELAMIENTO DE MAQUINARIA Y EQUIPO EN GRAN ESCALA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1562,'C332009','SERVICIOS DE INSTALACIÓN DE OTROS TIPOS DE EQUIPO INDUSTRIAL A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, COMO: EQUIPO DE COMUNICACIONES, ORDENADORES CENTRALES Y SIMILARES, EQUIPO DE IRRADIACIÓN, EQUIPO ELECTROMÉDICO, ELÉCTRICO, ETCÉTERA, INCLUIDO LA INSTALACIÓN DE EQUIPO PARA BOLERAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1563,'D','SUMINISTRO DE ELECTRICIDAD, GAS, VAPOR Y AIRE ACONDICIONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1564,'D35','SUMINISTRO DE ELECTRICIDAD, GAS, VAPOR Y AIRE ACONDICIONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1565,'D351','GENERACIÓN, TRANSMISIÓN Y DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1566,'D3510','GENERACIÓN, TRANSMISIÓN Y DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1567,'D35100','GENERACIÓN, TRANSMISIÓN Y DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1568,'D351001','ACTIVIDADES DE OPERACIÓN DE INSTALACIONES DE GENERACIÓN DE ENERGÍA ELÉCTRICA, POR DIVERSOS MEDIOS: TÉRMICA (TURBINA DE GAS O DIESEL), NUCLEAR, HIDROELÉCTRICA, SOLAR, MAREAL Y DE OTROS TIPOS INCLUSO DE ENERGÍA RENOVABLE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1569,'D351002','OPERACIÓN DE SISTEMAS DE TRANSMISIÓN Y DISTRIBUCIÓN DE ENERGÍA ELÉCTRICA (QUE CONSTAN DE POSTES, MEDIDORES Y CABLEADO), QUE TRANSPORTAN LA ENERGÍA ELÉCTRICA RECIBIDA DESDE LAS INSTALACIONES DE GENERACIÓN O TRANSMISIÓN HACIA EL CONSUMIDOR FINAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1570,'D351003','ACTIVIDADES DE AGENTES DE ENERGÍA ELÉCTRICA QUE ORGANIZA LA VENTA DE ELECTRICIDAD VÍA SISTEMAS DE DISTRIBUCIÓN DE ENERGÍA OPERADOS POR OTROS. GESTIÓN DE INTERCAMBIADORES ELÉCTRICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1571,'D352','FABRICACIÓN DE GAS; DISTRIBUCIÓN DE COMBUSTIBLES GASEOSOS POR TUBERÍAS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1572,'D3520','FABRICACIÓN DE GAS; DISTRIBUCIÓN DE COMBUSTIBLES GASEOSOS POR TUBERÍAS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1573,'D35200','FABRICACIÓN DE GAS; DISTRIBUCIÓN DE COMBUSTIBLES GASEOSOS POR TUBERÍAS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1574,'D352001','PRODUCCIÓN DE GAS PARA SU SUMINISTRO MEDIANTE LA DESTILACIÓN DEL CARBÓN A PARTIR DE SUBPRODUCTOS DE LA AGRICULTURA O A PARTIR DE DESECHOS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1575,'D352002','FABRICACIÓN DE COMBUSTIBLES GASEOSOS CON UN VALOR CALORÍFICO ESPECÍFICO, MEDIANTE LA PURIFICACIÓN, LA MEZCLA Y OTROS PROCESOS DE GASES DE DIVERSOS TIPOS, INCLUIDO EL GAS NATURAL.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1576,'D352003','ACTIVIDADES DE TRANSPORTE, DISTRIBUCIÓN Y SUMINISTRO DE COMBUSTIBLES GASEOSOS DE CUALQUIER TIPO POR MEDIO DE UN SISTEMA DE TUBERÍAS, VENTA DE GAS A LOS USUARIOS POR MEDIO DE TUBERÍAS, ACTIVIDADES DE LOS AGENTES O CORREDORES QUE VENDEN GAS A TRAVÉS DE SISTEMAS DE DISTRIBUCIÓN OPERADOS POR OTROS Y ACTIVIDADES DE BOLSAS DE PRODUCTOS BÁSICOS Y MERCADOS DE CAPACIDAD DE TRANSPORTE PARA COMBUSTIBLES GASEOSOS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1577,'D353','SUMINISTRO DE VAPOR Y DE AIRE ACONDICIONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1578,'D3530','SUMINISTRO DE VAPOR Y DE AIRE ACONDICIONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1579,'D35300','SUMINISTRO DE VAPOR Y DE AIRE ACONDICIONADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1580,'D353001','PRODUCCIÓN, CAPTACIÓN Y DISTRIBUCIÓN DE VAPOR Y AGUA CALIENTE PARA CALEFACCIÓN, PARA LA PRODUCCIÓN DE ENERGÍA Y PARA OTROS FINES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1581,'D353002','PRODUCCIÓN Y DISTRIBUCIÓN DE AIRE REFRIGERADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1582,'D353003','PRODUCCIÓN Y DISTRIBUCIÓN DE AGUA FRÍA CON FINES DE REFRIGERACIÓN. INCLUYE LA PRODUCCIÓN DE HIELO, INCLUIDO HIELO PARA LA ELABORACIÓN DE PRODUCTOS ALIMENTICIOS Y PARA OTROS FINES (P. EJ., PARA REFRIGERACIÓN).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1583,'E','DISTRIBUCIÓN DE AGUA; ALCANTARILLADO, GESTIÓN DE DESECHOS Y ACTIVIDADES DE SANEAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1584,'E36','CAPTACIÓN, TRATAMIENTO Y DISTRIBUCIÓN DE AGUA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1585,'E360','CAPTACIÓN, TRATAMIENTO Y DISTRIBUCIÓN DE AGUA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1586,'E3600','CAPTACIÓN, TRATAMIENTO Y DISTRIBUCIÓN DE AGUA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1587,'E36000','CAPTACIÓN, TRATAMIENTO Y DISTRIBUCIÓN DE AGUA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1588,'E360001','ACTIVIDADES DE CAPTACIÓN DE AGUA DE: RÍOS, LAGOS, POZOS, LLUVIA ETCÉTERA; PURIFICACIÓN DE AGUA PARA SU DISTRIBUCIÓN; TRATAMIENTO DE AGUA PARA USO INDUSTRIAL Y OTROS USOS; DISTRIBUCIÓN DE AGUA POR MEDIO DE: TUBERÍAS, CAMIONES (TANQUEROS) U OTROS MEDIOS, A USUARIOS RESIDENCIALES, COMERCIALES, INDUSTRIALES Y DE OTRO TIPO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1589,'E360002','DESALINIZACIÓN DE AGUA DE MAR O AGUA SUBTERRÁNEA PARA PRODUCIR AGUA COMO PRINCIPAL PRODUCTO DE INTERÉS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1590,'E360003','OPERACIÓN DE CANALES DE RIEGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1591,'E37','EVACUACIÓN DE AGUAS RESIDUALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1592,'E370','EVACUACIÓN DE AGUAS RESIDUALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1593,'E3700','EVACUACIÓN DE AGUAS RESIDUALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1594,'E37000','ALCANTARILLADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1595,'E370000','ACTIVIDADES DE GESTIÓN DE SISTEMAS DE ALCANTARILLADO Y DE INSTALACIONES DE TRATAMIENTO DE AGUAS RESIDUALES; RECOLECCIÓN Y TRANSPORTE DE AGUAS RESIDUALES HUMANAS O INDUSTRIALES DE UNO O DIVERSOS USUARIOS, ASÍ COMO DE AGUA DE LLUVIA, POR MEDIO DE REDES DE ALCANTARILLADO, COLECTORES, TANQUES Y OTROS MEDIOS DE TRANSPORTE (CAMIONES CISTERNA DE RECOGIDA DE AGUAS NEGRAS, ETCÉTERA); VACIADO Y LIMPIEZA DE POZOS NEGROS Y FOSAS SÉPTICAS, FOSOS Y POZOS DE ALCANTARILLADOS; MANTENIMIENTO DE INODOROS DE ACCIÓN QUÍMICA; TRATAMIENTO DE AGUAS RESIDUALES (INCLUIDAS AGUAS RESIDUALES HUMANAS E INDUSTRIALES, AGUA DE PISCINAS, ETCÉTERA) MEDIANTE PROCESOS FÍSICOS, QUÍMICOS Y BIOLÓGICOS COMO LOS DE DILUCIÓN, CRIBADO, FILTRACIÓN, SEDIMENTACIÓN, ETCÉTERA; MANTENIMIENTO Y LIMPIEZA DE CLOACAS Y ALCANTARILLAS, INCLUIDO EL DESATASCO DE CLOACAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1596,'E38','RECOLECCIÓN, TRATAMIENTO Y ELIMINACIÓN DE DESECHOS, RECUPERACIÓN DE MATERIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1597,'E381','RECOLECCIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1598,'E3811','RECOLECCIÓN DE DESECHOS NO PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1599,'E38110','RECOLECCIÓN DE DESECHOS NO PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1600,'E381100','RECOLECCIÓN DE DESECHOS SÓLIDOS NO PELIGROSOS (BASURA) EN UNA ZONA DELIMITADA: RESIDUOS DE HOGARES Y EMPRESAS POR MEDIO DE CONTENEDORES; DESECHOS RECUPERABLES MEZCLADOS DE MATERIALES RECICLABLES; ACEITES Y GRASAS USADOS EN LA COCINA; DESPERDICIOS COLOCADOS EN LUGARES PÚBLICOS; DESECHOS DE ACTIVIDADES PROVENIENTES DE LA CONSTRUCCIÓN Y DEMOLICIÓN, RECOLECCIÓN Y REMOCIÓN DE ESCOMBROS; DESECHOS PRODUCIDOS POR FÁBRICAS TEXTILES. INCLUYE LA GESTIÓN DE ESTACIONES DE TRANSFERENCIA DE DESECHOS NO PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1601,'E3812','RECOLECCIÓN DE DESECHOS PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1602,'E38120','RECOLECCIÓN DE DESECHOS PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1603,'E381200','ACTIVIDADES DE RECOLECCIÓN DE DESECHOS PELIGROSOS: SUSTANCIAS EXPLOSIVAS, OXIDANTES, INFLAMABLES, TÓXICAS, IRRITANTES, CARCINÓGENAS, CORROSIVAS O INFECCIOSAS Y OTRAS SUBSTANCIAS Y PREPARADOS NOCIVOS PERJUDICIALES PARA LA SALUD HUMANA Y EL MEDIO AMBIENTE COMO: ACEITES USADOS DE BUQUES O GARAJES, RESIDUOS BIOLÓGICOS PELIGROSOS, PILAS Y BATERÍAS USADAS; LA IDENTIFICACIÓN, TRATAMIENTO, EMBALADO Y ETIQUETADO DE LOS DESECHOS PARA SU TRANSPORTE. SE INCLUYEN LAS SIGUIENTES ACTIVIDADES DE RECOLECCIÓN DE DESECHOS PELIGROSOS Y GESTIÓN DE ESTACIONES DE EXPEDICIÓN DE DESECHOS PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1604,'E382','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1605,'E3821','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS NO PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1606,'E38210','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS NO PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1607,'E382101','ACTIVIDADES DE OPERACIÓN DE RELLENOS SANITARIOS PARA LA ELIMINACIÓN DE DESECHOS NO PELIGROSOS; ELIMINACIÓN DE DESECHOS NO PELIGROSOS MEDIANTE COMBUSTIÓN O INCINERACIÓN O POR OTROS MÉTODOS, CON O SIN PRODUCCIÓN RESULTANTE DE ELECTRICIDAD O VAPOR, COMBUSTIBLES SUSTITUTIVOS, BIOGÁS, CENIZAS U OTROS SUBPRODUCTOS PARA SU UTILIZACIÓN POSTERIOR, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1608,'E382102','ACTIVIDADES DE TRATAMIENTO DE DESECHOS ORGÁNICOS PARA SU TRANSFORMACIÓN. INCLUYE LA PRODUCCIÓN DE COMPOST CON DESECHOS ORGÁNICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1609,'E3822','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1610,'E38220','TRATAMIENTO Y ELIMINACIÓN DE DESECHOS PELIGROSOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1611,'E382200','OPERACIÓN DE INSTALACIONES PARA EL TRATAMIENTO DE DESECHOS PELIGROSOS, TRATAMIENTO Y ELIMINACIÓN DE ANIMALES TÓXICOS VIVOS Y MUERTOS Y OTROS DESECHOS CONTAMINADOS; INCINERACIÓN DE DESECHOS PELIGROSOS, REMOCIÓN DE PRODUCTOS USADOS COMO REFRIGERADORES, CON OBJETO DE ELIMINAR LOS DESECHOS PELIGROSOS; TRATAMIENTO, REMOCIÓN Y ALMACENAMIENTO DE DESECHOS NUCLEARES RADIACTIVOS, INCLUIDO EL TRATAMIENTO Y ELIMINACIÓN DE DESECHOS RADIACTIVOS DE TRANSICIÓN, ES DECIR QUE SE DESINTEGRAN DURANTE EL PERÍODO DE TRANSPORTE, PROCEDENTES DE HOSPITALES, ENCAPSULACIÓN, PREPARACIÓN Y OTRAS FORMAS DE TRATAMIENTO DE DESECHOS NUCLEARES PARA SU ALMACENAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1612,'E383','RECUPERACIÓN DE MATERIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1613,'E3830','RECUPERACIÓN DE MATERIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1614,'E38300','RECUPERACIÓN DE MATERIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1615,'E383001','ACTIVIDADES DE PROCESAMIENTO DE DESPERDICIOS Y DESECHOS METÁLICOS Y NO METÁLICOS Y DE OTROS ARTÍCULOS PARA CONVERTIRLOS EN MATERIAS PRIMAS SECUNDARIAS, NORMALMENTE MEDIANTE UN PROCESO DE TRANSFORMACIÓN MECÁNICO O QUÍMICO; RECUPERACIÓN DE MATERIALES DE CORRIENTES DE DESECHOS: SEPARACIÓN Y CLASIFICACIÓN DE MATERIALES RECUPERABLES DE CORRIENTES DE DESECHOS NO PELIGROSOS (BASURA); SEPARACIÓN Y CLASIFICACIÓN EN CATEGORÍAS DISTINTAS DE MATERIALES RECUPERABLES MEZCLADOS COMO: PAPEL, PLÁSTICOS, LATAS DE BEBIDAS USADAS, Y METALES. ENTRE LOS PROCESOS DE TRANSFORMACIÓN MECÁNICA O QUÍMICA QUE SE REALIZAN SE CUENTAN LOS SIGUIENTES: APLASTAMIENTO MECÁNICO DE DESPERDICIOS METÁLICOS, COMO: AUTOMÓVILES USADOS, LAVADORAS USADAS, BICICLETAS USADAS, ETCÉTERA, PARA SU POSTERIOR CLASIFICACIÓN Y SEPARACIÓN; DESGUACE DE AUTOMÓVILES, BUQUES, COMPUTADORAS, APARATOS DE TELEVISIÓN Y OTROS EQUIPOS PARA LA RECUPERACIÓN DE MATERIALES; REDUCCIÓN MECÁNICA DE GRANDES VOLÚMENES DE METAL, COMO VAGONES DE FERROCARRIL; TRITURACIÓN DE DESECHOS DE METAL, VEHÍCULOS DESECHADOS, ETCÉTERA; OTROS MÉTODOS DE TRATAMIENTO MECÁNICO, COMO EL CORTE Y EL PRENSADO PARA REDUCIR EL VOLUMEN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1616,'E383002','RECUPERACIÓN DE METALES QUE CONTIENEN LOS DESECHOS DE MATERIAL FOTOGRÁFICO; POR EJEMPLO, SOLUCIÓN FIJADORA, PELÍCULAS O PAPEL FOTOGRÁFICO; RECUPERACIÓN DE PRODUCTOS DE CAUCHO, COMO LLANTAS USADAS, PARA OBTENER MATERIAS PRIMAS SECUNDARIAS; CLASIFICACIÓN Y NODULIZACIÓN DE PLÁSTICOS PARA PRODUCIR MATERIAS PRIMAS SECUNDARIAS PARA LA FABRICACIÓN DE TUBOS, MACETAS, BANDEJAS DE CARGA Y PRODUCTOS SIMILARES; PROCESAMIENTO (LIMPIEZA, FUSIÓN, TRITURACIÓN) DE DESECHOS DE PLÁSTICO O CAUCHO PARA CONVERTIRLOS EN GRÁNULOS; TRITURACIÓN, LIMPIEZA Y CLASIFICACIÓN DE DESECHOS DE VIDRIO; TRITURACIÓN, LIMPIEZA Y CLASIFICACIÓN DE OTROS DESECHOS, COMO LOS DE DEMOLICIONES PARA OBTENER MATERIAS PRIMAS SECUNDARIAS; PROCESAMIENTO DE ACEITES Y GRASAS DE COCINA Y DE OTROS DESECHOS Y SUSTANCIAS RESIDUALES DE PRODUCTOS ALIMENTICIOS, BEBIDAS Y TABACO PARA OBTENER MATERIAS PRIMAS SECUNDARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1617,'E39','ACTIVIDADES DE DESCONTAMINACIÓN Y OTROS SERVICIOS DE  GESTIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1618,'E390','ACTIVIDADES DE DESCONTAMINACIÓN Y OTROS SERVICIOS DE  GESTIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1619,'E3900','ACTIVIDADES DE DESCONTAMINACIÓN Y OTROS SERVICIOS DE  GESTIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1620,'E39000','ACTIVIDADES DE DESCONTAMINACIÓN Y OTROS SERVICIOS DE  GESTIÓN DE DESECHOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1621,'E390001','DESCONTAMINACIÓN DE SUELOS Y AGUAS SUBTERRÁNEAS EN EL LUGAR DE CONTAMINACIÓN UTILIZANDO; POR EJEMPLO, MÉTODOS MECÁNICOS, QUÍMICOS O BIOLÓGICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1622,'E390002','ACTIVIDADES DE DESCONTAMINACIÓN DE INSTALACIONES O TERRENOS INDUSTRIALES, INCLUIDOS LOS NUCLEARES; DESCONTAMINACIÓN Y LIMPIEZA DE AGUAS SUPERFICIALES TRAS SU CONTAMINACIÓN ACCIDENTAL; POR EJEMPLO, MEDIANTE LA RECOGIDA DE LOS CONTAMINANTES O LA APLICACIÓN DE SUSTANCIAS QUÍMICAS; LIMPIEZA DE DERRAMES DE PETRÓLEO Y OTRAS FORMAS DE CONTAMINACIÓN EN TIERRA, AGUAS SUPERFICIALES, MARES Y OCÉANOS, INCLUIDAS ZONAS COSTERAS; ELIMINACIÓN DE ASBESTO, PINTURA DE PLOMO Y OTROS MATERIALES TÓXICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1623,'E390009','OTRAS ACTIVIDADES ESPECIALIZADAS DE CONTROL DE LA CONTAMINACIÓN, INCLUIDO LA REMOCIÓN DE MINAS TERRESTRES Y ARTEFACTOS SIMILARES (INCLUIDA SU DETONACIÓN).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1624,'F','CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1625,'F41','CONSTRUCCIÓN DE EDIFICIOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1626,'F410','CONSTRUCCIÓN DE EDIFICIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1627,'F4100','CONSTRUCCIÓN DE EDIFICIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1628,'F41001','CONSTRUCCIÓN DE EDIFICIOS RESIDENCIALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1629,'F410010','CONSTRUCCIÓN DE TODO TIPO DE EDIFICIOS RESIDENCIALES: CASAS FAMILIARES INDIVIDUALES, EDIFICIOS MULTIFAMILIARES, INCLUSO EDIFICIOS DE ALTURAS ELEVADAS, VIVIENDAS PARA ANCIANATOS, CASAS PARA BENEFICENCIA, ORFANATOS, CÁRCELES, CUARTELES, CONVENTOS, CASAS RELIGIOSAS. INCLUYE REMODELACIÓN, RENOVACIÓN O REHABILITACIÓN DE ESTRUCTURAS EXISTENTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1630,'F41002','CONSTRUCCIÓN DE EDIFICIOS NO RESIDENCIALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1631,'F410020','CONSTRUCCIÓN DE TODO TIPO DE EDIFICIOS NO RESIDENCIALES: EDIFICIOS DE PRODUCCIÓN INDUSTRIAL, EJ. FÁBRICAS, TALLERES, PLANTAS DE ENSAMBLAJE, HOSPITALES, ESCUELAS, EDIFICIOS DE OFICINAS, HOTELES, ALMACENES, CENTROS COMERCIALES, BODEGAS, RESTAURANTES, OBSERVATORIOS, IGLESIAS, MUSEOS, AEROPORTUARIOS, PORTUARIOS Y EDIFICIOS DE ESTACIONES DE BUSES, TROLEBUSES, TREN, INCLUSO ESTACIONAMIENTOS SUBTERRÁNEOS, DE INSTALACIONES DEPORTIVAS INTERIORES TECHADAS ETCÉTERA. INCLUYE REMODELACIÓN, RENOVACIÓN O REHABILITACIÓN DE ESTRUCTURAS EXISTENTES','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1632,'F41003','MONTAJE Y LEVANTAMIENTO DE CONSTRUCCIONES PREFABRICADAS EN EL LUGAR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1633,'F410030','MONTAJE Y LEVANTAMIENTO DE CONSTRUCCIONES PREFABRICADAS EN EL LUGAR.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1634,'F42','OBRAS DE INGENIERÍA CIVIL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1635,'F421','CONSTRUCCIÓN DE CARRETERAS Y LÍNEAS DE FERROCARRIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1636,'F4210','CONSTRUCCIÓN DE CARRETERAS Y LÍNEAS DE FERROCARRIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1637,'F42101','CONSTRUCCIÓN DE CARRETERAS Y AUTOPISTAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1638,'F421011','CONSTRUCCIÓN DE CARRETERAS, CALLES, CARRETERAS, Y OTRAS VÍAS PARA VEHÍCULOS O PEATONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1639,'F421012','OBRAS DE SUPERFICIE EN CALLES, CARRETERAS, AUTOPISTAS, PUENTES O TÚNELES, ASFALTADO DE CARRETERA, PINTURA Y OTROS TIPOS DE MARCADO DE CARRETERA, INSTALACIÓN DE BARRERAS DE EMERGENCIA, SEÑALES DE TRÁFICO Y ELEMENTOS SIMILARES. INCLUYE LA CONSTRUCCIÓN DE PISTAS PARA AEROPUERTOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1640,'F42102','CONSTRUCCIÓN DE LÍNEAS DE FERROCARRIL Y METRO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1641,'F421020','CONSTRUCCIÓN DE LÍNEAS DE FERROCARRIL Y DE METRO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1642,'F42103','CONSTRUCCIÓN DE TÚNELES Y PUENTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1643,'F421031','CONSTRUCCIÓN DE TÚNELES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1644,'F421032','CONSTRUCCIÓN DE PUENTES Y VIADUCTOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1645,'F422','CONSTRUCCIÓN DE PROYECTOS DE SERVICIOS PÚBLICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1646,'F4220','CONSTRUCCIÓN DE PROYECTOS DE SERVICIOS PÚBLICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1647,'F42201','CONSTRUCCIÓN DE PROYECTOS DE REDES PARA FLUIDOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1648,'F422011','CONSTRUCCIÓN DE OBRAS DE INGENIERÍA CIVIL RELACIONADAS CON: TUBERÍAS URBANAS, CONSTRUCCIÓN DE CONDUCTOS PRINCIPALES Y ACOMETIDAS DE REDES DE DISTRIBUCIÓN DE AGUA SISTEMAS DE RIEGO (CANALES), ESTACIONES DE BOMBEO, DEPÓSITOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1649,'F422012','CONSTRUCCIÓN DE SISTEMAS DE ALCANTARILLADO, INCLUIDA SU REPARACIÓN, INSTALACIONES DE EVACUACIÓN DE AGUAS RESIDUALES Y PERFORACIÓN DE POZOS DE AGUA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1650,'F42202','CONSTRUCCIÓN DE REDES ELÉCTRICAS Y DE TELECOMUNICACIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1651,'F422020','CONSTRUCCIÓN DE OBRAS CIVILES PARA: CENTRALES ELÉCTRICAS, LÍNEAS DE TRANSMISIÓN DE ENERGÍA ELÉCTRICA Y COMUNICACIONES; OBRAS AUXILIARES EN ZONAS URBANAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1652,'F429','CONSTRUCCIÓN DE OTRAS OBRAS DE INGENIERÍA CIVIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1653,'F4290','CONSTRUCCIÓN DE OTRAS OBRAS DE INGENIERÍA CIVIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1654,'F42901','CONSTRUCCIONES DE OBRAS HIDRÁULICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1655,'F429011','CONSTRUCCIÓN DE VÍAS DE NAVEGACIÓN, OBRAS PORTUARIAS Y FLUVIALES, PUERTOS DEPORTIVOS, ESCLUSAS, PRESAS Y DIQUES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1656,'F429012','DRAGADO DE VÍAS DE NAVEGACIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1657,'F42909','CONSTRUCCIÓN DE OTROS PROYECTOS DE INGENIERÍA CIVIL N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1658,'F429091','CONSTRUCCIÓN DE INSTALACIONES INDUSTRIALES REFINERÍAS, FÁBRICAS DE PRODUCTOS QUÍMICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1659,'F429092','OBRAS DE CONSTRUCCIONES DISTINTAS DE LAS DE EDIFICIOS POR EJEMPLO: INSTALACIONES DEPORTIVAS AL AIRE LIBRE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1660,'F429093','SUBDIVISIÓN (LOTIZACIÓN) DE TIERRAS CON MEJORA (POR EJEMPLO, CONSTRUCCIÓN DE CARRETERAS, INFRAESTRUCTURA DE SUMINISTRO PÚBLICO, ETCÉTERA).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1661,'F43','ACTIVIDADES ESPECIALIZADAS DE LA CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1662,'F431','DEMOLICIÓN Y PREPARACIÓN DEL TERRENO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1663,'F4311','DEMOLICIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1664,'F43110','DEMOLICIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1665,'F431100','DEMOLICIÓN O DERRIBO DE EDIFICIOS Y OTRAS ESTRUCTURAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1666,'F4312','PREPARACIÓN DEL TERRENO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1667,'F43120','PREPARACIÓN DE TERRENOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1668,'F431201','LIMPIEZA DE TERRENOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1669,'F431202','MOVIMIENTO DE TIERRAS: EXCAVACIÓN, NIVELACIÓN Y ORDENACIÓN DE TERRENOS DE CONSTRUCCIÓN, EXCAVACIÓN DE ZANJAS, REMOCIÓN DE PIEDRAS, VOLADURA, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1670,'F431203','PERFORACIONES DE PRUEBA, SONDEOS DE EXPLORACIÓN Y RECOGIDA DE MUESTRAS DE SONDEO PARA ACTIVIDADES DE CONSTRUCCIÓN Y PARA FINES GEOFÍSICOS, GEOLÓGICOS O SIMILARES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1671,'F431204','CONSTRUCCIÓN DE DRENAJE DE TERRENOS DE CONSTRUCCIÓN INCLUIDO TIERRAS AGRÍCOLAS O FORESTALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1672,'F431205','PREPARACIÓN DE TERRENOS PARA ACTIVIDADES DE EXPLOTACIÓN DE MINAS Y CANTERAS: REMOCIÓN DEL ESTÉRIL (DESTAPE DE MINAS) Y ACTIVIDADES DE OTRO TIPO PARA PREPARAR Y APROVECHAR TERRENOS Y PROPIEDADES MINEROS, EXCEPTO YACIMIENTOS DE PETRÓLEO Y GAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1673,'F432','INSTALACIONES ELÉCTRICAS Y DE FONTANERÍA Y OTRAS INSTALACIONES PARA OBRAS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1674,'F4321','INSTALACIONES ELÉCTRICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1675,'F43210','INSTALACIONES ELÉCTRICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1676,'F432101','INSTALACIÓN DE ACCESORIOS ELÉCTRICOS, LÍNEAS DE TELECOMUNICACIONES, REDES INFORMÁTICAS Y LÍNEAS DE TELEVISIÓN POR CABLE, INCLUIDAS LÍNEAS DE FIBRA ÓPTICA, ANTENAS PARABÓLICAS. INCLUYE CONEXIÓN DE APARATOS ELÉCTRICOS, EQUIPO DOMÉSTICO Y SISTEMAS DE CALEFACCIÓN RADIANTE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1677,'F432102','INSTALACIÓN DE SISTEMAS DE ILUMINACIÓN, SISTEMAS DE ALARMA CONTRA INCENDIOS, SISTEMAS DE ALARMA CONTRA ROBOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1678,'F432103','INSTALACIÓN DE SISTEMAS DE ALUMBRADO Y SEÑALES ELÉCTRICAS DE CALLES, ALUMBRADO DE PISTAS DE AEROPUERTOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1679,'F4322','FONTANERÍA (PLOMERÍA, GASFITERÍA) E INSTALACIÓN DE CALEFACCIÓN Y AIRE ACONDICIONADO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1680,'F43220','INSTALACIÓN DE SISTEMAS DE CALEFACCIÓN, PLOMERÍA Y AIRE ACONDICIONADO (INCLUYE AMPLIACIONES, REFORMAS, MANTENIMIENTO Y REPARACIÓN).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1681,'F432201','INSTALACIÓN EN EDIFICIOS Y OTROS PROYECTOS DE CONSTRUCCIÓN DE: SISTEMAS DE CALEFACCIÓN (ELÉCTRICOS, DE GAS Y DE GASÓLEO), CALDERAS, TORRES DE REFRIGERACIÓN, COLECTORES DE ENERGÍA SOLAR NO ELÉCTRICOS, EQUIPO DE FONTANERÍA Y SANITARIO, EQUIPO Y CONDUCTOS DE VENTILACIÓN, REFRIGERACIÓN O AIRE ACONDICIONADO, CONDUCCIONES DE GAS, TUBERÍAS DE VAPOR, SISTEMAS DE ASPERSORES CONTRA INCENDIOS, SISTEMAS DE RIEGO POR ASPERSIÓN PARA EL CÉSPED.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1682,'F432202','INSTALACIÓN DE CANALIZACIÓN (CONDUCTOS).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1683,'F4329','OTRAS INSTALACIONES PARA OBRAS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1684,'F43290','OTRAS INSTALACIONES PARA OBRAS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1685,'F432901','INSTALACIÓN, REPARACIÓN Y EL MANTENIMIENTO DE ASCENSORES ASÍ COMO ESCALERAS MECÁNICAS EN EDIFICIOS U OTROS PROYECTOS DEDICADOS A LA CONSTRUCCIÓN DE PUERTAS AUTOMÁTICAS Y GIRATORIAS EN EDIFICIOS U OTROS PROYECTOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1686,'F432902','INSTALACIÓN, REPARACIÓN Y EL MANTENIMIENTO DE PARARRAYOS EN EDIFICIOS U OTROS PROYECTOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1687,'F432903','SISTEMAS DE LIMPIEZA POR ASPIRACIÓN EN EDIFICIOS U OTROS PROYECTOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1688,'F432904','AISLAMIENTO TÉRMICO, ACÚSTICO O CONTRA LAS VIBRACIONES EN EDIFICIOS U OTROS PROYECTOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1689,'F433','TERMINACIÓN Y ACABADO DE EDIFICIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1690,'F4330','TERMINACIÓN Y ACABADO DE EDIFICIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1691,'F43301','TRABAJOS DE ENLUCIDO (REVOCAMIENTO).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1692,'F433010','APLICACIÓN EN EDIFICIOS Y OTROS PROYECTOS DE CONSTRUCCIÓN DE YESO Y ESTUCO PARA INTERIORES Y EXTERIORES, CON LOS MATERIALES DE ENLISTONAR CORRESPONDIENTES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1693,'F43302','INSTALACIÓN DE CARPINTERÍA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1694,'F433020','INSTALACIÓN DE PUERTAS (EXCEPTO AUTOMÁTICAS Y GIRATORIAS), VENTANAS, MARCOS DE PUERTAS Y VENTANAS. INSTALACIÓN DE ACCESORIOS DE COCINAS, ARMARIOS EMPOTRADOS, ESCALERAS, MOBILIARIO DE TIENDAS Y SIMILARES DE MADERA U OTROS MATERIALES, ACABADOS INTERIORES COMO TECHOS, CUBIERTA DE MADERA DE PAREDES, MAMPARAS MÓVILES, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1695,'F43303','REVESTIMIENTO DE SUELOS Y PAREDES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1696,'F433031','INSTALACIÓN DE CERÁMICAS BALDOSAS, LOSAS Y LOSETAS DE CERÁMICA, HORMIGÓN O PIEDRA TALLADA PARA PAREDES Y PISOS, ACCESORIOS DE CERÁMICA PARA COCINAS, PARQUÉ Y OTROS REVESTIMIENTOS DE MADERA PARA PISOS, ALFOMBRAS Y CUBRIMIENTOS DE LINÓLEO PARA PISOS, INCLUIDOS LOS DE CAUCHO O PLÁSTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1697,'F433032','INSTALACIÓN DE PAPEL TAPIZ.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1698,'F433033','INSTALACIÓN DE PARQUET Y OTROS REVESTIMIENTOS DE MADERA PARA PAREDES Y PISOS EN EDIFICIOS U OTROS PROYECTOS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1699,'F43304','PINTURA E INSTALACIÓN DE VIDRIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1700,'F433041','PINTURA INTERIOR O EXTERIOR DE EDIFICIOS. INCLUYE PINTURA DE OBRAS DE INGENIERÍA CIVIL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1701,'F433042','INSTALACIÓN DE VIDRIOS, ESPEJOS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1702,'F43309','OTROS ACABADOS DE EDIFICIOS N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1703,'F433091','LIMPIEZA DE EDIFICIOS NUEVOS DESPUÉS DE SU CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1704,'F433099','OTRAS ACTIVIDADES DE TERMINACIÓN DE EDIFICIOS N.C.P.: INSTALACIÓN DE INTERIORES DE TIENDAS, CASAS MÓVILES, EMBARCACIONES, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1705,'F439','OTRAS ACTIVIDADES ESPECIALIZADAS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1706,'F4390','OTRAS ACTIVIDADES ESPECIALIZADAS DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1707,'F43901','OTRAS ACTIVIDADES DE CONSTRUCCIÓN ESPECIALIZADA N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1708,'F439011','ACTIVIDADES DE CONSTRUCCIÓN ESPECIALIZADAS EN UN ASPECTO COMÚN A DIFERENTES TIPOS DE ESTRUCTURAS Y QUE REQUIEREN CONOCIMIENTOS O EQUIPO ESPECIALIZADOS: CIMENTACIÓN, INCLUIDA LA HINCADURA DE PILOTES, INSTALACIÓN Y DESMONTAJE DE ANDAMIOS Y PLATAFORMAS DE TRABAJO, EXCLUIDO EL ALQUILER DE ANDAMIOS Y PLATAFORMAS, COLOCACIÓN DE MAMPUESTOS DE LADRILLO Y DE PIEDRA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1709,'F439012','TRABAJOS DE TRATAMIENTO DE LA HUMEDAD DE EDIFICIOS Y DE IMPERMEABILIZACIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1710,'F439013','MONTAJE DE PIEZAS ERECCIÓN DE ELEMENTOS DE ACERO NO FABRICADOS POR LA PROPIA UNIDAD CONSTRUCTORA, CURVADO DE ACERO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1711,'F439014','CONSTRUCCIÓN DE CHIMENEAS Y HORNOS INDUSTRIALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1712,'F439015','TRABAJOS EN LUGARES DE DIFÍCIL ACCESO QUE REQUIEREN LA UTILIZACIÓN DE TÉCNICAS DE ESCALADA Y DEL EQUIPO CORRESPONDIENTE, COMO, POR EJEMPLO, LOS TRABAJOS A GRAN ALTURA EN ESTRUCTURAS ELEVADAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1713,'F439016','CONSTRUCCIÓN DE CUBIERTA DE TECHOS Y TEJADOS DE EDIFICIOS RESIDENCIALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1714,'F43902','ALQUILER DE EQUIPO DE CONSTRUCCIÓN O DEMOLICIÓN DOTADO DE OPERARIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1715,'F439020','ALQUILER DE GRÚAS CON OPERADOR Y OTROS EQUIPOS DE CONSTRUCCIÓN QUE NO PUEDEN ASIGNARSE A UN TIPO DE CONSTRUCCIÓN ESPECÍFICO CON OPERARIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1716,'F43909','OTRAS CONSTRUCCIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1717,'F439091','CONSTRUCCIÓN DE PISCINAS AL AIRE LIBRE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1718,'F439092','LIMPIEZA DE EXTERIORES DE EDIFICIOS CON VAPOR, CON CHORRO DE ARENA Y CON OTROS MEDIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1719,'F439093','CONSTRUCCIÓN DE OBRAS SUBTERRÁNEAS: PROFUNDIZACIÓN (PERFORACIÓN) DE POZOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1720,'G','COMERCIO AL POR MAYOR Y AL POR MENOR; REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1721,'G45','COMERCIO Y REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1722,'G451','VENTA DE VEHÍCULOS AUTOMOTORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1723,'G4510','VENTA DE VEHÍCULOS AUTOMOTORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1724,'G45100','VENTA DE AUTOMÓVILES Y VEHÍCULOS DE MOTORES LIGEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1725,'G451001','VENTA DE VEHÍCULOS NUEVOS Y USADOS: VEHÍCULOS DE PASAJEROS, INCLUIDOS VEHÍCULOS ESPECIALIZADOS COMO: AMBULANCIAS Y MINIBUSES, CAMIONES, REMOLQUES Y SEMIRREMOLQUES, VEHÍCULOS DE ACAMPADA COMO: CARAVANAS Y AUTOCARAVANAS, VEHÍCULOS PARA TODO TERRENO (JEEPS, ETCÉTERA), INCLUIDO LA VENTA AL POR MAYOR Y AL POR MENOR POR COMISIONISTAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1726,'G451002','SUBASTA DE AUTOMÓVILES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1727,'G452','MANTENIMIENTO Y REPARACIÓN DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1728,'G4520','MANTENIMIENTO Y REPARACIÓN DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1729,'G45200','MANTENIMIENTO Y REPARACIÓN DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1730,'G452001','MANTENIMIENTO Y REPARACIÓN DE VEHÍCULOS AUTOMOTORES: REPARACIÓN MECÁNICA, ELÉCTRICA, SISTEMAS DE INYECCIÓN ELÉCTRICOS, CARROCERÍAS, PARTES DE VEHÍCULOS AUTOMOTORES: PARABRISAS, VENTANAS, ASIENTOS Y TAPICERÍAS. INCLUYE EL TRATAMIENTO ANTI ÓXIDO, PINTURAS A PISTOLA O BROCHA A LOS VEHÍCULOS Y AUTOMOTORES, LA INSTALACIÓN DE PARTES, PIEZAS Y ACCESORIOS QUE NO SE REALIZA COMO PARTE DEL PROCESO DE FABRICACIÓN (PARLANTES, RADIOS, ALARMAS, ETCÉTERA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1731,'G452002','MANTENIMIENTO Y REPARACIÓN, INSTALACIÓN, CAMBIO DE NEUMÁTICOS (LLANTAS) Y TUBOS (VULCANIZADORAS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1732,'G452003','SERVICIOS DE LAVADO, ENGRASADO, PULVERIZADO, ENCERADO, CAMBIOS DE ACEITE, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1733,'G453','VENTA DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1734,'G4530','VENTA DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1735,'G45300','VENTA DE PARTES, PIEZAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1736,'G453000','VENTA DE TODO TIPO DE PARTES, COMPONENTES, SUMINISTROS, HERRAMIENTAS Y ACCESORIOS PARA VEHÍCULOS AUTOMOTORES COMO: NEUMÁTICOS (LLANTAS), CÁMARAS DE AIRE PARA NEUMÁTICOS (TUBOS). INCLUYE BUJÍAS, BATERÍAS, EQUIPO DE ILUMINACIÓN PARTES Y PIEZAS ELÉCTRICAS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1737,'G454','VENTA, MANTENIMIENTO Y REPARACIÓN DE MOTOCICLETAS Y DE SUS PARTES, PIEZAS Y ACCESORIOS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1738,'G4540','VENTA, MANTENIMIENTO Y REPARACIÓN DE MOTOCICLETAS Y DE SUS PARTES, PIEZAS Y ACCESORIOS.','S',0.19,'S',0.13,'N',0.00,'N',0.00,'N',0.00,0.32,3.20,'B'),
	 (1739,'G45400','VENTA DE MOTOCICLETAS, INCLUSO CICLOMOTORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1740,'G454001','VENTA DE MOTOCICLETAS, INCLUSO CICLOMOTORES (VELOMOTORES), TRICIMOTOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1741,'G454002','VENTA DE PARTES, PIEZAS Y ACCESORIOS PARA MOTOCICLETAS (INCLUSO POR COMISIONISTAS Y COMPAÑÍAS DE VENTA POR CORREO).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1742,'G454003','ACTIVIDADES DE MANTENIMIENTO Y REPARACIÓN DE MOTOCICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1743,'G46','COMERCIO AL POR MAYOR, EXCEPTO EL DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1744,'G461','VENTA AL POR MAYOR A CAMBIO DE UNA COMISIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1745,'G4610','VENTA AL POR MAYOR A CAMBIO DE UNA COMISIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1746,'G46100','VENTA AL POR MAYOR A CAMBIO DE UNA COMISIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1747,'G461001','INTERMEDIARIOS DEL COMERCIO DE MATERIAS PRIMAS AGRARIAS, ANIMALES VIVOS, MATERIAS PRIMAS TEXTILES Y PRODUCTOS SEMIELABORADOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1748,'G461002','INTERMEDIARIOS DEL COMERCIO DE COMBUSTIBLES, MINERALES, METALES, Y PRODUCTOS QUÍMICOS INDUSTRIALES, INCLUIDOS ABONOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1749,'G461003','INTERMEDIARIOS DEL COMERCIO DE LA MADERA Y MATERIALES DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1750,'G461004','INTERMEDIARIOS DEL COMERCIO DE MAQUINARIA, EQUIPO INDUSTRIAL, EMBARCACIONES Y AERONAVES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1751,'G461005','INTERMEDIARIOS DEL COMERCIO DE MUEBLES, ARTÍCULOS PARA EL HOGAR Y FERRETERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1752,'G461006','INTERMEDIARIOS DEL COMERCIO DE TEXTILES, PRENDAS DE VESTIR, PELETERÍA, CALZADO Y ARTÍCULOS DE CUERO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1753,'G461007','INTERMEDIARIOS DEL COMERCIO DE PRODUCTOS ALIMENTICIOS, BEBIDAS Y TABACO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1754,'G461008','ACTIVIDADES DE CASAS DE SUBASTAS AL POR MAYOR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1755,'G461009','INTERMEDIARIOS DEL COMERCIO DE PRODUCTOS DIVERSOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1756,'G462','VENTA AL POR MAYOR DE MATERIAS PRIMAS AGROPECUARIAS Y ANIMALES VIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1757,'G4620','VENTA AL POR MAYOR DE MATERIAS PRIMAS AGROPECUARIAS Y ANIMALES VIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1758,'G46201','VENTA AL POR MAYOR DE MATERIAS PRIMAS AGROPECUARIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1759,'G462011','VENTA AL POR MAYOR DE CEREALES (GRANOS) Y SEMILLAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1760,'G462012','VENTA AL POR MAYOR DE FRUTOS Y SEMILLAS OLEAGINOSAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1761,'G462013','VENTA AL POR MAYOR DE TABACO SIN ELABORAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (1762,'G462014','VENTA AL POR MAYOR DE DESECHOS, RESIDUOS Y PRODUCTOS DERIVADOS USADOS PARA ALIMENTAR ANIMALES (FORRAJE), INCLUYE MATERIAS PRIMAS AGRARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1763,'G462015','VENTA AL POR MAYOR DE FLORES Y PLANTAS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1764,'G462019','VENTA AL POR MAYOR DE OTRAS MATERIAS PRIMAS AGROPECUARIAS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1765,'G46202','VENTA AL POR MAYOR DE ANIMALES VIVOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1766,'G462021','VENTA AL POR MAYOR DE ANIMALES VIVOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1767,'G462022','VENTA AL POR MAYOR DE CUEROS, PIELES Y OTROS PRODUCTOS ANIMALES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1768,'G463','VENTA AL POR MAYOR DE ALIMENTOS, BEBIDAS Y TABACO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1769,'G4630','VENTA AL POR MAYOR DE ALIMENTOS, BEBIDAS Y TABACO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1770,'G46301','VENTA AL POR MAYOR DE FRUTAS, HORTALIZAS Y ESPECIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1771,'G463011','VENTA AL POR MAYOR DE BANANO Y PLÁTANO.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (1772,'G463012','VENTA AL POR MAYOR DE FRUTAS, LEGUMBRES Y HORTALIZAS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1773,'G463013','VENTA AL POR MAYOR DE PAPA Y TUBÉRCULOS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1774,'G463014','VENTA AL POR MAYOR DE CAFÉ, CACAO, TÉ Y ESPECIAS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1775,'G46302','VENTA AL POR MAYOR DE PRODUCTOS LÁCTEOS, HUEVOS, GRASAS Y ACEITES COMESTIBLES.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1776,'G463021','VENTA AL POR MAYOR DE PRODUCTOS LÁCTEOS, INCLUIDO HELADOS, BOLOS, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (1777,'G463022','VENTA AL POR MAYOR DE HUEVOS Y PRODUCTOS A BASE DE HUEVOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1778,'G463023','VENTA AL POR MAYOR DE ACEITES Y GRASAS COMESTIBLES DE ORIGEN ANIMAL O VEGETAL.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1779,'G46303','VENTA AL POR MAYOR DE CARNE, PRODUCTOS CÁRNICOS Y DE LA PESCA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1780,'G463031','VENTA AL POR MAYOR DE CARNE Y PRODUCTOS CÁRNICOS (INCLUIDAS LAS AVES DE CORRAL).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1781,'G463032','VENTA AL POR MAYOR DE CAMARÓN Y LANGOSTINOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1782,'G463033','VENTA AL POR MAYOR DE PESCADO, CRUSTÁCEOS, MOLUSCOS Y PRODUCTOS DE LA PESCA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1783,'G46309','VENTA AL POR MAYOR DE OTROS PRODUCTOS ALIMENTICIOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1784,'G463091','VENTA AL POR MAYOR DE ARROZ.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1785,'G463092','VENTA AL POR MAYOR DE AZÚCAR, CHOCOLATE Y PRODUCTOS DE CONFITERÍA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1786,'G463093','VENTA AL POR MAYOR DE PRODUCTOS DE PANADERÍA Y REPOSTERÍA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1787,'G463094','VENTA AL POR MAYOR DE BEBIDAS NO ALCOHÓLICAS (JUGOS, GASEOSAS, AGUA MINERAL, ETCÉTERA).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1788,'G463095','VENTA AL POR MAYOR DE BEBIDAS ALCOHÓLICAS, INCLUSO EL ENVASADO DE VINO A GRANEL SIN TRANSFORMACIÓN.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1789,'G463096','VENTA AL POR MAYOR DE PRODUCTOS DE TABACO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1790,'G463097','VENTA AL POR MAYOR DE ALIMENTO PARA MASCOTAS (ANIMALES DOMÉSTICOS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1791,'G463099','VENTA AL POR MAYOR DE OTROS PRODUCTOS COMESTIBLES (ENLATADOS Y CONSERVAS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1792,'G464','VENTA AL POR MAYOR DE ENSERES DOMÉSTICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1793,'G4641','VENTA AL POR MAYOR DE TEXTILES, PRENDAS DE VESTIR Y CALZADO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1794,'G46411','VENTA AL POR MAYOR DE TEXTILES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1795,'G464111','VENTA AL POR MAYOR DE HILOS (HILADOS), LANAS Y TEJIDOS (TELAS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1796,'G464112','VENTA AL POR MAYOR DE LENCERÍA PARA EL HOGAR CORTINAS, VISILLOS, MANTELERÍA, TOALLAS Y DIVERSOS ARTÍCULOS DOMÉSTICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1797,'G464113','VENTA AL POR MAYOR DE ARTÍCULOS DE MERCERÍAS: AGUJAS, HILO DE COSTURA, BOTONES, CIERRES, CINTAS, ENCAJES, ALFILERES, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1798,'G46412','VENTA AL POR MAYOR DE PRENDAS DE VESTIR Y ACCESORIOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1799,'G464121','VENTA AL POR MAYOR DE PRENDAS DE VESTIR, INCLUIDAS PRENDAS (ROPA) DEPORTIVAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1800,'G464122','VENTA AL POR MAYOR DE ACCESORIOS DE VESTIR GUANTES, CORBATAS, INCLUYE PARAGUAS Y TIRANTES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1801,'G46413','VENTA AL POR MAYOR DE CALZADO Y PELETERÍA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1802,'G464131','VENTA AL POR MAYOR DE CALZADO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1803,'G464132','VENTA AL POR MAYOR DE ARTÍCULOS DE CUERO (CON PELO NATURAL).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1804,'G4649','VENTA AL POR MAYOR DE OTROS ENSERES DOMÉSTICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1805,'G46491','VENTA AL POR MAYOR DE APARATOS ELECTRODOMÉSTICOS, MUEBLES, COLCHONES, ALFOMBRAS Y APARATOS DE ILUMINACIÓN PARA EL HOGAR.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1806,'G464911','VENTA AL POR MAYOR DE ELECTRODOMÉSTICOS Y APARATOS DE USO DOMÉSTICO: REFRIGERADORAS, COCINAS, LAVADORAS, ETCÉTERA. INCLUYE EQUIPOS DE TELEVISIÓN, ESTÉREOS (EQUIPOS DE SONIDO), EQUIPOS DE GRABACIÓN Y REPRODUCTORES DE CD Y DVD, CINTAS DE AUDIO Y VIDEO CDS, DVD GRABADAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1807,'G464912','VENTA AL POR MAYOR DE ARTÍCULOS Y ACCESORIOS FOTOGRÁFICOS Y ÓPTICOS (LENTES DE SOL, BINOCULARES, LUPAS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1808,'G464913','VENTA AL POR MAYOR DE MUEBLES DE HOGAR, COLCHONES Y ALFOMBRAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1809,'G464914','VENTA AL POR MAYOR DE EQUIPOS DE ILUMINACIÓN.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1810,'G46492','VENTA AL POR MAYOR DE PRODUCTOS DE FARMACÉUTICOS, MEDICINALES, MATERIALES MÉDICOS, PERFUMERÍA Y COSMÉTICA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1811,'G464921','VENTA AL POR MAYOR DE PRODUCTOS DE PERFUMERÍA, COSMÉTICOS (PRODUCTOS DE BELLEZA) ARTÍCULOS DE USO PERSONAL (JABONES).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1812,'G464922','VENTA AL POR MAYOR DE PRODUCTOS FARMACÉUTICOS, INCLUSO VETERINARIOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1813,'G464923','VENTA AL POR MAYOR DE PRODUCTOS MEDICINALES (NATURISTAS).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1814,'G464924','VENTA AL POR MAYOR DE INSTRUMENTOS, MATERIALES MÉDICOS Y QUIRÚRGICOS, DENTALES Y ARTÍCULOS ORTOPÉDICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1815,'G46499','VENTA AL POR MAYOR DE OTROS ARTÍCULOS DE USO DOMÉSTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1816,'G464991','VENTA AL POR MAYOR DE ARTÍCULOS DE MADERA, CORCHO, MIMBRE ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1817,'G464992','VENTA AL POR MAYOR DE BICICLETAS, PARTES Y ACCESORIOS INCLUYEN LOS ARTÍCULOS DEPORTIVOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1818,'G464993','VENTA AL POR MAYOR DE MATERIAL DE PAPELERÍA, LIBROS, REVISTAS, PERIÓDICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1819,'G464994','VENTA AL POR MAYOR DE ARTÍCULOS DE CUERO Y ACCESORIOS DE VIAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (1820,'G464995','VENTA AL POR MAYOR DE ARTÍCULOS DE PORCELANA, CRISTALERÍA, PLÁSTICO, ETCÉTERA; ARTÍCULOS ORNAMENTALES; CUBERTERÍA (CUBIERTOS), VAJILLA, INCLUIDO DESECHABLES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1821,'G464996','VENTA AL POR MAYOR DE ARTÍCULOS DE LIMPIEZA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1822,'G464997','VENTA AL POR MAYOR DE RELOJES, JOYAS Y BISUTERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1823,'G464999','VENTA AL POR MAYOR DE OTROS ARTÍCULOS DE USO DOMESTICO: JUEGOS Y JUGUETES, INSTRUMENTOS MUSICALES Y PARTITURAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1824,'G465','VENTA AL POR MAYOR DE MAQUINARIAS EQUIPOS Y MATERIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1825,'G4651','VENTA AL POR MAYOR DE COMPUTADORAS, EQUIPO Y PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1826,'G46510','VENTA AL POR MAYOR DE COMPUTADORAS, EQUIPO Y PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1827,'G465101','VENTA AL POR MAYOR DE COMPUTADORAS Y EQUIPO PERIFÉRICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1828,'G465102','VENTA AL POR MAYOR DE PROGRAMAS INFORMÁTICOS (SOFTWARE).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1829,'G4652','VENTA AL POR MAYOR DE EQUIPO, PARTES Y PIEZAS ELECTRÓNICOS Y DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1830,'G46520','VENTA AL POR MAYOR DE EQUIPO, PARTES Y PIEZAS ELECTRÓNICOS Y DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1831,'G465201','VENTA AL POR MAYOR DE VÁLVULAS Y TUBOS ELECTRÓNICOS, DISPOSITIVOS DE SEMICONDUCTORES, MICROCHIPS, CIRCUITOS INTEGRADOS Y DE IMPRESIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1832,'G465202','VENTA AL POR MAYOR DE TELÉFONOS Y EQUIPOS DE COMUNICACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1833,'G465203','VENTA AL POR MAYOR DE CINTAS Y DISQUETES Y DISCOS MAGNÉTICOS Y ÓPTICOS (CD, DVD) DE SONIDO Y DE VÍDEO NO GRABADAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1834,'G4653','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO Y MATERIALES AGROPECUARIOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1835,'G46530','VENTA AL POR MAYOR DE MAQUINARIA, EQUIPO Y MATERIALES AGROPECUARIOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1836,'G465301','VENTA AL POR MAYOR DE MAQUINARIA Y EQUIPO AGROPECUARIOS: ARADOS, ESPARCIDORAS DE ESTIÉRCOL, SEMBRADORAS, COSECHADORAS, TRILLADORAS, MÁQUINAS DE ORDEÑAR, MÁQUINAS UTILIZADAS EN LA AVICULTURA Y LA APICULTURA, TRACTORES UTILIZADOS EN ACTIVIDADES AGROPECUARIAS Y SILVÍCOLAS, SEGADORAS DE CÉSPED DE TODO TIPO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1837,'G4659','VENTA AL POR MAYOR DE OTROS TIPOS DE MAQUINARIA Y EQUIPO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1838,'G46591','VENTA AL POR MAYOR DE MAQUINARIA Y EQUIPO DE OFICINA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1839,'G465911','VENTA AL POR MAYOR DE MAQUINARIA Y EQUIPO DE OFICINA: CALCULADORA, MÁQUINAS DE ESCRIBIR, CONTADORA DE MONEDAS, EXCEPTO COMPUTADORAS Y EQUIPO INFORMÁTICO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1840,'G465912','VENTA AL POR MAYOR DE MUEBLES DE OFICINA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1841,'G46592','VENTA AL POR MAYOR DE MAQUINARIA PARA USO EN LA INDUSTRIA TEXTIL Y OTRAS INDUSTRIAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1842,'G465921','VENTA AL POR MAYOR DE MÁQUINAS HERRAMIENTA CONTROLADAS O NO POR COMPUTADORA PARA LA INDUSTRIA TEXTIL, CUERO Y OTRAS INDUSTRIAS, INCLUYE LA VENTA AL POR MAYOR DE SUS PARTES Y PIEZAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1843,'G465922','VENTA AL POR MAYOR DE MAQUINARÍA PARA LA MINERÍA Y CONSTRUCCIÓN; INCLUYE PARTES Y PIEZAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1844,'G465923','VENTA AL POR MAYOR DE MÁQUINAS Y HERRAMIENTAS PARA LA METALURGIA; INCLUYE PARTES Y PIEZAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1845,'G465924','VENTA AL POR MAYOR DE MÁQUINAS PARA LA ELABORACIÓN DE ALIMENTOS, BEBIDAS Y TABACO (INCLUSO PARA HOTELES Y RESTAURANTES), MÁQUINAS PARA LAVAR, SECAR Y SELLAR BOTELLAS, INCLUYE LA VENTA AL POR MAYOR DE SUS PARTES Y PIEZAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1846,'G46599','VENTA AL POR MAYOR DE OTRA MAQUINARIA Y EQUIPO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1847,'G465991','VENTA AL POR MAYOR DE EQUIPO DE TRANSPORTE (LANCHAS, AVIONES, TRENES, ETCÉTERA.) EXCEPTO VEHÍCULOS MOTORIZADOS, MOTOCICLETAS Y BICICLETAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1848,'G465992','VENTA AL POR MAYOR DE INSTRUMENTOS Y EQUIPO DE MEDICIÓN Y PRECISIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1849,'G465993','VENTA AL POR MAYOR DE EQUIPO ELÉCTRICO COMO: MOTORES ELÉCTRICOS, TRANSFORMADORES, (INCLUYE BOMBAS PARA LÍQUIDOS),  CABLES, CONMUTADORES Y DE OTROS TIPOS DE EQUIPO DE INSTALACIÓN DE USO INDUSTRIAL.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1850,'G465994','VENTA AL POR MAYOR DE EQUIPO MÉDICO Y EQUIPO DE LABORATORIO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1851,'G465995','VENTA AL POR MAYOR DE EQUIPO DE SEGURIDAD.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1852,'G465999','VENTA AL POR MAYOR DE MÁQUINAS HERRAMIENTA DE CUALQUIER TIPO Y PARA CUALQUIER MATERIAL: MADERA, ACERO, ETCÉTERA. LA VENTA DE OTROS TIPOS DE MAQUINARIA N.C.P. PARA USO EN LA INDUSTRIA, EL COMERCIO, LA NAVEGACIÓN Y OTROS SERVICIOS. INCLUYE VENTA AL POR MAYOR DE ROBOTS PARA CADENAS DE MONTAJE, ARMAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1853,'G466','OTRAS ACTIVIDADES DE VENTA AL POR MAYOR ESPECIALIZADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1854,'G4661','VENTA AL POR MAYOR DE COMBUSTIBLES SÓLIDOS, LÍQUIDOS Y GASEOSOS Y PRODUCTOS CONEXOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1855,'G46610','VENTA AL POR MAYOR DE COMBUSTIBLES SÓLIDOS, LÍQUIDOS Y GASEOSOS Y PRODUCTOS CONEXOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1856,'G466101','VENTA AL POR MAYOR DE PETRÓLEO CRUDO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1857,'G466102','VENTA AL POR MAYOR DE COMBUSTIBLES SÓLIDOS: CARBÓN, CARBÓN VEGETAL, LEÑA MADERA TURBA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1858,'G466103','VENTA AL POR MAYOR DE COMBUSTIBLES LÍQUIDOS NAFTA, GASOLINA, BIOCOMBUSTIBLE INCLUYE GRASAS, LUBRICANTES Y ACEITES, GASES LICUADOS DE PETRÓLEO, BUTANO Y PROPANO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1859,'G4662','VENTA AL POR MAYOR DE METALES Y MINERALES METALÍFEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1860,'G46620','VENTA AL POR MAYOR DE METALES Y MINERALES METALÍFEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1861,'G466201','VENTA AL POR MAYOR DE MINERALES METALÍFEROS FERROSOS Y NO FERROSOS; INCLUYE LA VENTA AL POR MAYOR DE METALES FERROSOS Y NO FERROSOS EN FORMAS PRIMARIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1862,'G466202','VENTA AL POR MAYOR DE PRODUCTOS SEMIACABADOS DE METALES FERROSOS Y NO FERROSOS N.C.P.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1863,'G466203','VENTA AL POR MAYOR DE ORO Y OTROS METALES PRECIOSOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1864,'G4663','VENTA AL POR MAYOR DE MATERIALES PARA LA CONSTRUCCIÓN, ARTÍCULOS DE FERRETERÍA, EQUIPO, MATERIALES DE FONTANERÍA (PLOMERÍA O GASFITERÍA) Y CALEFACCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1865,'G46631','VENTA AL POR MAYOR DE MADERA, MATERIALES DE CONSTRUCCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1866,'G466311','VENTA AL POR MAYOR DE MADERA NO TRABAJADA (EN BRUTO) Y PRODUCTOS DE LA ELABORACIÓN PRIMARIA DE MADERA: TABLEROS AGLOMERADOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1867,'G466312','VENTA AL POR MAYOR DE PINTURA, BARNICES Y LACAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1868,'G466313','VENTA AL POR MAYOR DE MATERIALES DE CONSTRUCCIÓN: PIEDRA, ARENA, GRAVA, CEMENTO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1869,'G466314','VENTA AL POR MAYOR DE PAPEL TAPIZ Y REVESTIMIENTO DE PISOS (BALDOSAS, LINÓLEO).','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1870,'G466315','VENTA AL POR MAYOR DE VIDRIO PLANO Y ESPEJOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1871,'G46632','VENTA AL POR MAYOR DE ARTÍCULOS DE FERRETERÍAS, FONTANERÍA (PLOMERÍA O GASFITERÍA) Y CALEFACCIÓN.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1872,'G466321','VENTA AL POR MAYOR DE ARTÍCULOS DE FERRETERÍAS Y CERRADURAS: MARTILLOS, SIERRAS, DESTORNILLADORES, Y OTRAS HERRAMIENTAS DE MANO, ACCESORIOS Y DISPOSITIVOS; CAJAS FUERTES, EXTINTORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1873,'G466322','VENTA AL POR MAYOR DE APARATOS, ACCESORIOS DE CALEFACCIÓN Y CALENTADORES DE AGUA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1874,'G466323','VENTA AL POR MAYOR DE EQUIPO SANITARIO Y FONTANERÍA (BAÑERAS, INODOROS, LAVABOS TOCADORES Y OTRA PORCELANA SANITARIA) INCLUYE ARTÍCULOS PARA LA INSTALACIÓN SANITARIA: TUBOS, TUBERÍAS, ACCESORIOS, GRIFOS, DERIVACIONES, CONEXIONES, TUBERÍAS DE CAUCHO, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1875,'G4669','VENTA AL POR MAYOR DE DESPERDICIOS, DESECHOS, CHATARRA Y OTROS PRODUCTOS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1876,'G46691','VENTA AL POR MAYOR DE PRODUCTOS QUÍMICOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1877,'G466911','VENTA AL POR MAYOR DE PRODUCTOS QUÍMICOS INDUSTRIALES: ANILINA, TINTA DE IMPRESIÓN, ACEITES ESENCIALES, GASES INDUSTRIALES (OXÍGENO), PEGAMENTO QUÍMICO, COLORANTES, RESINA SINTÉTICA, METANOL, PARAFINA, AROMATIZANTES Y POTENCIADORES DEL SABOR, SODA CÁUSTICA, SAL INDUSTRIAL, ÁCIDOS Y SULFUROS, DERIVADOS DE ALMIDÓN, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1878,'G466912','VENTA AL POR MAYOR DE ABONOS Y PRODUCTOS QUÍMICOS DE USO AGRÍCOLA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1879,'G46692','VENTA AL POR MAYOR DE PRODUCTOS SEMIELABORADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1880,'G466921','VENTA AL POR MAYOR DE MATERIALES PLÁSTICOS EN FORMAS PRIMARIAS, CAUCHO, FIBRAS TEXTILES, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1881,'G466922','VENTA AL POR MAYOR DEL PAPEL Y CARTÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1882,'G466923','VENTA AL POR MAYOR DE PIEDRAS PRECIOSAS, PRODUCTOS ABRASIVOS Y OTROS MINERALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1883,'G46693','VENTA AL POR MAYOR DE DESECHOS Y DESPERDICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1884,'G466930','VENTA AL POR MAYOR DE DESPERDICIOS Y DESECHOS, CHATARRA METÁLICA Y DE MATERIALES PARA EL RECICLADO, INCLUIDO LA RECOLECCIÓN, CLASIFICACIÓN,  SEPARACIÓN Y EL DESGUACE DE PRODUCTOS USADOS, COMO: AUTOMÓVILES, ORDENADORES, APARATOS DE TELEVISIÓN Y OTROS TIPOS DE EQUIPO, PARA OBTENER PARTES Y PIEZAS REUTILIZABLES. EL EMBALAJE Y REEMBALAJE, ALMACENAMIENTO Y ENTREGA, AUNQUE SIN UN PROCESO DE TRANSFORMACIÓN REAL. ADEMÁS, LOS MATERIALES COMPRADOS Y VENDIDOS TIENEN UN VALOR REMANENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1885,'G46694','VENTA AL POR MAYOR DE OTROS PRODUCTOS METÁLICOS ELABORADOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1886,'G466940','VENTA AL POR MAYOR DE OTROS PRODUCTOS METÁLICOS ELABORADOS, (EXCEPTO MAQUINARIA Y EQUIPO), EXCEPTO LOS PRESTADOS A COMISIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (1887,'G469','VENTA AL POR MAYOR DE OTROS PRODUCTOS NO ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1888,'G4690','VENTA AL POR MAYOR DE OTROS PRODUCTOS NO ESPECIALIZADO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (1889,'G46900','VENTA AL POR MAYOR NO ESPECIALIZADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1890,'G469000','VENTA AL POR MAYOR DE DIVERSOS PRODUCTOS SIN ESPECIALIZACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1891,'G47','COMERCIO AL POR MENOR, EXCEPTO EL DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1892,'G471','VENTA AL POR MENOR EN COMERCIOS NO ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1893,'G4711','VENTA AL POR MENOR EN COMERCIOS NO ESPECIALIZADOS CON PREDOMINIO DE LA VENTA DE ALIMENTOS, BEBIDAS O TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1894,'G47110','VENTA AL POR MENOR EN COMERCIOS NO ESPECIALIZADOS CON PREDOMINIO DE LA VENTA DE ALIMENTOS, BEBIDAS O TABACO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1895,'G471101','VENTA AL POR MENOR DE GRAN VARIEDAD DE PRODUCTOS EN TIENDAS, ENTRE LOS QUE PREDOMINAN, LOS PRODUCTOS ALIMENTICIOS, LAS BEBIDAS O EL TABACO, COMO PRODUCTOS DE PRIMERA NECESIDAD Y VARIOS OTROS TIPOS DE PRODUCTOS, COMO PRENDAS DE VESTIR, MUEBLES, APARATOS, ARTÍCULOS DE FERRETERÍA, COSMÉTICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1896,'G471102','VENTA AL POR MENOR DE GRAN VARIEDAD DE PRODUCTOS EN SUPERMERCADOS, ENTRE LOS QUE PREDOMINAN, LOS PRODUCTOS ALIMENTICIOS, LAS BEBIDAS O EL TABACO, COMO PRODUCTOS DE PRIMERA NECESIDAD Y VARIOS OTROS TIPOS DE PRODUCTOS, COMO PRENDAS DE VESTIR, MUEBLES, APARATOS, ARTÍCULOS DE FERRETERÍA, COSMÉTICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1897,'G4719','OTRAS ACTIVIDADES DE VENTA AL POR MENOR EN COMERCIOS NO ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1898,'G47190','OTRAS ACTIVIDADES DE VENTA AL POR MENOR EN COMERCIOS NO ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1899,'G471900','VENTA AL POR MENOR DE GRAN VARIEDAD DE PRODUCTOS ENTRE LOS QUE NO PREDOMINAN LOS PRODUCTOS ALIMENTICIOS, LAS BEBIDAS O EL TABACO, ACTIVIDADES DE VENTA DE: PRENDAS DE VESTIR, MUEBLES, APARATOS, ARTÍCULOS DE FERRETERÍA, COSMÉTICOS, ARTÍCULOS DE JOYERÍA Y BISUTERÍA, JUGUETES, ARTÍCULOS DE DEPORTE, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1900,'G472','VENTA AL POR MENOR DE ALIMENTOS, BEBIDAS Y TABACO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1901,'G4721','VENTA AL POR MENOR DE ALIMENTOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1902,'G47210','VENTA AL POR MENOR DE ALIMENTOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1903,'G472101','VENTA AL POR MENOR DE FRUTAS, LEGUMBRES Y HORTALIZAS FRESCAS O EN CONSERVA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1904,'G472102','VENTA AL POR MENOR DE LÁCTEOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1905,'G472103','VENTA AL POR MENOR DE HUEVOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1906,'G472104','VENTA AL POR MENOR DE PESCADO, CRUSTÁCEOS, MOLUSCOS Y PRODUCTOS DE LA PESCA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1907,'G472105','VENTA AL POR MENOR DE PRODUCTOS DE PANADERÍA, CONFITERÍA Y REPOSTERÍA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1908,'G472106','VENTA AL POR MENOR DE CARNE Y PRODUCTOS CÁRNICOS (INCLUIDOS LOS DE AVES DE CORRAL) EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1909,'G472109','VENTA AL POR MENOR DE OTROS PRODUCTOS ALIMENTICIOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1910,'G4722','VENTA AL POR MENOR DE BEBIDAS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1911,'G47220','VENTA AL POR MENOR DE BEBIDAS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1912,'G472201','VENTA AL POR MENOR DE BEBIDAS NO ALCOHÓLICAS (NO DESTINADAS AL CONSUMO EN EL LUGAR DE VENTA) EN ESTABLECIMIENTOS ESPECIALIZADOS, BOLOS, HELADOS, HIELO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1913,'G472202','VENTA AL POR MENOR DE BEBIDAS ALCOHÓLICAS (NO DESTINADAS AL CONSUMO EN EL LUGAR DE VENTA) EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1914,'G4723','VENTA AL POR MENOR DE TABACO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1915,'G47230','VENTA AL POR MENOR DE TABACO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1916,'G472300','VENTA AL POR MENOR DE TABACO Y PRODUCTOS DE TABACO EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1917,'G473','VENTA AL POR MENOR DE COMBUSTIBLES PARA VEHÍCULOS AUTOMOTORES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1918,'G4730','VENTA AL POR MENOR DE COMBUSTIBLES PARA VEHÍCULOS AUTOMOTORES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1919,'G47300','VENTA AL POR MENOR DE COMBUSTIBLE PARA VEHÍCULOS MOTORIZADOS Y MOTOCICLETAS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1920,'G473001','VENTA AL POR MENOR DE COMBUSTIBLES PARA VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1921,'G473002','VENTA AL POR MENOR DE PRODUCTOS LUBRICANTES Y REFRIGERANTES PARA VEHÍCULOS AUTOMOTORES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1922,'G474','VENTA AL POR MENOR DE EQUIPO DE INFORMACIÓN Y DE COMUNICACIONES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1923,'G4741','VENTA AL POR MENOR DE COMPUTADORES, EQUIPO PERIFÉRICO, PROGRAMAS INFORMÁTICOS Y EQUIPO DE TELECOMUNICACIONES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1924,'G47411','VENTA AL POR MENOR DE COMPUTADORES, EQUIPO DE TELECOMUNICACIÓN, EQUIPO PERIFÉRICO, PROGRAMAS INFORMÁTICOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1925,'G474111','VENTA AL POR MENOR DE COMPUTADORAS Y EQUIPO PERIFÉRICO COMPUTACIONAL EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1926,'G474112','VENTA AL POR MENOR DE PROGRAMAS INFORMÁTICOS NO PERSONALIZADOS, INCLUIDOS VIDEOJUEGOS, INCLUYE CONSOLAS DE VIDEOJUEGOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1927,'G474113','VENTA AL POR MENOR DE EQUIPOS DE TELECOMUNICACIONES: CELULARES, TUBOS ELECTRÓNICOS, ETCÉTERA. INCLUYE PARTES Y PIEZAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1928,'G4742','VENTA AL POR MENOR DE EQUIPO DE SONIDO Y VÍDEO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1929,'G47420','VENTA AL POR MENOR DE EQUIPO DE SONIDO Y VÍDEO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1930,'G474200','VENTA AL POR MENOR DE EQUIPOS DE: RADIO, TELEVISIÓN Y ESTEREOFÓNICOS, REPRODUCTORES Y GRABADORES DE CD Y DVD EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1931,'G475','VENTA AL POR MENOR DE OTROS ENSERES DOMÉSTICOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1932,'G4751','VENTA AL POR MENOR DE PRODUCTOS TEXTILES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1933,'G47510','VENTA AL POR MENOR DE PRODUCTOS TEXTILES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1934,'G475101','VENTA AL POR MENOR DE TELAS, LANAS Y OTROS HILADOS PARA TEJER, ARTÍCULOS DE MERCERÍA (AGUJAS E HILO DE COSER) EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1935,'G475102','VENTA AL POR MENOR DE ARTÍCULOS TEXTILES: SÁBANAS, TOALLAS, JUEGOS DE MESA Y OTROS ARTÍCULOS TEXTILES; MATERIALES BÁSICOS PARA HACER ALFOMBRAS, TAPICES O BORDADOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1936,'G4752','VENTA AL POR MENOR DE ARTÍCULOS DE FERRETERÍA, PINTURAS Y PRODUCTOS DE VIDRIO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1937,'G47520','VENTA AL POR MENOR DE ARTÍCULOS DE FERRETERÍA, PINTURAS Y PRODUCTOS DE VIDRIO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1938,'G475201','VENTA AL POR MENOR DE ARTÍCULOS DE FERRETERÍA: MARTILLOS, SIERRAS, DESTORNILLADORES Y PEQUEÑAS HERRAMIENTAS EN GENERAL, EQUIPO Y MATERIALES DE PREFABRICADOS PARA ARMADO CASERO (EQUIPO DE BRICOLAJE); ALAMBRES Y CABLES ELÉCTRICOS, CERRADURAS, MONTAJES Y ADORNOS, EXTINTORES, SEGADORAS DE CÉSPED DE CUALQUIER TIPO, ETCÉTERA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1939,'G475202','VENTA AL POR MENOR DE PINTURAS, BARNICES Y LACAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1940,'G475203','VENTA AL POR MENOR DE VIDRIO PLANO Y ESPEJOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1941,'G475204','VENTA AL POR MENOR DE MATERIALES DE CONSTRUCCIÓN COMO: LADRILLOS, RIPIO, CEMENTO, MADERA, ETCÉTERA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1942,'G475205','VENTA AL POR MENOR DE EQUIPO SANITARIO Y MATERIAL DE FONTANERÍA: CAÑERÍAS, CONEXIONES, TUBERÍAS DE CAUCHO, ACCESORIOS, GRIFOS Y MATERIAL DE CALEFACCIÓN Y CALEFONES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1943,'G475209','VENTA AL POR MENOR ESPECIALIZADA DE OTROS ARTÍCULOS DE FERRETERÍA: SAUNAS (BAÑOS DE CALOR SECO Y VAPOR), ARTÍCULOS DE PLÁSTICO Y DE CAUCHO, ETCÉTERA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1944,'G4753','VENTA AL POR MENOR DE TAPICES, ALFOMBRAS Y CUBRIMIENTOS PARA PAREDES Y PISOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1945,'G47530','VENTA AL POR MENOR DE TAPICES, ALFOMBRAS Y CUBRIMIENTOS PARA PAREDES Y PISOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1946,'G475301','VENTA AL POR MENOR DE ALFOMBRAS, TAPICES, MOQUETAS, CORTINAS, VISILLOS Y TAPETES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1947,'G475302','VENTA AL POR MENOR DE PAPEL TAPIZ Y REVESTIMIENTOS DE PISOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1948,'G4759','VENTA AL POR MENOR DE APARATOS ELÉCTRICOS DE USO DOMÉSTICO, MUEBLES, EQUIPO DE ILUMINACIÓN Y OTROS ENSERES DOMÉSTICOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1949,'G47590','VENTA AL POR MENOR DE MUEBLES, ARTÍCULOS Y EQUIPOS DE USO DOMÉSTICO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1950,'G475901','VENTA AL POR MENOR DE MUEBLES DE USO DOMÉSTICO, COLCHONES Y SOMIERES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1951,'G475902','VENTA AL POR MENOR DE ARTÍCULOS DE ILUMINACIÓN EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1952,'G475903','VENTA AL POR MENOR DE UTENSILIOS DE USO DOMÉSTICO, CUBIERTOS, VAJILLA, CRISTALERÍA, PLÁSTICOS Y OBJETOS DE PORCELANA Y DE CERÁMICA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1953,'G475904','VENTA AL POR MENOR DE ARTÍCULOS DE MADERA, DESECHABLES, CORCHO Y MIMBRE EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1954,'G475905','VENTA AL POR MENOR DE ELECTRODOMÉSTICOS EN ESTABLECIMIENTOS ESPECIALIZADOS: REFRIGERADORAS, COCINAS, MICROONDAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1955,'G475906','VENTA AL POR MENOR DE INSTRUMENTOS MUSICALES Y PARTITURAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1956,'G475909','VENTA AL POR MENOR DE OTROS ENSERES Y APARATOS DE USO DOMÉSTICO N.C.P. INCLUIDO SISTEMAS DE SEGURIDAD, COMO DISPOSITIVOS DE CIERRE, CAJAS DE CAUDALES, VIDRIOS BLINDADOS Y CAJAS FUERTES, SIN SERVICIO DE INSTALACIÓN NI DE MANTENIMIENTO EN ESTABLECIMIENTOS ESPECIALIZADOS','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1957,'G476','VENTA AL POR MENOR DE PRODUCTOS CULTURALES Y RECREATIVOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1958,'G4761','VENTA AL POR MENOR DE LIBROS, PERIÓDICOS Y ARTÍCULOS DE PAPELERÍA EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1959,'G47610','VENTA AL POR MENOR DE LIBROS, PERIÓDICOS Y ARTÍCULOS DE PAPELERÍA EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1960,'G476101','VENTA AL POR MENOR DE LIBROS DE TODO TIPO EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1961,'G476102','VENTA AL POR MENOR DE PERIÓDICOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1962,'G476103','VENTA AL POR MENOR DE ARTÍCULOS DE OFICINA Y PAPELERÍA COMO LÁPICES, BOLÍGRAFOS, PAPEL, ETCÉTERA, EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1963,'G4762','VENTA AL POR MENOR DE GRABACIONES DE MÚSICA Y DE VÍDEO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1964,'G47620','VENTA AL POR MENOR DE GRABACIONES DE MÚSICA Y DE VÍDEO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1965,'G476200','VENTA AL POR MENOR DE DISCOS DE VINILO, CINTAS MAGNETOFÓNICAS, DISCOS COMPACTOS Y CASETES DE MÚSICA, CINTAS DE VÍDEO Y DVD, CINTAS Y DISCOS EN BLANCO EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1966,'G4763','VENTA AL POR MENOR DE EQUIPO DE DEPORTE EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1967,'G47630','VENTA AL POR MENOR DE EQUIPO DE DEPORTE EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1968,'G476300','VENTA AL POR MENOR DE ARTÍCULOS DE DEPORTE, DE PESCA Y DE ACAMPADA, EMBARCACIONES Y BICICLETAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1969,'G4764','VENTA AL POR MENOR DE JUEGOS Y JUGUETES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1970,'G47640','VENTA AL POR MENOR DE JUEGOS Y JUGUETES EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1971,'G476400','VENTA AL POR MENOR DE JUEGOS Y JUGUETES DE TODOS LOS MATERIALES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1972,'G477','VENTA AL POR MENOR DE OTROS PRODUCTOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1973,'G4771','VENTA AL POR MENOR DE PRENDAS DE VESTIR, CALZADO Y ARTÍCULOS DE CUERO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1974,'G47711','VENTA AL POR MENOR DE PRENDAS DE VESTIR EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1975,'G477111','VENTA AL POR MENOR DE PRENDAS DE VESTIR Y PELETERÍA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1976,'G477112','VENTA AL POR MENOR DE ACCESORIOS DE VESTIR COMO: GUANTES, CORBATAS, TIRANTES, INCLUYE PARAGUAS ETC.. EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1977,'G47712','VENTA AL POR MENOR DE CALZADO Y ARTÍCULOS DE CUERO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1978,'G477121','VENTA AL POR MENOR DE CALZADO, MATERIAL DE ZAPATERÍA (PLANTILLAS, TALONERAS, SUELA Y ARTÍCULOS ANÁLOGOS) EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1979,'G477122','VENTA AL POR MENOR DE ARTÍCULOS DE CUERO Y SUSTITUTOS, INCLUIDO ACCESORIOS DE VIAJE, EXCEPTO PRENDAS DE VESTIR EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1980,'G4772','VENTA AL POR MENOR DE PRODUCTOS FARMACÉUTICOS Y MEDICINALES, COSMÉTICOS Y ARTÍCULOS DE TOCADOR EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1981,'G47720','VENTA AL POR MENOR DE PRODUCTOS FARMACÉUTICOS, MEDICINALES Y ORTOPÉDICOS, PERFUMES, COSMÉTICOS Y DE USO PERSONAL EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1982,'G477201','VENTA AL POR MENOR DE PRODUCTOS FARMACÉUTICOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1983,'G477202','VENTA AL POR MENOR DE PRODUCTOS NATURISTAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1984,'G477203','VENTA AL POR MENOR DE INSTRUMENTOS Y APARATOS MEDICINALES Y ORTOPÉDICOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1985,'G477204','VENTA AL POR MENOR DE PRODUCTOS VETERINARIOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1986,'G477205','VENTA AL POR MENOR DE PERFUMES, ARTÍCULOS COSMÉTICOS Y DE USO PERSONAL EN ESTABLECIMIENTOS ESPECIALIZADOS (PAÑALES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1987,'G4773','VENTA AL POR MENOR DE OTROS PRODUCTOS NUEVOS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1988,'G47731','VENTA AL POR MENOR DE EQUIPO FOTOGRÁFICO, ÓPTICO Y DE PRECISIÓN EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1989,'G477311','VENTA AL POR MENOR DE EQUIPO FOTOGRÁFICO Y DE PRECISIÓN, EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1990,'G477312','VENTA AL POR MENOR DE EQUIPO ÓPTICO Y ACTIVIDADES DE LAS ÓPTICAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (1991,'G47732','VENTA AL POR MENOR DE FLORES, PLANTAS, SEMILLAS, FERTILIZANTES, MASCOTAS Y ALIMENTO PARA MASCOTAS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1992,'G477321','VENTA AL POR MENOR DE FLORES, PLANTAS Y SEMILLAS EN ESTABLECIMIENTOS ESPECIALIZADOS, INCLUSO ARREGLOS FLORALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1993,'G477322','VENTA AL POR MENOR DE FERTILIZANTES, BALANCEADOS Y ABONOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1994,'G477323','VENTA AL POR MENOR DE MASCOTAS Y ALIMENTO PARA MASCOTAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1995,'G47739','VENTA AL POR MENOR DE OTRAS MERCANCÍAS EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1996,'G477391','VENTA AL POR MENOR DE RECUERDOS, SELLOS, MONEDAS, ARTÍCULOS RELIGIOSOS Y ARTESANÍA EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1997,'G477392','ACTIVIDADES DE GALERÍAS DE ARTE COMERCIALES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (1998,'G477393','VENTA AL POR MENOR DE FUEL, GAS EN BOMBONAS, CARBÓN Y LEÑA PARA USO DOMÉSTICO EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (1999,'G477394','VENTA AL POR MENOR DE RELOJES Y JOYAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2000,'G477395','VENTA AL POR MENOR DE RECARGAS Y TARJETAS ELECTRÓNICAS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2001,'G477396','VENTA AL POR MENOR DE PRODUCTOS PARA FIESTAS INFANTILES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2002,'G477399','VENTA AL POR MENOR DE PRODUCTOS NO ALIMENTICIOS N.C.P.: MATERIALES DE LIMPIEZA, ARMAS Y MUNICIONES, ETCÉTERA, EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2003,'G4774','VENTA AL POR MENOR DE ARTÍCULOS DE SEGUNDA MANO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2004,'G47740','VENTA AL POR MENOR DE ARTÍCULOS DE SEGUNDA MANO EN COMERCIOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2005,'G477401','VENTA AL POR MENOR DE LIBROS DE SEGUNDA MANO EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2006,'G477402','VENTA AL POR MENOR DE ANTIGÜEDADES EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2007,'G477409','OTROS TIPOS DE ACTIVIDADES DE VENTA AL POR MENOR DE ARTÍCULOS DE SEGUNDA MANO, USADOS, INCLUIDAS ACTIVIDADES DE CASAS DE SUBASTAS DE ESTOS ARTÍCULOS EN ESTABLECIMIENTOS ESPECIALIZADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2008,'G478','VENTA AL POR MENOR EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2009,'G4781','VENTA AL POR MENOR DE ALIMENTOS, BEBIDAS Y TABACO EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2010,'G47810','VENTA AL POR MENOR DE ALIMENTOS, BEBIDAS Y TABACO EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2011,'G478100','VENTA AL POR MENOR DE ALIMENTOS, BEBIDAS Y PRODUCTOS DEL TABACO EN PUESTOS DE VENTA O MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2012,'G4782','VENTA AL POR MENOR DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CALZADO EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2013,'G47820','VENTA AL POR MENOR DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CALZADO EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2014,'G478200','VENTA AL POR MENOR DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CALZADO EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2015,'G4789','VENTA AL POR MENOR DE OTROS PRODUCTOS EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2016,'G47890','VENTA AL POR MENOR DE OTROS PRODUCTOS EN PUESTOS DE VENTA Y MERCADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2017,'G478900','VENTA AL POR MENOR DE OTROS ARTÍCULOS EN PUESTOS DE VENTA O MERCADO COMO: ALFOMBRAS, TAPICES, LIBROS, JUEGOS Y JUGUETES, APARATOS ELECTRODOMÉSTICOS GRABACIONES DE MÚSICA, VIDEO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2018,'G479','VENTA AL POR MENOR NO REALIZADA EN COMERCIOS, PUESTOS DE VENTA O MERCADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2019,'G4791','VENTA AL POR MENOR POR CORREO Y POR INTERNET.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2020,'G47910','VENTA AL POR MENOR DE CUALQUIER TIPO DE PRODUCTO POR CORRESPONDENCIA O INTERNET.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2021,'G479100','VENTA AL POR MENOR DE CUALQUIER TIPO DE PRODUCTO POR CORREO, POR INTERNET, INCLUIDO SUBASTAS POR INTERNET, CATÁLOGO, TELÉFONO, TELEVISIÓN Y ENVIÓ DE PRODUCTOS AL CLIENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2022,'G4799','OTRAS ACTIVIDADES DE VENTA AL POR MENOR NO REALIZADAS EN COMERCIOS, PUESTOS DE VENTA O MERCADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2023,'G47990','OTRAS ACTIVIDADES DE VENTA AL POR MENOR NO REALIZADAS EN COMERCIOS, PUESTOS DE VENTA O MERCADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2024,'G479901','VENTA AL POR MENOR DE CUALQUIER TIPO DE PRODUCTO NO REALIZADA EN ALMACENES NI PUESTOS DE MERCADO: VENTA DIRECTA O POR VENDEDORES A DOMICILIO INCLUIDO LA VENTA MEDIANTE MÁQUINAS EXPENDEDORAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2025,'G479902','VENTA AL POR MENOR POR COMISIONISTAS (NO DEPENDIENTES DE COMERCIOS); INCLUYE ACTIVIDADES DE CASAS DE SUBASTAS (AL POR MENOR).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2026,'G479903','VENTA DIRECTA DE COMBUSTIBLES (COMBUSTIBLE DE CALEFACCIÓN, LEÑA, ETCÉTERA) CON ENTREGA EN EL DOMICILIO DEL CLIENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2027,'H','TRANSPORTE Y ALMACENAMIENTO.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2028,'H49','TRANSPORTE POR VÍA TERRESTRE Y POR TUBERÍAS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2029,'H491','TRANSPORTE POR FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2030,'H4911','TRANSPORTE INTERURBANO DE PASAJEROS POR FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2031,'H49110','TRANSPORTE INTERURBANO DE PASAJEROS POR FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2032,'H491100','TRANSPORTE DE PASAJEROS POR FERROCARRILES INTERURBANOS, INCLUYE SERVICIOS DE COCHES CAMA Y COCHES RESTAURANTE INTEGRADOS EN LOS SERVICIOS DE LAS COMPAÑÍAS DE FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2033,'H4912','TRANSPORTE DE CARGA POR FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2034,'H49120','TRANSPORTE DE CARGA POR FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2035,'H491200','TRANSPORTE DE CARGA POR LÍNEAS PRINCIPALES Y SECUNDARIAS DE FERROCARRIL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2036,'H492','OTRAS ACTIVIDADES DE TRANSPORTE POR VÍA TERRESTRE.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (2037,'H4921','TRANSPORTE URBANO Y SUBURBANO DE PASAJEROS POR VÍA TERRESTRE.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2038,'H49210','TRANSPORTE URBANO Y SUBURBANO DE PASAJEROS POR VÍA TERRESTRE.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2039,'H492101','TRANSPORTE TERRESTRE DE PASAJEROS POR SISTEMAS DE TRANSPORTE URBANO QUE PUEDEN ABARCAR LÍNEAS DE AUTOBÚS, TRANVÍA, TROLEBÚS, METRO, FERROCARRIL ELEVADO, LÍNEAS DE TRANSPORTE ENTRE LA CIUDAD Y EL AEROPUERTO O LA ESTACIÓN ETCÉTERA. EL TRANSPORTE SE REALIZA POR RUTAS ESTABLECIDAS SIGUIENDO NORMALMENTE UN HORARIO FIJO, Y EL EMBARQUE Y DESEMBARQUE DE PASAJEROS EN PARADAS ESTABLECIDAS. INCLUYE LA EXPLOTACIÓN DE FUNICULARES, TELEFÉRICOS, ETCÉTERA, QUE FORMEN PARTE DEL SISTEMA DE TRANSPORTE URBANO.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2040,'H492102','TRANSPORTE TERRESTRE DE PASAJEROS POR SISTEMAS DE TRANSPORTE SUBURBANO, QUE PUEDEN ABARCAR LÍNEAS DE AUTOBÚS PROVINCIAL, PARROQUIAL ETCÉTERA. EL TRANSPORTE SE REALIZA POR RUTAS ESTABLECIDAS SIGUIENDO NORMALMENTE UN HORARIO FIJO, Y EL EMBARQUE Y DESEMBARQUE DE PASAJEROS EN PARADAS ESTABLECIDAS. INCLUYE LA EXPLOTACIÓN DE FUNICULARES, TELEFÉRICOS, ETCÉTERA, QUE FORMEN PARTE DEL SISTEMA DE TRANSPORTE SUBURBANO.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2041,'H4922','OTRAS ACTIVIDADES DE TRANSPORTE DE PASAJEROS POR VÍA TERRESTRE.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (2042,'H49220','OTRAS ACTIVIDADES DE TRANSPORTE DE PASAJEROS POR VÍA TERRESTRE.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (2043,'H492201','ACTIVIDADES DE TRANSPORTE DE PASAJEROS POR CARRETERA: SERVICIOS REGULARES DE AUTOBUSES DE LARGA DISTANCIA SERVICIOS DE VIAJES CONTRATADOS, EXCURSIONES Y OTROS SERVICIOS OCASIONALES DE TRANSPORTE EN AUTOBÚS, TRICIMOTOS, SERVICIOS DE ENLACE CON AEROPUERTOS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2044,'H492202','SERVICIOS DE TAXIS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2045,'H492203','SERVICIOS DE TELEFÉRICOS, FUNICULARES, TELESILLAS Y TELECABINAS, SI NO FORMAN PARTE DE SISTEMAS DE TRANSPORTE URBANO O SUBURBANO.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (2046,'H492204','ACTIVIDADES DE ALQUILER DE AUTOMÓVILES PRIVADOS CON CONDUCTOR.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2047,'H492205','SERVICIOS DE AUTOBUSES ESCOLARES Y AUTOBUSES PARA EL TRANSPORTE DE EMPLEADOS.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2048,'H492206','TRANSPORTE DE PASAJEROS EN VEHÍCULOS DE TRACCIÓN HUMANA O ANIMAL.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2049,'H4923','TRANSPORTE DE CARGA POR CARRETERA.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2050,'H49230','TRANSPORTE DE CARGA POR CARRETERA.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2051,'H492301','TODAS LAS ACTIVIDADES DE TRANSPORTE DE CARGA POR CARRETERA, INCLUIDO EN CAMIONETAS DE: TRONCOS, GANADO, TRANSPORTE REFRIGERADO, CARGA PESADA, CARGA A GRANEL, INCLUIDO EL TRANSPORTE EN CAMIONES CISTERNA, AUTOMÓVILES, DESPERDICIOS Y MATERIALES DE DESECHO, SIN RECOGIDA NI ELIMINACIÓN.','S',0.19,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.92,9.40,'A'),
	 (2052,'H492302','SERVICIO DE ALQUILER DE CAMIONES CON CONDUCTOR.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2053,'H492303','TRANSPORTE DE CARGA EN VEHÍCULOS DE TRACCIÓN ANIMAL O HUMANA.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2054,'H492304','SERVICIOS DE MUDANZAS DE MUEBLES.','N',0.00,'S',0.13,'S',0.58,'S',0.02,'N',0.00,0.73,7.40,'A'),
	 (2055,'H493','TRANSPORTE POR TUBERÍAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2056,'H4930','TRANSPORTE POR TUBERÍAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2057,'H49300','TRANSPORTE POR TUBERÍAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2058,'H493000','SERVICIO DE ESTACIONES DE BOMBEO, TRANSPORTE DE GASES, LÍQUIDOS, AGUA, LECHADA Y OTROS PRODUCTOS POR TUBERÍAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2059,'H50','TRANSPORTE POR VÍA ACUÁTICA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2060,'H501','TRANSPORTE MARÍTIMO Y DE CABOTAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2061,'H5011','TRANSPORTE DE PASAJEROS MARÍTIMO Y DE CABOTAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2062,'H50110','TRANSPORTE DE PASAJEROS MARÍTIMO Y DE CABOTAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2063,'H501101','TRANSPORTE MARÍTIMO Y DE CABOTAJE, REGULAR Y NO REGULAR, DE PASAJEROS; EXPLOTACIÓN DE EMBARCACIONES DE EXCURSIÓN, DE CRUCERO O DE TURISMO, EXPLOTACIÓN DE TRANSBORDADORES, TAXIS ACUÁTICAS, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2064,'H501102','ALQUILER DE EMBARCACIONES DE PLACER CON TRIPULACIÓN PARA EL TRANSPORTE MARÍTIMO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2065,'H5012','TRANSPORTE DE CARGA MARÍTIMO Y DE CABOTAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2066,'H50120','TRANSPORTE DE CARGA MARÍTIMO Y DE CABOTAJE.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2067,'H501201','TRANSPORTE MARÍTIMO Y DE CABOTAJE, REGULAR Y NO REGULAR, DE CARGA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2068,'H501202','TRANSPORTE DE BARCAZAS, PLATAFORMAS PETROLÍFERAS, ETC., REMOLCADAS O EMPUJADAS POR REMOLCADORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2069,'H501203','ALQUILER DE EMBARCACIONES CON TRIPULACIÓN PARA EL TRANSPORTE MARÍTIMO (INCLUIDO EL COSTERO) DE MERCANCÍAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2070,'H502','TRANSPORTE POR VÍAS DE NAVEGACIÓN INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2071,'H5021','TRANSPORTE DE PASAJEROS POR VÍAS DE NAVEGACIÓN INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2072,'H50210','TRANSPORTE DE PASAJEROS POR VÍAS DE NAVEGACIÓN INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2073,'H502101','TRANSPORTE DE PASAJEROS POR RÍOS, CANALES, LAGOS Y OTRAS VÍAS DE NAVEGACIÓN INTERIORES, INCLUIDOS PUERTOS INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2074,'H502102','ALQUILER DE EMBARCACIONES DE PLACER CON TRIPULACIÓN PARA EL TRANSPORTE POR VÍAS DE NAVEGACIÓN INTERIORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2075,'H5022','TRANSPORTE DE CARGA, POR VÍAS DE NAVEGACIÓN INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2076,'H50220','TRANSPORTE DE CARGA, POR VÍAS DE NAVEGACIÓN INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2077,'H502201','TRANSPORTE DE CARGA POR RÍOS, CANALES, LAGOS Y OTRAS VÍAS DE NAVEGACIÓN INTERIORES, INCLUIDOS PUERTOS INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2078,'H502202','ALQUILER DE EMBARCACIONES CON TRIPULACIÓN PARA EL TRANSPORTE DE MERCANCÍAS POR: RÍOS, CANALES, LAGOS Y OTRAS VÍAS DE NAVEGACIÓN INTERIORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2079,'H51','TRANSPORTE POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2080,'H511','TRANSPORTE DE PASAJEROS POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2081,'H5110','TRANSPORTE DE PASAJEROS POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2082,'H51100','TRANSPORTE DE PASAJEROS POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2083,'H511001','TRANSPORTE AÉREO DE PASAJEROS CON ITINERARIOS Y HORARIOS ESTABLECIDOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2084,'H511002','VUELOS PANORÁMICOS Y TURÍSTICOS INCLUYE ACTIVIDADES GENERALES DE AVIACIÓN, COMO: TRANSPORTE DE PASAJEROS POR CLUBES AÉREOS CON FINES DE INSTRUCCIÓN O DE RECREO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2085,'H511003','ALQUILER DE EQUIPO DE TRANSPORTE AÉREO CON OPERADORES PARA EL TRANSPORTE DE PASAJEROS, VUELOS CONTRATADOS (CHÁRTER) PARA PASAJEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2086,'H512','TRANSPORTE DE CARGA POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2087,'H5120','TRANSPORTE DE CARGA POR VÍA AÉREA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2088,'H51200','TRANSPORTE DE CARGA POR VÍA AÉREA Y ESPACIAL.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2089,'H512001','TRANSPORTE AÉREO DE CARGA CON ITINERARIOS Y HORARIOS ESTABLECIDOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2090,'H512002','ALQUILER DE EQUIPO DE TRANSPORTE AÉREO CON OPERADORES PARA EL TRANSPORTE DE CARGA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2091,'H512003','TRANSPORTE ESPACIAL Y LANZAMIENTO DE SATÉLITES Y VEHÍCULOS ESPACIALES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.79,8.10,'A'),
	 (2092,'H52','ALMACENAMIENTO Y ACTIVIDADES DE APOYO AL TRANSPORTE.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2093,'H521','ALMACENAMIENTO Y DEPÓSITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2094,'H5210','ALMACENAMIENTO Y DEPÓSITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2095,'H52100','ALMACENAMIENTO Y DEPÓSITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2096,'H521000','ACTIVIDADES DE ALMACENAMIENTO Y DEPÓSITO PARA TODO TIPO DE PRODUCTOS: EXPLOTACIÓN DE SILOS DE GRANOS, ALMACENES PARA MERCANCÍAS DIVERSAS, CÁMARAS FRIGORÍFICAS, TANQUES DE ALMACENAMIENTO, ETCÉTERA. INCLUYE LA CONGELACIÓN POR CORRIENTE DE AIRE, ALMACENAMIENTO DE PRODUCTOS EN ZONAS FRANCAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2097,'H522','ACTIVIDADES DE APOYO AL TRANSPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2098,'H5221','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE TERRESTRE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2099,'H52210','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE TERRESTRE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2100,'H522101','ACTIVIDADES RELACIONADAS CON EL TRANSPORTE TERRESTRE DE PASAJEROS, ANIMALES O CARGA: EXPLOTACIÓN DE TERMINALES, ESTACIONES FERROVIARIAS, DE AUTOBUSES, DE MANIPULACIÓN DE MERCANCÍAS; OPERACIÓN DE INFRAESTRUCTURA DE TRANSPORTE FERROVIARIO SU REPARACIÓN Y MANTENIMIENTO (LIMPIEZA EXTERIOR DE LAS UNIDADES, MANTENIMIENTO DE VÍAS Y DE EQUIPOS, INSTALACIÓN Y MANTENIMIENTO ELECTROMECÁNICO DE MAQUINARIA Y CONDUCCIÓN DE LÍNEAS), OPERACIONES DE CAMBIO DE VÍAS O DE AGUJAS','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2101,'H522102','ACTIVIDADES RELACIONADAS CON ADMINISTRACIÓN Y OPERACIONES DE SERVICIOS DE: CARRETERAS, PUENTES, TÚNELES, APARCAMIENTOS O GARAJES, APARCAMIENTOS PARA BICICLETAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2102,'H522103','ACTIVIDADES DE REMOLQUE Y ASISTENCIA EN CARRETERAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2103,'H522104','ACTIVIDADES DE LICUEFACCIÓN DE GAS PARA FACILITAR SU TRANSPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2104,'H5222','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE ACUÁTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2105,'H52220','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE ACUÁTICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2106,'H522200','ACTIVIDADES RELACIONADAS CON EL TRANSPORTE ACUÁTICO DE PASAJEROS, ANIMALES O CARGA: EXPLOTACIÓN DE INSTALACIONES TERMINALES, COMO PUERTOS Y MALECONES, EXPLOTACIÓN DE EXCLUSAS DE VÍAS DE NAVEGACIÓN INTERIORES, ETCÉTERA, ACTIVIDADES DE NAVEGACIÓN, PRACTICAJE Y ATRACADA, ACTIVIDADES DE GABARRAJE Y SALVAMENTO, INCLUYE ACTIVIDADES DE FAROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2107,'H5223','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE AÉREO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2108,'H52230','ACTIVIDADES DE SERVICIOS VINCULADAS AL TRANSPORTE AÉREO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2109,'H522301','ACTIVIDADES RELACIONADAS CON EL TRANSPORTE AÉREO DE PASAJEROS, ANIMALES O CARGA: EXPLOTACIÓN DE INSTALACIONES TERMINALES, COMO TERMINALES AÉREAS, ETC. ACTIVIDADES AEROPORTUARIAS Y DE CONTROL DE TRÁFICO AÉREO. ACTIVIDADES DE SERVICIO EN TIERRA REALIZADAS EN AEROPUERTOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2110,'H522302','SERVICIOS DE PREVENCIÓN Y EXTINCIÓN DE INCENDIOS EN LOS AEROPUERTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2111,'H5224','MANIPULACIÓN DE CARGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2112,'H52240','MANIPULACIÓN DE MERCANCÍAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2113,'H522400','CARGA Y DESCARGA DE MERCANCÍAS Y EQUIPAJE, INDEPENDIENTEMENTE DEL MODO DE TRANSPORTE UTILIZADO, ESTIBA Y DESESTIBA, INCLUYE CARGA Y DESCARGA DE VAGONES FERROVIARIOS DE CARGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2114,'H5229','OTRAS ACTIVIDADES DE APOYO AL TRANSPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2115,'H52290','OTRAS ACTIVIDADES DE APOYO AL TRANSPORTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2116,'H522901','SERVICIOS TRANSITORIOS DE ORGANIZACIÓN O COORDINACIÓN DE OPERACIONES DE TRANSPORTE Y FLETE POR TIERRA, MAR Y AIRE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2117,'H522902','ACTIVIDADES LOGÍSTICAS: PLANIFICACIÓN, DISEÑO Y APOYO DE OPERACIONES DE TRANSPORTE, ALMACENAMIENTO Y DISTRIBUCIÓN; CONTRATACIÓN DE ESPACIO EN BUQUES Y AERONAVES, ORGANIZACIÓN DE ENVÍOS DE GRUPO E INDIVIDUALES (INCLUIDAS LA RECOGIDA Y ENTREGA DE MERCANCÍAS Y LA AGRUPACIÓN DE ENVÍOS); MANIPULACIÓN DE MERCANCÍAS, COMO: EL EMBALAJE TEMPORAL CON LA EXCLUSIVA FINALIDAD DE PROTEGER LAS MERCANCÍAS DURANTE EL TRÁNSITO, DESEMBALAJE, MUESTREO Y PESAJE DE LA CARGA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2118,'H522903','ACTIVIDADES DE AGENTES DE ADUANAS; EMISIÓN Y TRAMITACIÓN DE DOCUMENTOS DE TRANSPORTE Y CONOCIMIENTOS DE EMBARQUE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'S',0.08,0.66,6.80,'M'),
	 (2119,'H53','ACTIVIDADES POSTALES Y DE MENSAJERÍA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2120,'H531','ACTIVIDADES POSTALES Y DE MENSAJERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2121,'H5310','ACTIVIDADES POSTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2122,'H53100','ACTIVIDADES POSTALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2123,'H531000','SERVICIOS DE RECOLECCIÓN DE CORRESPONDENCIA Y PAQUETES DEPOSITADOS EN BUZONES PÚBLICOS O EN OFICINAS DE CORREOS, INCLUYE LA DISTRIBUCIÓN Y ENTREGA DE CORRESPONDENCIA Y PAQUETES. LA ACTIVIDAD PUEDE REALIZARSE EN UNO O VARIOS MEDIOS DE TRANSPORTE PROPIOS (TRANSPORTE PRIVADO) O DE TRANSPORTE PÚBLICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2124,'H532','ACTIVIDADES DE MENSAJERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2125,'H5320','ACTIVIDADES DE MENSAJERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2126,'H53200','ACTIVIDADES DE MENSAJERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2127,'H532000','SERVICIOS DE RECOLECCIÓN, CLASIFICACIÓN, TRANSPORTE Y ENTREGA (NACIONAL O INTERNACIONAL) DE CORRESPONDENCIA ORDINARIA Y PAQUETES (QUE CUMPLAN DETERMINADAS ESPECIFICACIONES) POR PARTE DE EMPRESAS NO SUJETAS A LA OBLIGACIÓN DE SERVICIO UNIVERSAL. LA ACTIVIDAD PUEDE REALIZARSE EN UNO O VARIOS MEDIOS DE TRANSPORTE PROPIOS (TRANSPORTE PRIVADO) O DE TRANSPORTE PÚBLICO. INCLUYE LA DISTRIBUCIÓN Y ENTREGA DE CORRESPONDENCIA Y PAQUETES Y LA ENTREGA A DOMICILIO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2128,'I','ACTIVIDADES DE ALOJAMIENTO Y DE SERVICIO DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2129,'I55','ACTIVIDADES DE ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2130,'I551','ACTIVIDADES DE ALOJAMIENTO PARA ESTANCIAS CORTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2131,'I5510','ACTIVIDADES DE ALOJAMIENTO PARA ESTANCIAS CORTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2132,'I55100','HOTELES Y ALOJAMIENTOS TURÍSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2133,'I551001','SERVICIOS DE ALOJAMIENTO PRESTADOS POR HOTELES, HOTELES DE SUITES, APART HOTELES, COMPLEJOS TURÍSTICOS, HOSTERÍAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2134,'I551002','SERVICIOS DE ALOJAMIENTO PRESTADOS POR MOTELES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2135,'I551009','OTROS SERVICIOS DE ALOJAMIENTOS POR CORTO TIEMPO: CASAS DE HUÉSPEDES; CABAÑAS, CHALETS, CABAÑAS CON SERVICIO DE MANTENIMIENTO Y LIMPIEZA, HOSTALES JUVENILES Y REFUGIOS DE MONTAÑA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2136,'I552','ACTIVIDADES DE CAMPAMENTOS, PARQUES DE VEHÍCULOS DE RECREO Y PARQUES DE CARAVANAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2137,'I5520','ACTIVIDADES DE CAMPAMENTOS, PARQUES DE VEHÍCULOS DE RECREO Y PARQUES DE CARAVANAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2138,'I55200','ACTIVIDADES DE CAMPAMENTOS, PARQUES DE VEHÍCULOS DE RECREO Y PARQUES DE CARAVANAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2139,'I552000','PROVISIÓN DE ALOJAMIENTO EN CAMPAMENTOS, PARQUES PARA CARAVANAS, CAMPAMENTOS RECREATIVOS Y CAMPAMENTOS DE CAZA Y DE PESCA PARA ESTANCIAS CORTAS. ESPACIO E INSTALACIONES PARA VEHÍCULOS DE RECREO. SE INCLUYE REFUGIOS O SIMPLES INSTALACIONES DE ACAMPADA PARA PLANTAR TIENDAS O PERNOCTAR EN SACOS DE DORMIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2140,'I559','OTRAS ACTIVIDADES DE ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2141,'I5590','OTRAS ACTIVIDADES DE ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2142,'I55900','OTRAS ACTIVIDADES DE ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2143,'I559001','SERVICIO DE RESIDENCIAS DE ESTUDIANTES, DORMITORIOS ESCOLARES, ALBERGUES PARA TRABAJADORES, CASAS DE HUÉSPEDES E INTERNADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2144,'I559002','SERVICIOS DE COCHES CAMA FERROVIARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2145,'I56','SERVICIO DE ALIMENTO Y BEBIDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2146,'I561','ACTIVIDADES DE RESTAURANTES Y DE SERVICIO MÓVIL DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2147,'I5610','ACTIVIDADES DE RESTAURANTES Y DE SERVICIO MÓVIL DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2148,'I56100','RESTAURANTES Y SERVICIOS MÓVIL DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2149,'I561001','RESTAURANTES, CEVICHERÍAS, PICANTERÍAS, CAFETERÍAS, ETCÉTERA, INCLUIDO COMIDA PARA LLEVAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2150,'I561002','RESTAURANTES DE COMIDA RÁPIDA, PUESTOS DE REFRIGERIO Y ESTABLECIMIENTOS QUE OFRECEN COMIDA PARA LLEVAR, REPARTO DE PIZZA, ETCÉTERA; HELADERÍAS, FUENTES DE SODA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2151,'I561003','PREPARACIÓN Y SUMINISTRO DE COMIDAS PARA SU CONSUMO INMEDIATO DE MANERA AMBULANTE, MEDIANTE UN VEHÍCULO MOTORIZADO O CARRO NO MOTORIZADO, VENDEDORES DE HELADOS EN CARROS MÓVILES, CARRITOS AMBULANTES DE COMIDA INCLUYE LA PREPARACIÓN DE COMIDA EN PUESTOS DE MERCADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2152,'I561004','SERVICIOS DE RESTAURANTES Y BARES EN CONEXIÓN CON TRANSPORTE CUANDO SON PROPORCIONADAS POR UNIDADES INDEPENDIENTES: BARES DEL AEROPUERTO, BARES TERMINALES TERRESTRES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2153,'I562','SUMINISTRO DE COMIDAS POR ENCARGO Y OTRAS ACTIVIDADES DE SERVICIO DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2154,'I5621','SUMINISTRO DE COMIDAS POR ENCARGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2155,'I56210','SUMINISTRO DE COMIDAS POR ENCARGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2156,'I562100','SERVICIO DE COMIDAS BASADO EN ACUERDOS CONTRACTUALES CON EL CLIENTE PARA UN EVENTO (BANQUETES, BODAS, FIESTAS Y OTRAS CELEBRACIONES, BUFFET) EN LA LOCALIZACIÓN ESPECIFICADA POR EL CLIENTE (ABASTECEDORES DE EVENTOS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2157,'I5629','OTRAS ACTIVIDADES DE SERVICIO DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2158,'I56290','OTRAS ACTIVIDADES DE SERVICIO DE COMIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2159,'I562901','ACTIVIDADES DE CONTRATISTAS DE SERVICIO DE COMIDAS (POR EJEMPLO, PARA COMPAÑIAS DE TRANSPORTE CATERING).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2160,'I562902','SERVICIOS DE CONCESIONES DE SERVICIO DE COMIDAS EN INSTALACIONES DEPORTIVAS E INSTALACIONES SIMILARES, CANTINAS O CAFETERÍAS (POR EJEMPLO, PARA FÁBRICAS, OFICINAS, HOSPITALES O ESCUELAS) EN RÉGIMEN DE CONCESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2161,'I563','ACTIVIDADES DE SERVICIO DE BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2162,'I5630','ACTIVIDADES DE SERVICIO DE BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2163,'I56300','ACTIVIDADES DE SERVICIO DE BEBIDAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2164,'I563001','ACTIVIDADES DE PREPARACIÓN Y SERVICIO DE BEBIDAS PARA SU CONSUMO INMEDIATO EN: BARES, TABERNAS, COCTELERÍAS, DISCOTECAS (CON SUMINISTRO PREDOMINANTE DE BEBIDAS) CERVECERÍAS Y PUBS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2165,'I563002','ACTIVIDADES DE PREPARACIÓN Y SERVICIO DE BEBIDAS PARA SU CONSUMO INMEDIATO EN: CAFÉS, TIENDAS DE JUGOS DE FRUTA, VENDEDORES AMBULANTES DE BEBIDAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2166,'I56901','ACTIVIDADES DE CONTRATISTAS DE SERVICIO DE COMIDAS (POR EJEMPLO, PARA COMPAÑÍAS DE TRANSPORTE CATERING).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2167,'J','INFORMACIÓN Y COMUNICACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2168,'J58','ACTIVIDADES DE PUBLICACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2169,'J581','PUBLICACIÓN DE LIBROS, PERIÓDICOS Y OTRAS ACTIVIDADES DE PUBLICACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2170,'J5811','PUBLICACIÓN DE LIBROS, PERIÓDICOS Y OTRAS ACTIVIDADES DE PUBLICACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2171,'J58110','PUBLICACIÓN DE LIBROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2172,'J581101','PUBLICACIÓN DE LIBROS, FOLLETOS IMPRESOS, DICCIONARIOS, ENCICLOPEDIAS Y SIMILARES, ATLAS, MAPAS Y PLANOS. INCLUYE LA VENTA DE ESPACIOS PUBLICITARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2173,'J581102','PUBLICACIÓN DE LIBROS EN FORMATO DE AUDIO Y DE ENCICLOPEDIAS EN CD-ROM.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2174,'J5812','PUBLICACIÓN DE DIRECTORIOS Y DE LISTAS DE CORREO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2175,'J58120','PUBLICACIÓN DE DIRECTORIOS Y DE LISTAS DE CORREO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2176,'J581200','PUBLICACIÓN DE: GUÍAS DE DIRECCIONES, POSTALES, GUÍAS TELEFÓNICAS, REGISTROS OFICIALES, JURISPRUDENCIA (LEY), VADEMÉCUM FARMACÉUTICOS, ETCÉTERA. INCLUYE VENTA DE ESPACIOS PUBLICITARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2177,'J5813','PUBLICACIÓN DE PERIÓDICOS, DIARIOS Y REVISTAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2178,'J58130','PUBLICACIÓN DE PERIÓDICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2179,'J581301','ACTIVIDADES DE PUBLICACIÓN Y EDICIÓN DE PERIÓDICOS, INCLUIDOS LOS PUBLICITARIOS CON UNA PERIODICIDAD MAYOR A CUATRO VECES POR SEMANA. ESTA INFORMACIÓN PUEDE SER EDITADA EN FORMATO IMPRESOS O ELECTRÓNICOS, INCLUIDO INTERNET.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2180,'J581302','ACTIVIDADES DE EDICIÓN Y PUBLICACIÓN DE LAS PROGRAMACIONES DE RADIO Y TELEVISIÓN. INCLUSO LA VENTA DE ESPACIOS PUBLICITARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2181,'J5819','OTRAS PUBLICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2182,'J58190','OTRAS ACTIVIDADES DE PUBLICACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2183,'J581901','PUBLICACIÓN (INCLUIDA LA EDICIÓN ON-LINE) DE CATÁLOGOS DE FOTOGRAFÍAS, GRABADOS, TARJETAS POSTALES, TARJETAS DE FELICITACIÓN, FORMULARIOS, CARTELES, REPRODUCCIONES DE OBRAS DE ARTE, PUBLICIDAD Y OTRO MATERIAL IMPRESO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2184,'J581902','PUBLICACIÓN DE ESTADÍSTICAS EN LÍNEA Y OTRA INFORMACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2185,'J582','PUBLICACIÓN DE PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2186,'J5820','PUBLICACIÓN DE PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2187,'J58200','PUBLICACIÓN DE PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2188,'J582000','ACTIVIDADES DE PUBLICACIÓN DE PROGRAMAS INFORMÁTICOS COMERCIALES (NO PERSONALIZADOS): SISTEMAS OPERATIVOS, APLICACIONES COMERCIALES Y OTRAS APLICACIONES, JUEGOS INFORMÁTICOS PARA TODAS LAS PLATAFORMAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2189,'J59','ACTIVIDADES DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN, GRABACIÓN DE SONIDO Y EDICIÓN DE MÚSICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2190,'J591','ACTIVIDADES DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2191,'J5911','ACTIVIDADES DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2192,'J59110','ACTIVIDADES DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2193,'J591100','ACTIVIDADES DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VIDEOS, PRODUCCIÓN PROGRAMAS Y ANUNCIOS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2194,'J5912','ACTIVIDADES DE POSTPRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2195,'J59120','ACTIVIDADES DE POSTPRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2196,'J591201','ACTIVIDADES DE POSTPRODUCCIÓN, COMO: EDICIÓN, ROTULACIÓN, SUBTITULADO, CRÉDITOS SUBTITULADOS PARA SORDOS, GRÁFICOS, ANIMACIÓN Y EFECTOS ESPECIALES PRODUCIDOS POR ORDENADOR, TRANSFERENCIA DE PELÍCULA A CINTA; ACTIVIDADES DE LABORATORIOS CINEMATOGRÁFICOS Y DE LABORATORIOS ESPECIALES PARA PELÍCULAS DE ANIMACIÓN, INCLUIDO EL REVELADO DE ESTAS CINTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2197,'J591202','ACTIVIDADES DE REPRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS PARA SU DISTRIBUCIÓN EN CINES. SE INCLUYEN ACTIVIDADES DE ARCHIVOS CINEMATOGRÁFICOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2198,'J5913','ACTIVIDADES DE DISTRIBUCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2199,'J59130','ACTIVIDADES DE DISTRIBUCIÓN DE PELÍCULAS CINEMATOGRÁFICAS, VÍDEOS Y PROGRAMAS DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2200,'J591300','ACTIVIDADES DE DISTRIBUCIÓN DE PELÍCULAS, CINTAS DE VÍDEO, DVD Y PRODUCTOS SIMILARES A CINES, CADENAS Y EMISORAS DE TELEVISIÓN Y EXHIBIDORES. SE INCLUYEN ADQUISICIÓN DE LOS DERECHOS DE DISTRIBUCIÓN DE PELÍCULAS, CINTAS DE VÍDEO Y DVD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2201,'J5914','ACTIVIDADES DE EXHIBICIÓN DE PELÍCULAS CINEMATOGRÁFICAS Y CINTAS DE VÍDEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2202,'J59140','ACTIVIDADES DE EXHIBICIÓN DE PELÍCULAS CINEMATOGRÁFICAS Y CINTAS DE VÍDEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2203,'J591400','PROYECCIÓN DE PELÍCULAS CINEMATOGRÁFICAS Y CINTAS DE VÍDEO EN CINES, AL AIRE LIBRE O EN OTROS LOCALES DE PROYECCIÓN Y ACTIVIDADES DE CINECLUBES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2204,'J592','ACTIVIDADES DE GRABACIÓN DE SONIDO Y EDICIÓN DE MÚSICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2205,'J5920','ACTIVIDADES DE GRABACIÓN DE SONIDO Y EDICIÓN DE MÚSICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2206,'J59200','ACTIVIDADES DE GRABACIÓN DE SONIDO Y EDICIÓN DE MÚSICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2207,'J592001','ACTIVIDADES DE PRODUCCIÓN DE GRABACIONES MATRICES ORIGINALES DE SONIDO, COMO CINTAS MAGNETOFÓNICAS, CD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2208,'J592002','LA PUBLICACIÓN, LANZAMIENTO, PROMOCIÓN Y DISTRIBUCIÓN DE GRABACIONES DE SONIDO PARA COMERCIANTES MAYORISTAS, MINORISTAS O DIRECTAMENTE PARA EL PÚBLICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2209,'J592003','ACTIVIDADES DE SERVICIOS DE GRABACIÓN DE SONIDO EN ESTUDIO O EN OTROS LUGARES, INCLUIDA LA PRODUCCIÓN DE PROGRAMAS DE RADIO GRABADOS (ES DECIR, NO EMITIDOS EN DIRECTO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2210,'J592004','ACTIVIDADES DE BANDAS SONORAS DE PELÍCULAS CINEMATOGRÁFICAS, GRABACIONES DE SONIDO PARA PROGRAMAS DE TELEVISIÓN, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2211,'J592005','EDICIÓN DE MÚSICA, ES DECIR, ACTIVIDADES DE: ADQUISICIÓN Y REGISTRO DE LOS DERECHOS DE AUTOR DE COMPOSICIONES MUSICALES, PROMOCIÓN, AUTORIZACIÓN Y UTILIZACIÓN DE ESAS COMPOSICIONES EN GRABACIONES, EN LA RADIO, EN LA TELEVISIÓN, EN PELÍCULAS, EN INTERPRETACIONES EN VIVO, EN MEDIOS IMPRESOS Y EN OTROS MEDIOS, DISTRIBUCIÓN DE GRABACIONES DE SONIDO A MAYORISTAS O MINORISTAS O DIRECTAMENTE AL PÚBLICO, INCLUYE LA EDICIÓN DE LIBROS DE MÚSICA Y PARTITURAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2212,'J60','ACTIVIDADES DE PROGRAMACIÓN Y TRANSMISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2213,'J601','TRANSMISIONES DE RADIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2214,'J6010','TRANSMISIONES DE RADIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2215,'J60100','TRANSMISIONES DE RADIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2216,'J601001','ACTIVIDADES DE EMISIÓN DE SEÑALES DE AUDIOFRECUENCIA A TRAVÉS DE ESTUDIOS E INSTALACIONES DE EMISIÓN DE RADIO PARA LA TRANSMISIÓN DE PROGRAMAS SONOROS AL PÚBLICO, A ENTIDADES AFILIADAS O A SUSCRIPTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2217,'J601002','ACTIVIDADES DE CADENAS DE RADIO, ES DECIR, LA REUNIÓN DE PROGRAMAS SONOROS Y SU TRANSMISIÓN A LOS AFILIADOS O SUSCRIPTORES POR EL AIRE, POR CABLE O POR SATÉLITE; TRANSMISIONES DE RADIO POR INTERNET (ESTACIONES DE RADIO POR INTERNET). INCLUYE LA TRANSMISIÓN DE DATOS INTEGRADA CON TRANSMISIONES DE RADIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2218,'J602','PROGRAMACIÓN Y TRANSMISIONES DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2219,'J6020','PROGRAMACIÓN Y TRANSMISIONES DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2220,'J60200','PROGRAMACIÓN Y TRANSMISIONES DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2221,'J602001','ACTIVIDADES DE CREACIÓN DEL PROGRAMA COMPLETO DE UNA CADENA DE TELEVISIÓN PARA UN CANAL, DESDE LA COMPRA DE LOS COMPONENTES DEL PROGRAMA (PELÍCULAS, DOCUMENTALES, ETCÉTERA.) HASTA LA PRODUCCIÓN PROPIA DE LOS COMPONENTES DEL PROGRAMA AUTO PRODUCIDOS (NOTICIAS LOCALES, REPORTAJES EN VIVO) O UNA COMBINACIÓN DE LAS DOS OPCIONES. EL PROGRAMA COMPLETO DE TELEVISIÓN PUEDE SER EMITIDO POR LAS UNIDADES DE PRODUCCIÓN O BIEN PRODUCIRSE PARA SU TRANSMISIÓN POR TERCEROS DISTRIBUIDORES, COMO COMPAÑÍAS DE EMISIÓN POR CABLE O PROVEEDORES DE TELEVISIÓN POR SATÉLITE, INCLUYE LA PROGRAMACIÓN DE CANALES DE VIDEO A LA CARTA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2222,'J602002','ACTIVIDADES DE TRANSMISIÓN DE DATOS INTEGRADOS CON EMISIONES DE TELEVISIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2223,'J61','TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2224,'J611','ACTIVIDADES DE TELECOMUNICACIONES ALÁMBRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2225,'J6110','ACTIVIDADES DE TELECOMUNICACIONES ALÁMBRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2226,'J61100','ACTIVIDADES DE TELECOMUNICACIONES ALÁMBRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2227,'J611001','ACTIVIDADES DE OPERACIÓN, MANTENIMIENTO O FACILITACIÓN DEL ACCESO A SERVICIOS DE TRANSMISIÓN DE VOZ, DATOS, TEXTO, SONIDO Y VÍDEO UTILIZANDO UNA INFRAESTRUCTURA DE TELECOMUNICACIONES ALAMBRICAS, COMO: OPERACIÓN Y MANTENIMIENTO DE SISTEMAS DE CONMUTACIÓN Y TRANSMISIÓN PARA SUMINISTRAR SERVICIOS DE COMUNICACIONES DE PUNTO A PUNTO POR LÍNEAS ALAMBRICAS, POR MICROONDAS O POR UNA COMBINACIÓN DE LÍNEAS ALAMBRICAS Y CONEXIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2228,'J611002','ACTIVIDADES DE OPERACIÓN EN SISTEMAS DE DISTRIBUCIÓN POR CABLE (POR EJEMPLO, PARA LA DISTRIBUCIÓN DE DATOS Y SEÑALES DE TELEVISIÓN).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2229,'J611003','ACTIVIDADES DE COMPRA EN DERECHOS DE ACCESO Y CAPACIDAD DE RED A LOS PROPIETARIOS Y OPERADORES DE REDES Y UTILIZACIÓN DE ESA CAPACIDAD PARA SUMINISTRAR SERVICIOS DE TELECOMUNICACIONES A EMPRESAS Y HOGARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2230,'J611004','ACTIVIDADES DE SUMINISTRO EN ACCESO A INTERNET POR LOS OPERADORES DE LA INFRAESTRUCTURA DE TELECOMUNICACIONES ALAMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2231,'J612','ACTIVIDADES DE TELECOMUNICACIONES INALÁMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2232,'J6120','ACTIVIDADES DE TELECOMUNICACIONES INALÁMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2233,'J61200','ACTIVIDADES DE TELECOMUNICACIONES INALÁMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2234,'J612001','OPERACIÓN, MANTENIMIENTO O FACILITACIÓN DEL ACCESO A SERVICIOS DE TRANSMISIÓN DE VOZ, DATOS, TEXTO, SONIDO Y VÍDEO UTILIZANDO UNA INFRAESTRUCTURA DE TELECOMUNICACIONES INALÁMBRICAS. INCLUYE LAS ACTIVIDADES DE MANTENIMIENTO Y EXPLOTACIÓN DE REDES DE RADIO BÚSQUEDA Y DE TELEFONÍA MÓVIL Y OTRAS REDES DE TELECOMUNICACIONES INALÁMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2235,'J612002','ACTIVIDADES DE COMPRA DE ACCESO Y CAPACIDAD DE RED CONCEDIDA POR LOS DUEÑOS Y OPERADORES DE LAS REDES Y EL ABASTECIMIENTO DE SERVICIOS DE TELECOMUNICACIONES INALÁMBRICO (EXCEPTO EL SATÉLITE) QUE UTILIZAN ESTA CAPACIDAD A EMPRESAS Y HOGARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2236,'J612003','ACTIVIDADES DE SUMINISTRO DE ACCESO A INTERNET POR LOS OPERADORES DE LA INFRAESTRUCTURA DE TELECOMUNICACIONES INALÁMBRICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2237,'J613','ACTIVIDADES DE TELECOMUNICACIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2238,'J6130','ACTIVIDADES DE TELECOMUNICACIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2239,'J61300','ACTIVIDADES DE TELECOMUNICACIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2240,'J613001','ACTIVIDADES DE OPERACIÓN, MANTENIMIENTO O FACILITACIÓN DEL ACCESO A SERVICIOS DE TRANSMISIÓN DE VOZ, DATOS, TEXTO, SONIDO Y VÍDEO UTILIZANDO UNA INFRAESTRUCTURA DE TELECOMUNICACIONES POR SATÉLITE, ACTIVIDADES DE SUMINISTRO DE ACCESO A INTERNET POR EL OPERADOR DE LA INFRAESTRUCTURA DE TELECOMUNICACIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2241,'J613002','ACTIVIDADES DE TRANSMISIÓN A LOS CONSUMIDORES POR SISTEMAS DE COMUNICACIÓN DIRECTA POR SATÉLITE DE PROGRAMAS VISUALES, SONOROS O DE TEXTO RECIBIDOS DE REDES DE CABLE O ESTACIONES DE TELEVISIÓN O CADENAS DE RADIO LOCALES. (LAS UNIDADES CLASIFICADAS EN ESA CLASE NO PRODUCEN POR LO GENERAL MATERIAL DE PROGRAMACIÓN).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2242,'J619','OTRAS ACTIVIDADES DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2243,'J6190','OTRAS ACTIVIDADES DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2244,'J61900','OTRAS ACTIVIDADES DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2245,'J619001','SUMINISTRO DE APLICACIONES ESPECIALIZADAS DE TELECOMUNICACIONES, COMO DETECCIÓN POR SATÉLITE, TELEMETRÍA DE COMUNICACIONES Y UTILIZACIÓN DE ESTACIONES DE RADAR.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2246,'J619002','OPERACIÓN DE ESTACIONES TERMINALES DE COMUNICACIONES POR SATÉLITE E INSTALACIONES CONEXAS OPERACIONALMENTE CONECTADAS CON UNO O VARIOS SISTEMAS DE COMUNICACIONES TERRESTRES Y CAPACES DE TRANSMITIR O RECIBIR TELECOMUNICACIONES POR SATÉLITE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2247,'J619003','SUMINISTRO DE ACCESO A INTERNET POR REDES QUE NO POSEE NI CONTROLA EL PROVEEDOR DE SERVICIOS DE INTERNET, COMO EL ACCESO TELEFÓNICO A INTERNET, ETC.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2248,'J619004','ACTIVIDADES DE REVENTA DE SERVICIOS DE TELECOMUNICACIONES (SUMINISTRO DE SERVICIOS TELEFÓNICOS Y DE INTERNET EN INSTALACIONES ABIERTAS AL PÚBLICO: CABINAS TELEFÓNICAS Y CIBERCAFÉS.)','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2249,'J619005','SUMINISTRO DE SERVICIOS DE TELECOMUNICACIONES POR LAS CONEXIONES DE TELECOMUNICACIONES EXISTENTES: SUMINISTRO DE SERVICIOS DE TELEFONÍA POR INTERNET (VOIP: VOICE OVER INTERNET PROTOCOL).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2250,'J619006','ACTIVIDADES DE GESTIÓN Y CONSULTORÍA PARA LA TRANSMISIÓN DE DATOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2251,'J619009','OTRAS ACTIVIDADES DE TELECOMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2252,'J62','PROGRAMACIÓN INFORMÁTICA, CONSULTORÍA DE INFORMÁTICA Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2253,'J620','ACTIVIDADES DE PROGRAMACIÓN INFORMÁTICA Y DE CONSULTORÍA DE INFORMÁTICA Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2254,'J6201','ACTIVIDADES DE PROGRAMACIÓN INFORMÁTICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2255,'J62010','ACTIVIDADES DE PROGRAMACIÓN INFORMÁTICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2256,'J620101','ACTIVIDADES DE DISEÑO DE LA ESTRUCTURA Y EL CONTENIDO DE LOS ELEMENTOS SIGUIENTES (Y/O ESCRITURA DEL CÓDIGO INFORMÁTICO NECESARIO PARA SU CREACIÓN Y APLICACIÓN): PROGRAMAS DE SISTEMAS OPERATIVOS (INCLUIDAS ACTUALIZACIONES Y PARCHES DE CORRECCIÓN), APLICACIONES INFORMÁTICAS (INCLUIDAS ACTUALIZACIONES Y PARCHES DE CORRECCIÓN), BASES DE DATOS Y PÁGINAS WEB.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2257,'J620102','ADAPTACIÓN DE PROGRAMAS INFORMÁTICOS A LAS NECESIDADES DE LOS CLIENTES, ES DECIR, MODIFICACIÓN Y CONFIGURACIÓN DE UNA APLICACIÓN EXISTENTE PARA QUE PUEDA FUNCIONAR ADECUADAMENTE CON LOS SISTEMAS DE INFORMACIÓN DE QUE DISPONE EL CLIENTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2258,'J6202','ACTIVIDADES DE CONSULTORÍA DE INFORMÁTICA Y DE GESTIÓN DE INSTALACIONES INFORMÁTICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2259,'J62021','ACTIVIDADES DE CONSULTORÍA DE INFORMÁTICA Y DE GESTIÓN DE INSTALACIONES INFORMÁTICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2260,'J620210','ACTIVIDADES DE PLANIFICACIÓN Y DISEÑO DE SISTEMAS INFORMÁTICOS QUE INTEGRAN EQUIPO Y PROGRAMAS INFORMÁTICOS Y TECNOLOGÍA DE LAS COMUNICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2261,'J62022','GESTIÓN DE RECURSOS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2262,'J620220','SERVICIOS DE GESTIÓN Y MANEJO IN SITU DE SISTEMAS INFORMÁTICOS Y/O INSTALACIONES DE PROCESAMIENTO DE DATOS DE LOS CLIENTES, Y SERVICIOS DE APOYO CONEXOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2263,'J6209','OTRAS ACTIVIDADES DE TECNOLOGÍA DE LA INFORMACIÓN Y DE SERVICIOS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2264,'J62090','OTRAS ACTIVIDADES DE TECNOLOGÍA DE LA INFORMACIÓN Y DE SERVICIOS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2265,'J620901','ACTIVIDADES RELACIONADAS A LA INFORMÁTICA COMO: RECUPERACIÓN EN CASOS DE DESASTRE INFORMÁTICO, INSTALACIÓN DE PROGRAMAS INFORMÁTICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2266,'J620902','ACTIVIDADES DE INSTALACIÓN (MONTAJE) DE COMPUTADORAS PERSONALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2267,'J63','ACTIVIDADES DE SERVICIOS DE INFORMACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2268,'J631','PROCESAMIENTO DE DATOS, HOSPEDAJE Y ACTIVIDADES CONEXAS; PORTALES WEB.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2269,'J6311','PROCESAMIENTO DE DATOS, HOSPEDAJE Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2270,'J63110','PROCESAMIENTO DE DATOS, HOSPEDAJE Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2271,'J631101','SUMINISTRO DE INFRAESTRUCTURA PARA SERVICIOS DE HOSPEDAJE, SERVICIOS DE PROCESAMIENTO DE DATOS Y ACTIVIDADES CONEXAS. INCLUYE ACTIVIDADES ESPECIALIZADAS DE HOSPEDAJE, COMO: HOSPEDAJE DE SITIOS WEB, APLICACIONES, SERVICIOS DE TRANSMISIÓN DE SECUENCIAS DE VÍDEO POR INTERNET.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2272,'J631102','ACTIVIDADES DE PROCESAMIENTO Y SUMINISTRO DE SERVICIO DE REGISTRO DE DATOS: ELABORACIÓN COMPLETA DE DATOS FACILITADOS POR LOS CLIENTES, GENERACIÓN DE INFORMES ESPECIALIZADOS A PARTIR DE DATOS FACILITADOS POR LOS CLIENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2273,'J631103','SERVICIOS DE APLICACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2274,'J631104','SUMINISTRO A LOS CLIENTES DE ACCESO EN TIEMPO COMPARTIDO A SERVICIOS CENTRALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2275,'J6312','PORTALES WEB.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2276,'J63120','PORTALES WEB.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2277,'J631200','OPERACIÓN DE SITIOS WEB QUE FUNCIONAN COMO PORTALES DE INTERNET, COMO LOS SITIOS DE MEDIOS DE DIFUSIÓN QUE PROPORCIONAN CONTENIDOS QUE SE ACTUALIZAN PERIÓDICAMENTE Y LOS QUE UTILIZAN UN MOTOR DE BÚSQUEDA PARA GENERAR Y MANTENER AMPLIAS BASES DE DATOS DE DIRECCIONES DE INTERNET Y DE CONTENIDOS EN UN FORMATO QUE FACILITE LA BÚSQUEDA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2278,'J639','OTRAS ACTIVIDADES DE SERVICIOS DE INFORMACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2279,'J6391','ACTIVIDADES DE AGENCIAS DE NOTICIAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2280,'J63910','ACTIVIDADES DE AGENCIAS DE NOTICIAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2281,'J639100','ACTIVIDADES DE CONSORCIOS Y AGENCIAS DE NOTICIAS QUE SUMINISTRAN NOTICIAS, FOTOGRAFÍAS Y ARTÍCULOS PERIODÍSTICOS A LOS MEDIOS DE DIFUSIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2282,'J6399','OTRAS ACTIVIDADES DE SERVICIOS DE INFORMACIÓN N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2283,'J63990','OTRAS ACTIVIDADES DE SERVICIOS DE INFORMACIÓN N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2284,'J639900','OTRAS ACTIVIDADES DE SERVICIOS DE INFORMACIÓN N.C.P.: SERVICIOS DE INFORMACIÓN TELEFÓNICA, BÚSQUEDA DE INFORMACIÓN A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, SELECCIÓN DE NOTICIAS, DE RECORTES DE PRENSA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2285,'K','ACTIVIDADES FINANCIERAS Y DE SEGUROS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2286,'K64','ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LAS DE SEGUROS Y FONDOS DE PENSIONES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2287,'K641','INTERMEDIACIÓN MONETARIA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2288,'K6411','BANCA CENTRAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2289,'K64110','BANCA CENTRAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2290,'K641100','ACTIVIDADES DE EMISIÓN Y ADMINISTRACIÓN DE LA MONEDA NACIONAL; SUPERVISIÓN Y CONTROL DE LA MASA MONETARIA; RECEPCIÓN DE DEPÓSITOS PARA OPERACIONES DE COMPENSACIÓN ENTRE INSTITUCIONES FINANCIERAS; SUPERVISIÓN DE LAS OPERACIONES BANCARIAS; MANTENIMIENTO DE LAS RESERVAS NACIONALES DE DIVISAS; FUNCIÓN DE BANCO DEL GOBIERNO. LAS ACTIVIDADES DE LOS BANCOS CENTRALES PUEDEN VARIAR POR RAZONES INSTITUCIONALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2291,'K6419','OTROS TIPOS DE INTERMEDIACIÓN MONETARIA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2292,'K64190','OTROS TIPOS DE INTERMEDIACIÓN MONETARIA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2293,'K641901','ACTIVIDADES DE RECEPCIÓN DE DEPÓSITOS Y/O SIMILARES CERCANOS DE DEPÓSITOS Y LA CONCESIÓN DE CRÉDITOS O PRÉSTAMOS DE FONDOS. LA CONCESIÓN DE CRÉDITO PUEDE ADOPTAR DIVERSAS FORMAS, COMO PRÉSTAMOS, HIPOTECAS, TRANSACCIONES CON TARJETAS DE CRÉDITO, ETC. ESAS ACTIVIDADES SON REALIZADAS POR BANCOS DIFERENTES DEL BANCO CENTRAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2294,'K641902','ACTIVIDADES DE RECEPCIÓN DE DEPÓSITOS Y/O SIMILARES CERCANOS DE DEPÓSITOS Y LA CONCESIÓN DE CRÉDITOS O PRÉSTAMOS DE FONDOS. LA CONCESIÓN DE CRÉDITO PUEDE ADOPTAR DIVERSAS FORMAS, COMO PRÉSTAMOS, HIPOTECAS, TRANSACCIONES CON TARJETAS DE CRÉDITO, ETC. ESAS ACTIVIDADES SON REALIZADAS EN GENERAL POR INSTITUCIONES MONETARIAS DIFERENTES DE LOS BANCOS CENTRALES, COMO: CAJAS DE AHORROS, COOPERATIVAS DE CRÉDITO Y ACTIVIDADES DE GIRO POSTAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2295,'K641903','ACTIVIDADES DE RECEPCIÓN DE DEPÓSITOS Y/O SIMILARES CERCANOS DE DEPÓSITOS Y LA CONCESIÓN DE CRÉDITOS O PRÉSTAMOS DE FONDOS. LA CONCESIÓN DE CRÉDITO PUEDE ADOPTAR DIVERSAS FORMAS, COMO PRÉSTAMOS, HIPOTECAS, TRANSACCIONES CON TARJETAS DE CRÉDITO, ETC. ESAS ACTIVIDADES SON REALIZADAS EN GENERAL POR INSTITUCIONES MONETARIAS DIFERENTES DE LOS BANCOS CENTRALES, COMO; ACTIVIDADES DE CONCESIÓN DE CRÉDITO PARA COMPRA DE VIVIENDA DE INSTITUCIONES ESPECIALIZADAS QUE RECIBEN DEPÓSITOS (MUTUALISTAS).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2296,'K642','ACTIVIDADES DE SOCIEDADES DE CARTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2297,'K6420','ACTIVIDADES DE SOCIEDADES DE CARTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2298,'K64200','ACTIVIDADES DE SOCIEDADES DE CARTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2299,'K642000','ACTIVIDADES DE SOCIEDADES DE CARTERA, ES DECIR, UNIDADES TENEDORAS DE ACTIVOS DE UN GRUPO DE EMPRESAS FILIALES (CON PARTICIPACIÓN DE CONTROL EN SU CAPITAL SOCIAL) Y CUYA ACTIVIDAD PRINCIPAL CONSISTE EN LA PROPIEDAD DEL GRUPO. LAS SOCIEDADES DE CARTERA CLASIFICADAS EN ESTA CLASE NO SUMINISTRAN NINGÚN OTRO SERVICIO A LAS EMPRESAS PARTICIPADAS, ES DECIR, NO ADMINISTRAN NI GESTIONAN OTRAS UNIDADES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2300,'K643','FONDOS Y SOCIEDADES DE INVERSIÓN Y ENTIDADES FINANCIERAS SIMILARES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2301,'K6430','FONDOS Y SOCIEDADES DE INVERSIÓN Y ENTIDADES FINANCIERAS SIMILARES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2302,'K64300','FONDOS Y SOCIEDADES DE INVERSIÓN Y ENTIDADES FINANCIERAS SIMILARES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2303,'K643000','ACTIVIDADES DE ENTIDADES JURÍDICAS ORGANIZADAS PARA LA MANCOMUNIÓN DE VALORES U OTROS ACTIVOS FINANCIEROS, SIN GESTIÓN, EN NOMBRE DE ACCIONISTAS O BENEFICIARIOS. LAS CARTERAS SE ADAPTAN A ESPECIFICACIONES CONCRETAS PARA LOGRAR DETERMINADAS CARACTERÍSTICAS; POR EJEMPLO, DE DIVERSIFICACIÓN, RIESGO, RENDIMIENTO Y VARIABILIDAD DE PRECIO. ESAS ENTIDADES OBTIENEN INTERESES, DIVIDENDOS Y OTRAS RENTAS DE LA PROPIEDAD, PERO TIENEN POCOS EMPLEADOS Y NO OBTIENEN INGRESOS POR CONCEPTO DE VENTA DE SERVICIOS. SE INCLUYEN LAS SIGUIENTES ACTIVIDADES: FONDOS DE INVERSIÓN DE PARTICIPACIÓN ABIERTA; FONDOS DE INVERSIÓN CERRADOS; FIDEICOMISOS, LEGADOS O CUENTAS DE AGENCIA, ADMINISTRADOS EN NOMBRE DE LOS BENEFICIARIOS EN VIRTUD DE UN CONTRATO DE FIDUCIA, UN TESTAMENTO O UN CONTRATO DE REPRESENTACIÓN; SOCIEDADES DE INVERSIÓN MOBILIARIA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2304,'K649','OTRAS ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LAS DE SEGUROS Y FONDOS DE PENSIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2305,'K6491','ARRENDAMIENTO FINANCIERO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2306,'K64910','ARRENDAMIENTO FINANCIERO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2307,'K649100','ACTIVIDADES DE ARRENDAMIENTO QUE CUBRE APROXIMADAMENTE TODA LA VIDA ÚTIL PREVISTA DE UN ACTIVO Y EN EL QUE EL ARRENDATARIO ADQUIERE PRÁCTICAMENTE TODOS LOS DERECHOS DE USUFRUCTO Y ASUME TODOS LOS RIESGOS RELACIONADOS CON LA PROPIEDAD DEL ACTIVO, QUE PUEDE O NO SER OBJETO DE TRASPASO. ESA MODALIDAD DE ARRENDAMIENTO CUBRE LA TOTALIDAD O LA PRÁCTICA TOTALIDAD DE LOS COSTOS, INCLUIDOS INTERESES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2308,'K6492','OTRAS ACTIVIDADES DE CONCESIÓN DE CRÉDITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2309,'K64920','OTRAS ACTIVIDADES DE CONCESIÓN DE CRÉDITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2310,'K649201','ACTIVIDADES DE OTORGAMIENTO DE CRÉDITO DE INSTITUCIONES DEDICADAS A LA INTERMEDIACIÓN MONETARIA EN LAS QUE EL CRÉDITO PUEDE ADOPTAR DIFERENTES FORMAS COMO: PRÉSTAMOS, HIPOTECAS, TARJETAS DE CRÉDITO, ETCÉTERA. PROPORCIONANDO LOS SERVICIOS DE: FINANCIAMIENTO PARA COMERCIO INTERNACIONAL, PROVISIÓN DE FINANCIAMIENTO A LARGO PLAZO PARA LA INDUSTRIA A TRAVÉS DE BANCOS INDUSTRIALES, CONCESIÓN DE CRÉDITO A LOS CONSUMIDORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2311,'K649202','ACTIVIDADES DE PRÉSTAMOS FUERA DEL SISTEMA BANCARIO, OTORGAMIENTO DE CRÉDITOS PARA VIVIENDA POR INSTITUCIONES ESPECIALIZADAS QUE NO RECIBEN DEPÓSITOS, SE INCLUYEN ACTIVIDADES REALIZADAS POR LAS CASAS DE EMPEÑO Y MONTES DE PIEDAD.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2312,'K6499','OTRAS ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LAS DE SEGUROS Y FONDOS DE PENSIONES, N.C.P.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2313,'K64990','OTRAS ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LAS DE SEGUROS Y FONDOS DE PENSIONES, N.C.P.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2314,'K649901','OTRAS ACTIVIDADES DE SERVICIOS FINANCIEROS CONSISTENTES PRINCIPALMENTE EN MODALIDADES DE DISTRIBUCIÓN DE FONDOS DISTINTAS DE LA CONCESIÓN DE PRÉSTAMOS: ACTIVIDADES DE FACTORIZACIÓN, SUSCRIPCIÓN DE PERMUTAS FINANCIERAS, OPCIONES Y OTROS INSTRUMENTOS DE COBERTURA Y ACTIVIDADES DE COMPAÑÍAS DE LIQUIDACIÓN POR ADELANTADO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2315,'K649902','ACTIVIDADES DE INVERSIÓN POR CUENTA PROPIA, COMO LAS DE COMPAÑÍAS DE CAPITAL RIESGO, CLUBES DE INVERSIÓN, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2316,'K65','SEGUROS, REASEGUROS Y FONDOS DE PENSIONES, EXCEPTO LOS PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2317,'K651','SEGUROS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2318,'K6511','SEGUROS DE VIDA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2319,'K65110','SEGUROS DE VIDA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2320,'K651100','CONCERTACIÓN DE CONTRATOS DE ANUALIDADES Y PÓLIZAS DE SEGUROS DE VIDA, SEGUROS DE INVALIDEZ Y SEGUROS DE DOBLE INDEMNIZACIÓN (TENGAN O NO UN COMPONENTE IMPORTANTE DE AHORRO).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2321,'K6512','SEGUROS GENERALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2322,'K65120','SEGUROS GENERALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2323,'K651201','SUMINISTROS DE SERVICIOS DE SEGUROS DISTINTOS DE LOS SEGUROS DE VIDA: SEGUROS DE ACCIDENTES Y CONTRA INCENDIOS, SEGUROS MÉDICOS, SEGUROS DE VIAJES, SEGUROS DE COSAS, SEGUROS DE TRANSPORTE POR CARRETERA, MARÍTIMO Y AÉREO, SEGUROS CONTRA PÉRDIDAS PECUNIARIAS Y DE RESPONSABILIDAD CIVIL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2324,'K651202','SERVICIOS DE SEGURO DE MEDICINA PRE PAGADA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2325,'K652','REASEGUROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2326,'K6520','REASEGUROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2327,'K65200','REASEGUROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2328,'K652000','ACTIVIDADES DE ASUNCIÓN DE LA TOTALIDAD O UNA PARTE DE LOS RIESGOS DE PÓLIZAS DE SEGUROS EXISTENTES EMITIDAS ORIGINARIAMENTE POR OTRAS COMPAÑÍAS DE SEGUROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2329,'K653','FONDOS DE PENSIÓN.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2330,'K6530','FONDOS DE PENSIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2331,'K65300','FONDOS DE PENSIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2332,'K653000','ACTIVIDADES DE ENTIDADES JURÍDICAS (ES DECIR, DE FONDOS, PLANES Y/O PROGRAMAS) ORGANIZADAS PARA PROPORCIONAR PRESTACIONES DE JUBILACIÓN EXCLUSIVAMENTE PARA LOS EMPLEADOS O MIEMBROS DE LA ENTIDAD PATROCINADORA. ABARCA PLANES DE PENSIONES CON PRESTACIONES DEFINIDAS Y PLANES INDIVIDUALES EN LOS QUE LAS PRESTACIONES DEPENDEN DE LAS CONTRIBUCIONES DEL AFILIADO. SE INCLUYEN LAS SIGUIENTES ACTIVIDADES: PLANES DE PRESTACIONES SOCIALES PARA LOS EMPLEADOS, FONDOS Y PLANES DE PENSIONES, PLANES DE JUBILACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2333,'K66','ACTIVIDADES AUXILIARES DE LAS ACTIVIDADES DE SERVICIOS FINANCIEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2334,'K661','ACTIVIDADES AUXILIARES DE LAS ACTIVIDADES DE SERVICIOS FINANCIEROS, EXCEPTO LAS DE SEGUROS Y FONDOS DE PENSIONES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2335,'K6611','ADMINISTRACIÓN DE MERCADOS FINANCIEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2336,'K66110','ADMINISTRACIÓN DE MERCADOS FINANCIEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2337,'K661100','GESTIÓN Y SUPERVISIÓN DE LOS MERCADOS FINANCIEROS POR ENTIDADES DISTINTAS DE LAS AUTORIDADES PÚBLICAS, COMO: MERCADO (BOLSAS) DE CONTRATOS DE PRODUCTOS BÁSICOS, MERCADO (BOLSAS) DE FUTUROS, MERCADO (BOLSAS) DE VALORES, MERCADOS BURSÁTILES, MERCADO (BOLSAS) DE OPCIONES SOBRE ACCIONES O SOBRE PRODUCTOS BÁSICOS, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2338,'K6612','CORRETAJE DE VALORES Y DE CONTRATOS DE PRODUCTOS BÁSICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2339,'K66120','CORRETAJE DE VALORES Y DE CONTRATOS DE PRODUCTOS BÁSICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2340,'K661201','ACTIVIDADES DE OFICINAS DE CAMBIO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2341,'K661202','OPERACIONES EN LOS MERCADOS FINANCIEROS POR CUENTA AJENA (POR EJEMPLO, CORREDURÍA DE BOLSA) Y ACTIVIDADES CONEXAS. INCLUYE CORRETAJE DE CONTRATOS DE PRODUCTOS BÁSICOS Y CORRETAJE DE VALORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2342,'K6619','OTRAS ACTIVIDADES AUXILIARES A LAS ACTIVIDADES DE SERVICIOS FINANCIEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2343,'K66190','OTRAS ACTIVIDADES AUXILIARES A LAS ACTIVIDADES DE SERVICIOS FINANCIEROS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2344,'K661901','ACTIVIDADES AUXILIARES DE LAS ACTIVIDADES DE SERVICIOS FINANCIEROS N.C.P., COMO: ACTIVIDADES DE TRAMITACIÓN Y LIQUIDACIÓN DE TRANSACCIONES FINANCIERAS, INCLUIDAS LAS TRANSACCIONES CON TARJETAS DE CRÉDITO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2345,'K661902','ACTIVIDADES DE SERVICIOS DE ASESORAMIENTO EN INVERSIONES Y CORREDORES HIPOTECARIOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2346,'K661903','SERVICIOS DE ADMINISTRACIÓN FIDUCIARIA Y DE CUSTODIA A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2347,'K662','ACTIVIDADES AUXILIARES DE SEGUROS Y FONDOS DE PENSIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2348,'K6621','EVALUACIÓN DE RIESGOS Y DAÑOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2349,'K66210','EVALUACIÓN DE RIESGOS Y DAÑOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2350,'K662100','ACTIVIDADES DE PRESTACIÓN DE SERVICIOS ADMINISTRATIVOS RELACIONADOS CON LOS SEGUROS, COMO LA TASACIÓN Y LIQUIDACIÓN DE RECLAMACIONES. SE INCLUYEN LAS SIGUIENTES ACTIVIDADES: EVALUACIÓN DE LAS RECLAMACIONES, TASACIÓN DE SOLICITUDES DE INDEMNIZACIÓN, EVALUACIÓN DEL RIESGO, EVALUACIÓN DE RIESGOS Y DAÑOS, TASACIÓN DE AVERÍAS Y PÉRDIDAS. INCLUYE LA LIQUIDACIÓN DE SOLICITUDES DE INDEMNIZACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2351,'K6622','ACTIVIDADES DE LOS AGENTES Y CORREDORES DE SEGURO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2352,'K66220','ACTIVIDADES DE LOS AGENTES Y CORREDORES DE SEGURO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2353,'K662200','ACTIVIDADES DE AGENTES Y CORREDORES DE SEGUROS (INTERMEDIARIOS DE SEGUROS) QUE VENDEN, NEGOCIAN U OFERTAN CONTRATOS DE ANUALIDADES Y PÓLIZAS DE SEGUROS Y REASEGUROS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2354,'K6629','OTRAS ACTIVIDADES AUXILIARES DE SEGUROS Y FONDOS DE PENSIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2355,'K66290','OTRAS ACTIVIDADES AUXILIARES DE SEGUROS Y FONDOS DE PENSIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2356,'K662900','ACTIVIDADES ESTRECHAMENTE RELACIONADAS CON SEGUROS Y FONDOS DE PENSIONES (EXCEPTO EL AJUSTE DE RECLAMACIONES Y LAS ACTIVIDADES DE AGENTES DE SEGUROS) ADMINISTRACIÓN DE SALVAMENTOS, SERVICIOS ACTUARIALES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2357,'K663','ACTIVIDADES DE GESTIÓN DE FONDOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2358,'K6630','ACTIVIDADES DE GESTIÓN DE FONDOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2359,'K66300','ACTIVIDADES DE GESTIÓN DE FONDOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2360,'K663000','ACTIVIDADES DE PERSONAS, EMPRESAS Y OTRAS ENTIDADES QUE GESTIONAN CARTERAS Y FONDOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO. SE INCLUYEN LAS SIGUIENTES ACTIVIDADES: GESTIÓN DE FONDOS DE PENSIONES, GESTIÓN DE FONDOS MUTUOS DE INVERSIÓN Y GESTIÓN DE OTROS FONDOS DE INVERSIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2361,'L','ACTIVIDADES INMOBILIARIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2362,'L68','ACTIVIDADES INMOBILIARIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2363,'L681','ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2364,'L6810','ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2365,'L68100','ACTIVIDADES INMOBILIARIAS REALIZADAS CON BIENES PROPIOS O ARRENDADOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2366,'L681001','COMPRA - VENTA, ALQUILER Y EXPLOTACIÓN DE BIENES INMUEBLES PROPIOS O ARRENDADOS, COMO: EDIFICIOS DE APARTAMENTOS Y VIVIENDAS; EDIFICIOS NO RESIDENCIALES, INCLUSO SALAS DE EXPOSICIONES; INSTALACIONES PARA ALMACENAJE, CENTROS COMERCIALES Y TERRENOS; INCLUYE EL ALQUILER DE CASAS Y APARTAMENTOS AMUEBLADOS O SIN AMUEBLAR POR PERÍODOS LARGOS, EN GENERAL POR MESES O POR AÑOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2367,'L681002','EXPLOTACIÓN DE CAMPAMENTOS RESIDENCIALES PARA CASAS MÓVILES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2368,'L681003','PROMOCIÓN DE PROYECTOS DE CONSTRUCCIÓN (PROMOCIÓN INMOBILIARIA) PARA SU POSTERIOR EXPLOTACIÓN, ES DECIR, PARA ALQUILAR ESPACIO EN ESOS EDIFICIOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2369,'L681004','LOTIZACIÓN Y PARCELACIÓN DE PROPIEDADES INMOBILIARIAS EN LOTES, SIN MEJORA DE LOS TERRENOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2370,'L682','ACTIVIDADES INMOBILIARIAS REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2371,'L6820','ACTIVIDADES INMOBILIARIAS REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2372,'L68200','ACTIVIDADES INMOBILIARIAS REALIZADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2373,'L682001','ACTIVIDADES DE AGENTES Y CORREDORES INMOBILIARIOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2374,'L682002','INTERMEDIACIÓN EN LA COMPRA, VENTA Y ALQUILER DE BIENES INMUEBLES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2375,'L682003','ADMINISTRACIÓN DE BIENES INMUEBLES A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2376,'L682004','SERVICIOS DE TASACIÓN INMOBILIARIA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2377,'L682005','ACTIVIDADES DE AGENTES INMOBILIARIOS NEUTRALES QUE GARANTIZAN EL CUMPLIMIENTO DE TODAS LAS CONDICIONES DE UNA TRANSACCIÓN INMOBILIARIA (PLICAS INMOBILIARIAS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2378,'M','ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2379,'M69','ACTIVIDADES JURÍDICAS Y DE CONTABILIDAD.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2380,'M691','ACTIVIDADES JURÍDICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2381,'M6910','ACTIVIDADES JURÍDICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2382,'M69100','ACTIVIDADES JURÍDICAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2383,'M691001','ACTIVIDADES DE REPRESENTACIÓN JURÍDICA DE LOS INTERESES DE UNA PARTE CONTRA OTRA, SEA O NO ANTE TRIBUNALES U OTROS ÓRGANOS JUDICIALES, REALIZADAS POR ABOGADOS O BAJO LA SUPERVISIÓN DE ABOGADOS: ASESORAMIENTO Y REPRESENTACIÓN EN PROCEDIMIENTOS CIVILES, PROCEDIMIENTOS PENALES Y EN RELACIÓN CON CONFLICTOS LABORALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2384,'M691002','ACTIVIDADES DE NOTARIOS PÚBLICOS, PRESTACIÓN DE ASESORAMIENTO EN GENERAL, PREPARACIÓN DE DOCUMENTOS JURÍDICOS: ESCRITURAS DE CONSTITUCIÓN, CONTRATOS DE SOCIEDAD Y DOCUMENTOS SIMILARES PARA LA FORMACIÓN DE SOCIEDADES, PATENTES Y DERECHOS DE AUTOR, ESCRITURAS, TESTAMENTOS, FIDEICOMISOS, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2385,'M691003','OTRAS ACTIVIDADES DE EJECUTORES JUDICIALES, ALGUACILES, ÁRBITROS, EXAMINADORES Y MEDIADORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2386,'M691009','OTRAS ACTIVIDADES DE ASESORAMIENTO Y REPRESENTACIÓN EN PROCEDIMIENTOS JURÍDICOS (DERECHO CONSTITUCIONAL, ADMINISTRATIVO, MILITAR, ETCÉTERA).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2387,'M692','ACTIVIDADES DE CONTABILIDAD, TENEDURÍA DE LIBROS Y AUDITORIA; CONSULTORÍA FISCAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2388,'M6920','ACTIVIDADES DE CONTABILIDAD, TENEDURÍA DE LIBROS Y AUDITORIAS; CONSULTORÍA FISCAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2389,'M69200','ACTIVIDADES DE CONTABILIDAD, TENEDURÍA DE LIBROS Y AUDITORIAS; CONSULTORÍA FISCAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2390,'M692001','ACTIVIDADES DE REGISTRO DE LAS TRANSACCIONES COMERCIALES DE EMPRESAS Y OTRAS ENTIDADES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2391,'M692002','ACTIVIDADES DE PREPARACIÓN O AUDITORIA DE LAS CUENTAS FINANCIERAS Y EXAMEN Y CERTIFICACIÓN DE CUENTAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2392,'M692003','ACTIVIDADES DE PREPARACIÓN DE LAS DECLARACIONES TRIBUTARIAS DE LAS PERSONAS Y EMPRESAS; ASESORAMIENTO Y DE REPRESENTACIÓN DE CLIENTES ANTE LAS AUTORIDADES TRIBUTARIAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2393,'M692009','OTRAS ACTIVIDADES DE CONTABILIDAD, TENEDURÍA DE LIBROS Y AUDITORIA; CONSULTORÍA FISCAL (PROCESAMIENTO DE NÓMINA, ETCÉTERA).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2394,'M70','ACTIVIDADES DE OFICINAS PRINCIPALES; ACTIVIDADES DE CONSULTORÍA DE GESTIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2395,'M701','ACTIVIDADES DE OFICINAS PRINCIPALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2396,'M7010','ACTIVIDADES DE OFICINAS PRINCIPALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2397,'M70100','ACTIVIDADES DE OFICINAS PRINCIPALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2398,'M701000','SUPERVISIÓN Y GESTIÓN DE OTRAS UNIDADES DE LA MISMA COMPAÑÍA O EMPRESA, ASUMIENDO LA PLANIFICACIÓN ESTRATÉGICA, ORGANIZATIVA Y LA FUNCIÓN DE TOMA DE DECISIONES DE LA COMPAÑÍA O EMPRESA; EJERCIENDO EL CONTROL OPERATIVO Y LA GESTIÓN DE LAS OPERACIONES CORRIENTES DE LAS OTRAS UNIDADES: OFICINAS PRINCIPALES, OFICINAS ADMINISTRATIVAS CENTRALIZADAS, SEDES, OFICINAS DE DISTRITO, REGIONALES Y OFICINAS SUBSIDIARIAS DE GESTIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2399,'M702','ACTIVIDADES DE CONSULTORÍA DE GESTIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2400,'M7020','ACTIVIDADES DE CONSULTORÍA DE GESTIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2401,'M70200','ACTIVIDADES DE CONSULTORÍA DE GESTIÓN EMPRESARIAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2402,'M702001','SERVICIOS DE ASESORAMIENTO, ORIENTACIÓN Y ASISTENCIA OPERATIVA A LAS EMPRESAS Y A LA ADMINISTRACIÓN PÚBLICA EN MATERIA DE: RELACIONES PÚBLICAS Y COMUNICACIONES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2403,'M702002','SERVICIOS DE ASESORAMIENTO, ORIENTACIÓN Y ASISTENCIA OPERATIVA A LAS EMPRESAS Y A LA ADMINISTRACIÓN PÚBLICA EN MATERIA DE: ACTIVIDADES DE CABILDEO (GRUPOS DE PRESIÓN (LOBBIES)).','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2404,'M702003','SERVICIOS DE  ASESORAMIENTO, ORIENTACIÓN Y ASISTENCIA OPERATIVA A LAS EMPRESAS Y A LA ADMINISTRACIÓN PÚBLICA EN MATERIA DE: DISEÑO DE MÉTODOS O PROCEDIMIENTOS CONTABLES, PROGRAMAS DE CONTABILIDAD DE COSTOS Y PROCEDIMIENTOS DE CONTROL PRESUPUESTARIO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2405,'M702004','PRESTACIÓN DE ASESORAMIENTO Y AYUDA A LAS EMPRESAS Y LAS ADMINISTRACIONES PÚBLICAS EN MATERIA DE PLANIFICACIÓN, ORGANIZACIÓN, EFICIENCIA Y CONTROL, INFORMACIÓN ADMINISTRATIVA, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2406,'M71','ACTIVIDADES DE ARQUITECTURA E INGENIERÍA; ENSAYOS Y ANÁLISIS TÉCNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2407,'M711','ACTIVIDADES DE ARQUITECTURA E INGENIERÍA Y ACTIVIDADES CONEXAS DE CONSULTORÍA TÉCNICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2408,'M7110','ACTIVIDADES DE ARQUITECTURA E INGENIERÍA Y ACTIVIDADES CONEXAS DE CONSULTORÍA TÉCNICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2409,'M71101','ACTIVIDADES DE ASESORAMIENTO TÉCNICO EN ARQUITECTURA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2410,'M711011','ACTIVIDADES DE ASESORAMIENTO TÉCNICO DE ARQUITECTURA EN DISEÑO DE EDIFICIOS Y DIBUJO DE PLANOS DE CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2411,'M711012','ACTIVIDADES DE ASESORAMIENTO TÉCNICO DE ARQUITECTURA EN PLANIFICACIÓN URBANA Y ARQUITECTURA PAISAJISTA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2412,'M71102','DISEÑO DE INGENIERÍA Y ACTIVIDADES DE CONSULTORÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2413,'M711021','ACTIVIDADES DE DISEÑO DE INGENIERÍA (ES DECIR, APLICACIÓN DE LAS LEYES FÍSICAS Y DE LOS PRINCIPIOS DE INGENIERÍA AL DISEÑO DE MÁQUINAS, MATERIALES, INSTRUMENTOS, ESTRUCTURAS, PROCESOS Y SISTEMAS) Y ASESORÍA DE INGENIERÍA PARA MAQUINARÍA, PROCESOS Y PLANTAS INDUSTRIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2414,'M711022','ACTIVIDADES DE DISEÑO DE INGENIERÍA Y CONSULTORÍA DE INGENIERÍA PARA PROYECTOS DE INGENIERÍA CIVIL, HIDRÁULICA Y DE TRÁFICO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2415,'M711023','ACTIVIDADES DE DISEÑO DE INGENIERÍA Y CONSULTORÍA DE INGENIERÍA PARA PROYECTOS DE ORDENACIÓN HÍDRICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2416,'M711024','ELABORACIÓN Y REALIZACIÓN DE PROYECTOS DE INGENIERÍA ELÉCTRICA Y ELECTRÓNICA, INGENIERÍA DE MINAS, INGENIERÍA QUÍMICA, MECÁNICA, INDUSTRIAL, DE SISTEMAS, E INGENIERÍA ESPECIALIZADA EN SISTEMAS DE SEGURIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2417,'M711025','ACTIVIDADES DE DISEÑO DE INGENIERÍA Y CONSULTORÍA DE INGENIERÍA PARA GESTIÓN DE PROYECTOS RELACIONADOS CON LA CONSTRUCCIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2418,'M711026','ELABORACIÓN DE PROYECTOS DE INGENIERÍA ESPECIALIZADA EN SISTEMAS DE ACONDICIONADO DE AIRE, REFRIGERACIÓN, SANEAMIENTO, CONTROL DE LA CONTAMINACIÓN, ACONDICIONAMIENTO ACÚSTICO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2419,'M711029','OTRAS ACTIVIDADES DE DISEÑO Y ASESORÍA DE INGENIERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2420,'M71103','ACTIVIDADES DE ESTUDIOS GEODÉSICOS, GEOFÍSICOS, GEOLÓGICOS Y SISMOGRÁFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2421,'M711031','ACTIVIDADES DE TOPOGRAFÍA (AGRIMENSURA, MEDICIÓN DE TIERRAS Y LÍMITES), ACTIVIDADES DE ESTUDIOS HIDROLÓGICOS Y ACTIVIDADES DE ESTUDIOS DE SUBSUELO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2422,'M711032','ACTIVIDADES CARTOGRÁFICAS Y DE INFORMACIÓN ESPACIAL.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2423,'M711033','ACTIVIDADES DE ESTUDIOS GEOFÍSICOS, GEOLÓGICOS Y SISMOGRÁFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2424,'M71109','OTRAS ACTIVIDADES DE ARQUITECTURA E INGENIERÍA Y ACTIVIDADES CONEXAS DE CONSULTORÍA TÉCNICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2425,'M711090','OTRAS ACTIVIDADES DE ARQUITECTURA E INGENIERÍA Y ACTIVIDADES CONEXAS DE CONSULTORÍA TÉCNICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2426,'M712','ENSAYOS Y ANÁLISIS TÉCNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2427,'M7120','ENSAYOS Y ANÁLISIS TÉCNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2428,'M71201','ENSAYOS Y ANÁLISIS TÉCNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2429,'M712011','REALIZACIÓN DE ENSAYOS FÍSICOS, QUÍMICOS Y OTROS ENSAYOS ANALÍTICOS DE TODO TIPO DE MATERIALES Y PRODUCTOS: ENSAYOS ACÚSTICOS Y DE VIBRACIONES, ENSAYOS DE CALIFICACIÓN, FIABILIDAD Y ANÁLISIS DE DEFECTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2430,'M712012','ACTIVIDADES DE ANÁLISIS DE LA COMPOSICIÓN Y PUREZA DE MINERALES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2431,'M712013','ACTIVIDADES DE ENSAYOS EN EL CAMPO DE LA HIGIENE ALIMENTARIA, INCLUIDAS ACTIVIDADES DE ENSAYO Y CONTROL VETERINARIO EN RELACIÓN CON LA PRODUCCIÓN DE ALIMENTOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2432,'M712014','ACTIVIDADES DE ENSAYOS PARA DETERMINAR LAS PROPIEDADES FÍSICAS Y EL RENDIMIENTO DE PRODUCTOS Y MATERIALES EN CUANTO, A SU RESISTENCIA, ESPESOR, DURABILIDAD, RADIACTIVIDAD, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2433,'M712015','ACTIVIDADES DE ENSAYOS Y MEDICIONES DE INDICADORES AMBIENTALES: CONTAMINACIÓN DEL AIRE Y DEL AGUA ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2434,'M712016','ACTIVIDADES DE ENSAYOS DE ENSAYOS RADIOGRÁFICOS DE SOLDADURAS Y JUNTAS Y RENDIMIENTO DE MAQUINARÍA COMPLETA: MOTORES, AUTOMÓVILES, EQUIPO ELECTRÓNICO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2435,'M71209','OTROS ENSAYOS Y ANÁLISIS TÉCNICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2436,'M712091','ACTIVIDADES DE CERTIFICACIÓN DE PRODUCTOS, COMO BIENES DE CONSUMO, VEHÍCULOS AUTOMOTORES, AERONAVES, CONTENEDORES PRESURIZADOS, CENTRALES NUCLEARES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2437,'M712092','PRUEBAS PERIÓDICAS DE SEGURIDAD VIAL DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2438,'M712093','ACTIVIDADES DE ANÁLISIS Y PRUEBAS RELACIONADAS A CAMPOS CIENTÍFICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2439,'M712094','ACTIVIDADES DE LABORATORIOS POLICIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2440,'M712099','OTRAS ACTIVIDADES DE ENSAYOS Y ANÁLISIS TÉCNICOS: ENSAYOS BASADOS EN LA UTILIZACIÓN DE MAQUETAS O MODELOS (DE AERONAVES, DE EMBARCACIONES, DE PRESAS, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2441,'M72','INVESTIGACIÓN CIENTÍFICA Y DESARROLLO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2442,'M721','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS NATURALES Y LA INGENIERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2443,'M7210','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS NATURALES Y LA INGENIERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2444,'M72101','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN BIOTECNOLOGÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2445,'M721011','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA BIOTECNOLOGÍA DE: ADN/ARN, GENÓMICA, FARMACOGENÓMICA, SONDAS GENÉTICAS, INGENIERÍA GENÉTICA, SECUENCIACIÓN Y AMPLIFICACIÓN DE ADN Y ARN, PATRONES DE EXPRESIÓN GÉNICA EL USO DE TECNOLOGÍA ANTISENSE, VECTORES GENÉTICOS Y DE ARN, TERAPIA GENÉTICA Y VECTORES VIRALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2446,'M721012','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA BIOTECNOLOGÍA DE: PROTEÍNAS Y OTRAS MOLÉCULAS SECUENCIACIÓN, SÍNTESIS E INGENIERÍA DE PROTEÍNAS Y PÉPTIDOS (QUE INCLUYE HORMONAS DE GRAN TAMAÑO MOLECULAR), MEJORA DE MÉTODOS DE LIBERACIÓN DE DROGAS DE GRAN TAMAÑO, PROTEÓMICA, AISLAMIENTO Y PURIFICACIÓN DE PROTEÍNAS, SEÑALIZACIÓN E IDENTIFICACIÓN DE RECEPTORES CELULARES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2447,'M721013','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA BIOTECNOLOGÍA DE: CULTIVOS E INGENIERÍA CELULARES Y DE TEJIDOS, INGENIERÍA TISULAR (QUE INCLUYEN IMPLANTES DE TEJIDO E INGENIERÍA BIOMÉDICA) EN FUSIÓN CELULAR, VACUNAS/ESTIMULANTES DEL SISTEMA INMUNE, MANIPULACIÓN EMBRIONARIA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2448,'M721014','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA TÉCNICAS DE PROCESO BIOTECNOLÓGICOS: FERMENTACIÓN MEDIANTE EL USO DE BIORREACTORES, PROCESADO BIOLÓGICO, BIODECANTACIÓN, BIOPULPING, BIOBLANQUEO, BIODESULFURIZACIÓN, BIORREMEDIACIÓN, BIOFILTRACIÓN Y FITORREMEDIACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2449,'M721015','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA BIOINFORMÁTICA: CONSTRUCCIÓN DE BASES DE DATOS GENÓMICAS, SECUENCIAS DE PROTEÍNAS, MODELIZACIÓN DE PROCESOS BIOLÓGICOS COMPLEJOS QUE INCLUYEN BIOLOGÍA DE SISTEMAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2450,'M721016','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA NANOBIOTECNOLOGÍA: APLICACIÓN DE TÉCNICAS Y PROCESOS DE NANO/MICRO FABRICACIÓN PARA LA CONSTRUCCIÓN DE APARATOS PARA EL ESTUDIO DE BIOSISTEMAS Y APLICACIONES EN LIBERACIÓN DE DROGAS, DIAGNÓSTICOS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2451,'M72102','INVESTIGACIÓN Y DESARROLLO EXPERIMENTAL EN CIENCIAS NATURALES Y LA INGENIERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2452,'M721021','INVESTIGACIÓN Y DESARROLLO EXPERIMENTAL EN CIENCIAS NATURALES Y TÉCNICAS (FÍSICA, QUÍMICA, BIOLOGÍA, GEOLOGÍA, ASTRONOMÍA) DISTINTOS DE LA INVESTIGACIÓN Y EL DESARROLLO EXPERIMENTAL EN EL CAMPO DE LA BIOTECNOLOGÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2453,'M721022','INVESTIGACIÓN Y DESARROLLO EN INGENIERÍA Y TECNOLOGÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2454,'M721023','INVESTIGACIÓN Y DESARROLLO EN CIENCIAS MÉDICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2455,'M721024','INVESTIGACIÓN Y DESARROLLO EN CIENCIAS AGROPECUARIAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2456,'M721025','INVESTIGACIÓN Y DESARROLLO INTERDISCIPLINARIOS CENTRADOS PRINCIPALMENTE EN LAS CIENCIAS NATURALES Y LA INGENIERÍA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2457,'M721029','OTRAS ACTIVIDADES DE INVESTIGACIÓN Y DESARROLLO EXPERIMENTAL EN CIENCIAS NATURALES Y LA INGENIERÍA (PROPIEDAD INTELECTUAL, SECRETO COMERCIAL, PATENTES, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2458,'M722','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS SOCIALES Y LAS HUMANIDADES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2459,'M7220','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS SOCIALES Y LAS HUMANIDADES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2460,'M72200','INVESTIGACIONES Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS SOCIALES Y LAS HUMANIDADES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2461,'M722001','INVESTIGACIÓN Y DESARROLLO EN CIENCIAS SOCIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2462,'M722002','INVESTIGACIÓN Y DESARROLLO EN HUMANIDADES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2463,'M722009','OTRAS ACTIVIDADES DE INVESTIGACIÓN Y DESARROLLO EXPERIMENTAL EN EL CAMPO DE LAS CIENCIAS SOCIALES Y LAS HUMANIDADES E INTERDISCIPLINARIOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2464,'M73','PUBLICIDAD Y ESTUDIOS DE MERCADO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2465,'M731','PUBLICIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2466,'M7310','PUBLICIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2467,'M73100','REALIZACIÓN DE CAMPAÑAS DE COMERCIALIZACIÓN, PUBLICITARIAS Y OTROS SERVICIOS DE PUBLICIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2468,'M731001','CREACIÓN E INSERCIÓN DE ANUNCIOS EN PERIÓDICOS, REVISTAS, PROGRAMAS DE RADIO Y DE TELEVISIÓN, INTERNET Y OTROS MEDIOS DE DIFUSIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2469,'M731002','CREACIÓN Y COLOCACIÓN DE ANUNCIOS DE PUBLICIDAD AL AIRE LIBRE EN: CARTELES, TABLEROS, BOLETINES Y CARTELERAS, DECORACIÓN DE ESCAPARATES, DISEÑO DE SALAS DE EXHIBICIÓN, COLOCACIÓN DE ANUNCIOS EN AUTOMÓVILES Y BUSES, ACTIVIDADES DE PERIFONEO, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2470,'M731003','REPRESENTACIÓN DE MEDIOS DE DIFUSIÓN, VENTA DE TIEMPO Y ESPACIO EN DIVERSOS MEDIOS DE DIFUSIÓN INTERESADOS EN LA OBTENCIÓN DE ANUNCIOS Y PUBLICIDAD AÉREA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2471,'M731004','REALIZACIÓN DE CAMPAÑAS DE COMERCIALIZACIÓN Y OTROS SERVICIOS DE PUBLICIDAD DIRIGIDOS A ATRAER Y RETENER CLIENTES: PROMOCIÓN DE PRODUCTOS, COMERCIALIZACIÓN EN EL PUNTO DE VENTA, PUBLICIDAD DIRECTA POR CORREO Y ASESORAMIENTO EN MARKETING, CREACIÓN DE STANDS, OTRAS ESTRUCTURAS Y LUGARES DE EXHIBICIÓN, DISTRIBUCIÓN O ENTREGA DE MATERIALES O MUESTRAS DE PUBLICIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2472,'M731005','ALQUILER DE ESPACIOS DE PUBLICIDAD EN VALLAS PUBLICITARIAS, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2473,'M731009','OTROS SERVICIOS DE PUBLICIDAD N.C.P.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2474,'M732','ESTUDIOS DE MERCADO Y ENCUESTAS DE OPINIÓN PÚBLICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2475,'M7320','ESTUDIOS DE MERCADO Y ENCUESTAS DE OPINIÓN PÚBLICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2476,'M73200','ESTUDIOS DE MERCADO Y ENCUESTAS DE OPINIÓN PÚBLICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2477,'M732001','ESTUDIOS SOBRE LAS POSIBILIDADES DE COMERCIALIZACIÓN (MERCADOS POTENCIALES), LA ACEPTACIÓN Y EL GRADO DE CONOCIMIENTO DE LOS PRODUCTOS Y LOS HÁBITOS DE COMPRA DE LOS CONSUMIDORES CON EL OBJETO DE PROMOVER LAS VENTAS Y DESARROLLAR NUEVOS PRODUCTOS, INCLUIDOS ANÁLISIS ESTADÍSTICOS DE LOS RESULTADOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2478,'M732002','ENCUESTAS DE OPINIÓN PÚBLICAS SOBRE CUESTIONES POLÍTICAS, ECONÓMICAS Y SOCIALES, ASÍ COMO SUS ANÁLISIS ESTADÍSTICOS DE LOS RESULTADOS DE ESAS ENCUESTAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2479,'M74','OTRAS ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2480,'M741','ACTIVIDADES ESPECIALIZADAS DE DISEÑO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2481,'M7410','ACTIVIDADES ESPECIALIZADAS DE DISEÑO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2482,'M74100','ACTIVIDADES ESPECIALIZADAS DE DISEÑO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2483,'M741001','DISEÑO DE TELAS, PRENDAS DE VESTIR, CALZADO, JOYAS, MUEBLES Y OTROS ARTÍCULOS DE DECORACIÓN INTERIOR Y DE MODA, ASÍ COMO DE OTROS EFECTOS PERSONALES Y ENSERES DOMÉSTICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2484,'M741002','DISEÑO INDUSTRIAL, ES DECIR CREACIÓN Y DESARROLLO DE DISEÑOS Y ESPECIFICACIONES QUE OPTIMIZAN LA UTILIZACIÓN, EL VALOR Y LA APARIENCIA DE LOS PRODUCTOS, INCLUYENDO LA DETERMINACIÓN DE LOS MATERIALES, LA CONSTRUCCIÓN, EL MECANISMO, LA FORMA, EL COLOR Y EL ACABADO DEL PRODUCTO, TENIENDO EN CUENTA LAS CARACTERÍSTICAS Y NECESIDADES HUMANAS Y CONSIDERACIONES RELACIONADAS CON LA SEGURIDAD, EL ATRACTIVO EN EL MERCADO, LA EFICIENCIA EN LA PRODUCCIÓN, LA DISTRIBUCIÓN, LA UTILIZACIÓN, Y LA FACILIDAD DE MANTENIMIENTO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2485,'M741003','ACTIVIDADES DE DISEÑADORES GRÁFICOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2486,'M741004','ACTIVIDADES DE DECORADORES DE INTERIORES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2487,'M741009','OTRAS ACTIVIDADES ESPECIALIZADAS DE DISEÑO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2488,'M742','ACTIVIDADES DE FOTOGRAFÍA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2489,'M7420','ACTIVIDADES DE FOTOGRAFÍA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2490,'M74200','PRODUCCIÓN FOTOGRÁFICA COMERCIAL Y PARA USUARIOS NO COMERCIALES, PROCESAMIENTO DE PELÍCULAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2491,'M742001','REALIZACIÓN DE RETRATOS FOTOGRÁFICOS PARA PASAPORTES, ACTOS ACADÉMICOS, BODAS, ETCÉTERA, INCLUIDO LAS FILMACIONES EN VÍDEO DE ACONTECIMIENTOS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2492,'M742002','REALIZACIÓN DE FOTOGRAFÍAS PARA ANUNCIOS COMERCIALES, PARA EDITORIALES, Y PARA ACTIVIDADES RELACIONADAS CON LA MODA, LOS BIENES RAÍCES O EL TURISMO, ACTIVIDADES DE FOTÓGRAFOS DE PRENSA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2493,'M742003','REALIZACIÓN DE FOTOGRAFÍA ESPECIALIZADA COMO: FOTOGRAFÍA AÉREA, FOTOGRAFÍA SUBMARINA, FOTOGRAFÍA MÉDICA, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2494,'M742004','ACTIVIDADES DE REVELADO, IMPRESIÓN, AMPLIACIÓN DE FOTOGRAFÍAS Y PELÍCULAS DE LOS CLIENTES, LABORATORIOS DE REVELADO DE PELÍCULAS E IMPRESIÓN DE FOTOGRAFÍAS; COPIA, RESTAURACIÓN Y RETOQUE DE FOTOGRAFÍAS, NEGATIVOS DE FOTOGRAFÍAS Y PELÍCULAS, INCLUIDO ACTIVIDADES DE TIENDAS DE REVELADO RÁPIDO (QUE NO FORMEN PARTE DE COMERCIOS DE VENTA AL POR MENOR DE CÁMARAS).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2495,'M742009','OTRAS ACTIVIDADES DE FOTOGRAFÍA: MONTAJE DE DIAPOSITIVAS, MICROFILMACIÓN DE DOCUMENTOS, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2496,'M749','OTRAS ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS N.C.P.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2497,'M7490','OTRAS ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS N.C.P.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2498,'M74901','OTRAS ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS N.C.P.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2499,'M749011','ACTIVIDADES DE TRADUCCIÓN E INTERPRETACIÓN.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2500,'M749012','ACTIVIDADES DE CORRETAJE EMPRESARIAL, GESTIÓN DE LA COMPRA O VENTA DE PEQUEÑAS Y MEDIANAS EMPRESAS, INCLUIDAS PRÁCTICAS PROFESIONALES Y EXCLUIDAS LAS ACTIVIDADES DE CORRETAJE INMOBILIARIO.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2501,'M749013','ACTIVIDADES DE INTERMEDIACIÓN EN MATERIA DE PATENTES (GESTIÓN DE LA COMPRA Y VENTA DE PATENTES).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2502,'M749014','ACTIVIDADES DE TASACIÓN PARA ANTIGÜEDADES, JOYAS, ETCÉTERA, DISTINTAS DE LA TASACIÓN DE INMUEBLES Y DE LA RELACIONADA CON LOS SEGUROS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2503,'M749015','ACTIVIDADES DE PRONÓSTICO DEL TIEMPO (PREVISIÓN METEOROLÓGICA).','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2504,'M749019','OTRAS ACTIVIDADES PROFESIONALES, CIENTÍFICAS Y TÉCNICAS: REDACCIÓN, DISEÑOS DETALLADOS REALIZADOS POR DIBUJANTES ARQUITECTÓNICOS, LECTURA DE CONTADORES DE GAS, AGUA Y ENERGÍA ELÉCTRICA, AUDITORÍA DE EFECTOS E INFORMACIÓN SOBRE FLETES, MEDIDORES DE CANTIDADES DE OBRA (CERTIFICACIÓN DE OBRA), ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2505,'M74902','OTROS TIPOS DE CONSULTORÍA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2506,'M749021','ACTIVIDADES DE CONSULTORÍA DE SEGURIDAD.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2507,'M749022','ACTIVIDADES DE CONSULTORÍA DE AGRONOMÍA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2508,'M749023','ACTIVIDADES DE CONSULTORÍA AMBIENTAL.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2509,'M749024','ACTIVIDADES DE CONSULTORÍA DISTINTAS DE LAS DE ARQUITECTURA, INGENIERÍA Y GESTIÓN.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2510,'M749029','OTROS TIPOS DE CONSULTORÍA TÉCNICA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2511,'M74909','OTRAS ACTIVIDADES DE PROFESIONALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2512,'M749090','ACTIVIDADES REALIZADAS POR AGENCIAS EN NOMBRE DE PARTICULARES PARA OBTENER CONTRATOS DE ACTUACIÓN EN PELÍCULAS, OBRAS DE TEATRO Y OTROS ESPECTÁCULOS CULTURALES Y DEPORTIVOS, Y PARA OFERTAR LIBROS, GUIONES, OBRAS DE ARTE, FOTOGRAFÍAS, ETCÉTERA, A EDITORES, PRODUCTORES, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2513,'M75','ACTIVIDADES VETERINARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2514,'M750','ACTIVIDADES VETERINARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2515,'M7500','ACTIVIDADES VETERINARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2516,'M75000','ACTIVIDADES VETERINARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2517,'M750001','ACTIVIDADES DE ATENCIÓN MÉDICA Y CONTROL DE ANIMALES, EXCLUIDO LOS DOMÉSTICOS. ESTAS ACTIVIDADES SON LLEVADAS A CABO POR VETERINARIOS CUALIFICADOS QUE PRESTAN SERVICIOS EN HOSPITALES VETERINARIOS ASÍ COMO TAMBIÉN EN ESTABLECIMIENTOS AGROPECUARIOS, A DOMICILIO, EN CONSULTORIOS, QUIRÓFANOS PRIVADOS Y EN OTROS LUGARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2518,'M750002','ACTIVIDADES DE ATENCIÓN MÉDICA Y CONTROL DE ANIMALES DOMÉSTICOS. ESTAS ACTIVIDADES SON LLEVADAS A CABO POR VETERINARIOS CUALIFICADOS QUE PRESTAN SERVICIOS EN HOSPITALES VETERINARIOS ASÍ COMO TAMBIÉN EN ESTABLECIMIENTOS AGROPECUARIOS, EN PERRERAS, A DOMICILIO, EN CONSULTORIOS, QUIRÓFANOS PRIVADOS Y EN OTROS LUGARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2519,'M750003','ACTIVIDADES DE ASISTENTES DE VETERINARIO U OTRO PERSONAL VETERINARIO AUXILIAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2520,'M750004','ACTIVIDADES CLÍNICO PATOLÓGICAS Y OTRAS ACTIVIDADES DE DIAGNÓSTICO RELACIONADAS CON LOS ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2521,'M750005','ACTIVIDADES DE VETERINARIA QUE REQUIEREN LA UTILIZACIÓN DE AMBULANCIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2522,'N','ACTIVIDADES DE SERVICIOS ADMINISTRATIVOS Y DE APOYO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2523,'N/A','SIN INFORMACIÓN','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2524,'N77','ACTIVIDADES DE ALQUILER Y ARRENDAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2525,'N771','ALQUILER DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2526,'N7710','ALQUILER DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2527,'N77100','ALQUILER DE VEHÍCULOS AUTOMOTORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2528,'N771000','ACTIVIDADES DE ALQUILER CON FINES OPERATIVOS DE AUTOMÓVILES DE PASAJEROS, CAMIONES, CAMIONETAS, REMOLQUES Y VEHÍCULOS DE RECREO. (SIN CONDUCTOR).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2529,'N772','ALQUILER DE EFECTOS PERSONALES Y ARTÍCULOS DE USO DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2530,'N7721','ALQUILER DE EQUIPO RECREATIVO Y DEPORTIVO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2531,'N77210','ALQUILER DE EQUIPO RECREATIVO Y DEPORTIVO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2532,'N772101','ALQUILER DE EMBARCACIONES DE RECREO, CANOAS Y VELEROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2533,'N772102','ALQUILER DE BICICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2534,'N772103','ALQUILER DE HAMACAS DE PLAYA Y SOMBRILLAS (PARASOLES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2535,'N772104','ALQUILER DE ESQUÍS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2536,'N772109','ALQUILER DE OTROS TIPOS DE EQUIPO DE DEPORTE, ALAS DELTA CON MOTOR Y SIN MOTOR, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2537,'N7722','ALQUILER DE CINTAS DE VIDEO Y DISCOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2538,'N77220','ALQUILER DE CINTAS DE VIDEO Y DISCOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2539,'N772200','ALQUILER DE CINTAS DE VIDEO, DISCOS, CD, DVD, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2540,'N7729','ALQUILER OTROS EFECTOS PERSONALES Y ARTÍCULOS DE USO DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2541,'N77290','ALQUILER OTROS EFECTOS PERSONALES Y ARTÍCULOS DE USO DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2542,'N772901','ALQUILER DE PRODUCTOS TEXTILES, PRENDAS DE VESTIR Y CALZADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2543,'N772902','ALQUILER DE MUEBLES, ARTÍCULOS DE CERÁMICA Y DE VIDRIO, UTENSILIOS DE COCINA, VAJILLAS, APARATOS ELÉCTRICOS Y OTROS ARTÍCULOS DE USO DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2544,'N772903','ALQUILER DE JOYAS, INSTRUMENTOS MUSICALES, MATERIAL DE ESCENOGRAFÍA Y DE VESTUARIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2545,'N772904','ALQUILER DE LIBROS, PERIÓDICOS Y REVISTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2546,'N772909','ALQUILER Y ARRENDAMIENTO DE OTROS EFECTOS PERSONALES Y ENSERES DOMÉSTICOS: MAQUINARÍA Y EQUIPO DE BRICOLAJE, POR EJEMPLO: HERRAMIENTAS PARA REPARACIONES DOMÉSTICAS, FLORES Y PLANTAS, EQUIPO ELECTRÓNICO DE USO DOMÉSTICO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2547,'N773','ALQUILER DE OTROS TIPOS DE MAQUINARIA, EQUIPO Y BIENES TANGIBLES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2548,'N7730','ALQUILER DE OTROS TIPOS DE MAQUINARIA, EQUIPO Y BIENES TANGIBLES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2549,'N77301','ALQUILER DE OTROS TIPOS DE MAQUINARIA Y EQUIPO OPERACIONAL POR LAS INDUSTRIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2550,'N773011','ALQUILER CON FINES OPERATIVOS, SIN OPERADORES, DE OTROS TIPOS DE MAQUINARIA Y EQUIPO OPERACIONAL QUE SUELEN SER UTILIZADOS COMO BIENES DE CAPITAL POR LAS INDUSTRIAS: MOTORES Y TURBINAS, MÁQUINAS HERRAMIENTA, EQUIPO DE MINERÍA Y DE EXTRACCIÓN DE PETRÓLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2551,'N773012','ALQUILER CON FINES OPERATIVOS, SIN OPERADORES, DE OTROS TIPOS DE MAQUINARIA Y EQUIPO OPERACIONAL QUE SUELEN SER UTILIZADOS COMO BIENES DE CAPITAL POR LAS INDUSTRIAS: EQUIPO PROFESIONAL DE RADIO, TELEVISIÓN Y COMUNICACIONES; EQUIPO DE PRODUCCIÓN DE PELÍCULAS CINEMATOGRÁFICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2552,'N773013','ALQUILER CON FINES OPERATIVOS, SIN OPERADORES, DE OTROS TIPOS DE MAQUINARIA Y EQUIPO OPERACIONAL QUE SUELEN SER UTILIZADOS COMO BIENES DE CAPITAL POR LAS INDUSTRIAS: EQUIPO DE MEDICIÓN Y CONTROL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2553,'N773014','ALQUILER CON FINES OPERATIVOS DE MAQUINARIA Y EQUIPO DE USO AGRÍCOLA Y FORESTAL SIN OPERADORES: TRACTORES UTILIZADOS EN ACTIVIDADES AGROPECUARIAS Y SILVÍCOLAS; TRACTORES DE MANEJO A PIE (DIRIGIDOS POR UNA PERSONA DESDE FUERA), SEGADORAS, INCLUIDAS SEGADORAS DE CÉSPED, REMOLQUES Y SEMIRREMOLQUES DE CARGA Y DESCARGA AUTOMÁTICA, MÁQUINAS UTILIZADAS EN LA AGRICULTURA PARA PREPARAR LOS SUELOS, PLANTAR O ABONAR, COMO ARADOS, ESPARCIDORAS DE ESTIÉRCOL, SEMBRADORAS, RASTRILLADORAS, MÁQUINAS DE ORDEÑAR; ASPERSORES DE USO AGRÍCOLA, MÁQUINAS PARA LA RECOLECCIÓN Y TRILLA, COMO COSECHADORAS, TRILLADORAS, CRIBADORAS; MÁQUINAS UTILIZADAS EN LA AVICULTURA Y APICULTURA, EQUIPO PARA LA PREPARACIÓN DE PIENSO, MÁQUINAS PARA LIMPIAR, SELECCIONAR Y CLASIFICAR HUEVOS, FRUTA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2554,'N773015','ALQUILER CON FINES OPERATIVOS DE MAQUINARIA Y EQUIPO PARA LA CONSTRUCCIÓN E INGENIERÍA CIVIL SIN OPERADORES: CAMIONES GRÚA, ANDAMIOS Y PLATAFORMAS DE TRABAJO, SIN MONTAJE NI DESMANTELAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2555,'N773016','ALQUILER CON FINES OPERATIVOS DE MAQUINARIA Y EQUIPO DE OFICINA SIN OPERADOR: MOBILIARIO DE OFICINA, COMPUTADORAS Y EQUIPO PERIFÉRICO, MÁQUINAS COPIADORAS, MÁQUINAS DE ESCRIBIR Y MÁQUINAS DE PROCESAMIENTO DE TEXTO, MÁQUINAS REGISTRADORAS, CALCULADORAS ELECTRÓNICAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2556,'N773019','ALQUILER CON FINES OPERATIVOS, SIN OPERADORES, DE OTROS TIPOS DE MAQUINARIA CIENTÍFICA, COMERCIAL E INDUSTRIAL Y EQUIPO OPERACIONAL QUE SUELEN SER UTILIZADOS COMO BIENES DE CAPITAL POR LAS INDUSTRIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2557,'N77302','ALQUILER DE EQUIPO DE TRANSPORTE AÉREO, ACUÁTICO Y TERRESTRE (EXCEPTO VEHÍCULOS AUTOMOTORES) SIN CONDUCTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2558,'N773021','ALQUILER CON FINES OPERATIVOS DE EQUIPO DE TRANSPORTE TERRESTRE (EXCEPTO VEHÍCULOS AUTOMOTORES) SIN CONDUCTOR DE MOTOCICLETAS, CARAVANAS, FURGONETAS DE ACAMPADA (CAMPERS), ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2559,'N773022','ALQUILER CON FINES OPERATIVOS DE EQUIPO DE TRANSPORTE TERRESTRE (EXCEPTO VEHÍCULOS AUTOMOTORES) SIN CONDUCTOR DE VEHÍCULOS FERROVIARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2560,'N773023','ALQUILER CON FINES OPERATIVOS DE EQUIPO DE TRANSPORTE ACUÁTICO SIN OPERADOR: BARCOS Y BUQUES COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2561,'N773024','ALQUILER CON FINES OPERATIVOS DE EQUIPO DE TRANSPORTE AÉREO SIN OPERADOR: AERONAVES, GLOBOS DE AIRE CALIENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2562,'N77303','ALQUILER DE BIENES TANGIBLES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2563,'N773031','ALQUILER DE CONSTRUCCIONES MÓVILES TEMPORALES PARA ALOJAMIENTO U OFICINAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2564,'N773032','ALQUILER DE CONTENEDORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2565,'N773033','ALQUILER DE PALETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2566,'N773034','ALQUILER DE ANIMALES: REBAÑOS, CABALLOS DE CARRERAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2567,'N774','ARRENDAMIENTO DE PROPIEDAD INTELECTUAL Y PRODUCTOS SIMILARES, EXCEPTO OBRAS PROTEGIDAS POR DERECHOS DE AUTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2568,'N7740','ARRENDAMIENTO DE PROPIEDAD INTELECTUAL Y PRODUCTOS SIMILARES, EXCEPTO OBRAS PROTEGIDAS POR DERECHOS DE AUTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2569,'N77400','ARRENDAMIENTO DE PROPIEDAD INTELECTUAL Y PRODUCTOS SIMILARES, EXCEPTO OBRAS PROTEGIDAS POR DERECHOS DE AUTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2570,'N774001','ARRENDAMIENTO DE PRODUCTOS DE PROPIEDAD INTELECTUAL (EXCEPTO OBRAS PROTEGIDAS POR DERECHOS DE AUTOR, COMO LIBROS O PROGRAMAS INFORMÁTICOS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2571,'N774002','RECEPCIÓN DE REGALÍAS O DERECHOS DE LICENCIA POR LA UTILIZACIÓN DE: FRANQUICIAS, ENTIDADES PATENTADAS, MARCAS DE FÁBRICA O DE COMERCIO O MARCAS DE SERVICIOS Y NOMBRES COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2572,'N774003','RECEPCIÓN DE REGALÍAS O DERECHOS DE LICENCIA POR LA UTILIZACIÓN DE: PROSPECCIÓN, EXPLOTACIÓN Y EVALUACIÓN DE RECURSOS MINERALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2573,'N774009','OTRAS ACTIVIDADES DE ARRENDAMIENTO DE PROPIEDAD INTELECTUAL Y PRODUCTOS SIMILARES, EXCEPTO OBRAS PROTEGIDAS POR DERECHO DE AUTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2574,'N78','ACTIVIDADES DE EMPLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2575,'N781','ACTIVIDADES DE AGENCIAS DE EMPLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2576,'N7810','ACTIVIDADES DE AGENCIAS DE EMPLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2577,'N78100','ACTIVIDADES DE AGENCIAS DE EMPLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2578,'N781000','ACTIVIDADES DE BÚSQUEDA, SELECCIÓN, RECOMENDACIÓN Y COLOCACIÓN DE PERSONAL, INCLUIDA LA COLOCACIÓN O BÚSQUEDA DE EJECUTIVOS, ACTIVIDADES DE LAS AGENCIAS Y OFICINAS DE SELECCIÓN DE ACTORES, POR EJEMPLO, PARA OBRAS DE TEATRO Y ACTIVIDADES DE AGENCIA DE COLOCACIÓN POR INTERNET (ON LINE).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2579,'N782','ACTIVIDADES DE AGENCIAS DE EMPLEO TEMPORAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2580,'N7820','ACTIVIDADES DE AGENCIAS DE EMPLEO TEMPORAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2581,'N78200','ACTIVIDADES DE AGENCIAS DE EMPLEO TEMPORAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2582,'N782000','SUMINISTRO DE TRABAJADORES PARA LAS ACTIVIDADES DE LOS CLIENTES POR PERÍODOS LIMITADOS DE TIEMPO CON EL FIN DE REEMPLAZAR A EMPLEADOS DE LOS CLIENTES O SUPLEMENTAR TEMPORALMENTE SU FUERZA DE TRABAJO, CUANDO LOS TRABAJADORES SUMINISTRADOS SON EMPLEADOS DE LAS PROPIAS AGENCIAS DE EMPLEO TEMPORAL. LAS UNIDADES CLASIFICADAS EN ESTA CLASE NO SE ENCARGAN DE LA SUPERVISIÓN DIRECTA DE SUS EMPLEADOS EN LOS LUGARES DE TRABAJO DE LOS CLIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2583,'N783','OTRAS ACTIVIDADES DE DOTACIÓN DE RECURSOS HUMANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2584,'N7830','OTRAS ACTIVIDADES DE DOTACIÓN DE RECURSOS HUMANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2585,'N78300','OTRAS ACTIVIDADES DE DOTACIÓN DE RECURSOS HUMANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2586,'N783000','SUMINISTRO DE RECURSOS HUMANOS PARA LAS ACTIVIDADES DE LOS CLIENTES. LA PROVISIÓN DE RECURSOS HUMANOS SE REALIZA POR LO GENERAL A LARGO PLAZO O DE FORMA PERMANENTE, Y LAS UNIDADES CLASIFICADAS EN ESTA CLASE PUEDEN DESEMPEÑAR UNA AMPLIA GAMA DE FUNCIONES CONEXAS DE GESTIÓN DE RECURSOS HUMANOS. LAS UNIDADES CLASIFICADAS AQUÍ CONSTITUYEN LOS EMPLEADORES OFICIALES DE LOS EMPLEADOS EN LO QUE RESPECTA A LA NÓMINA, LOS IMPUESTOS Y OTROS ASPECTOS FISCALES Y DE RECURSOS HUMANOS, PERO NO SE ENCARGAN DE LA DIRECCIÓN NI DE LA SUPERVISIÓN DEL TRABAJO DE ESOS EMPLEADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2587,'N79','ACTIVIDADES DE AGENCIAS DE VIAJES, OPERADORES TURÍSTICOS, SERVICIOS DE RESERVAS Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2588,'N791','ACTIVIDADES DE AGENCIAS DE VIAJES Y OPERADORES TURÍSTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2589,'N7911','ACTIVIDADES DE AGENCIAS DE VIAJES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2590,'N79110','ACTIVIDADES DE LAS AGENCIAS VIAJE.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2591,'N791100','ACTIVIDADES DE LAS AGENCIAS DE VIAJES DEDICADAS PRINCIPALMENTE A VENDER SERVICIOS DE VIAJES, DE VIAJES ORGANIZADOS, DE TRANSPORTE Y DE ALOJAMIENTO, AL POR MAYOR O AL POR MENOR, AL PÚBLICO EN GENERAL Y A CLIENTES COMERCIALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2592,'N7912','ACTIVIDADES DE OPERADORES TURÍSTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2593,'N79120','ACTIVIDADES DE OPERADORES TURÍSTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2594,'N791200','ACTIVIDAD DE OPERADORES TURÍSTICOS QUE SE ENCARGAN DE LA PLANIFICACIÓN Y ORGANIZACIÓN DE PAQUETES DE SERVICIOS DE VIAJES (TOURS) PARA SU VENTA A TRAVÉS DE AGENCIAS DE VIAJES O POR LOS PROPIOS OPERADORES TURÍSTICOS. ESOS VIAJES ORGANIZADOS (TOURS) PUEDEN INCLUIR LA TOTALIDAD O PARTE DE LAS SIGUIENTES CARACTERÍSTICAS: TRANSPORTE, ALOJAMIENTO, COMIDAS, VISITAS A MUSEOS, LUGARES HISTÓRICOS O CULTURALES, ESPECTÁCULOS TEATRALES, MUSICALES O DEPORTIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2595,'N799','OTROS SERVICIOS DE RESERVAS Y ACTIVIDADES CONEXAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2596,'N7990','OTROS SERVICIOS DE RESERVAS Y ACTIVIDADES CONEXAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2597,'N79900','OTROS SERVICIOS DE RESERVAS Y ACTIVIDADES CONEXAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2598,'N799001','PRESTACIÓN DE OTROS SERVICIOS DE RESERVAS RELACIONADOS CON LOS VIAJES: RESERVAS DE TRANSPORTE, HOTELES, RESTAURANTES, ALQUILER DE AUTOMÓVILES, ENTRETENIMIENTO Y DEPORTE, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2599,'N799002','PRESTACIÓN DE SERVICIOS DE INTERCAMBIO EN RÉGIMEN DE TIEMPO COMPARTIDO O MULTIPROPIEDAD.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2600,'N799003','ACTIVIDADES DE VENTA DE BOLETOS PARA OBRAS DE TEATRO, COMPETICIONES DEPORTIVAS Y OTRAS ACTIVIDADES DE DIVERSIÓN Y ENTRETENIMIENTO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2601,'N799004','PRESTACIÓN DE SERVICIOS DE ASISTENCIA A LOS TURISTAS: SUMINISTRO A LOS CLIENTES DE INFORMACIÓN SOBRE LOS VIAJES, ACTIVIDADES DE GUÍAS DE TURISMO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2602,'N799005','ACTIVIDADES DE PROMOCIÓN TURÍSTICA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.90,9.20,'A'),
	 (2603,'N80','ACTIVIDADES DE SEGURIDAD E INVESTIGACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2604,'N801','ACTIVIDADES DE SEGURIDAD PRIVADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2605,'N8010','ACTIVIDADES DE SEGURIDAD PRIVADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2606,'N80100','ACTIVIDADES DE SEGURIDAD PRIVADA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2607,'N801001','SERVICIOS DE VEHÍCULOS BLINDADOS (TRANSPORTE DE VALORES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2608,'N801002','SERVICIOS DE ESCOLTA (GUARDAESPALDAS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2609,'N801003','SERVICIOS DE GUARDIAS DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2610,'N801009','OTRAS ACTIVIDADES DE SEGURIDAD PRIVADA: DETECTOR DE MENTIRAS (POLÍGRAFO), HUELLAS DACTILARES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2611,'N802','ACTIVIDADES DE SERVICIOS DE SISTEMAS DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2612,'N8020','ACTIVIDADES DE SERVICIOS DE SISTEMAS DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2613,'N80200','ACTIVIDADES DE SERVICIOS DE SISTEMAS DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2614,'N802001','ACTIVIDADES DE SUPERVISIÓN A DISTANCIA DE SISTEMAS ELECTRÓNICOS DE SEGURIDAD, COMO LOS DE ALARMA CONTRA ROBOS Y CONTRA INCENDIOS, INCLUIDO SU INSTALACIÓN Y MANTENIMIENTO. LA UNIDAD QUE LLEVA A CABO ESTA ACTIVIDAD PUEDE DEDICARSE TAMBIÉN A LA VENTA DE ESTOS SISTEMAS DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2615,'N802002','ACTIVIDADES DE INSTALACIÓN, REPARACIÓN, RECONSTRUCCIÓN Y AJUSTE DE DISPOSITIVOS MECÁNICOS O ELÉCTRICOS DE CIERRE, CAJAS DE CAUDALES Y CAJAS FUERTES. LA UNIDAD QUE LLEVA A CABO ESTA ACTIVIDAD PUEDE DEDICARSE TAMBIÉN A LA VENTA DE ESTOS DISPOSITIVOS MECÁNICOS O ELÉCTRICOS DE CIERRE, CAJAS DE CAUDALES Y CAJAS FUERTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2616,'N803','ACTIVIDADES DE INVESTIGACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2617,'N8030','ACTIVIDADES DE INVESTIGACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2618,'N80300','ACTIVIDADES DE INVESTIGACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2619,'N803000','ACTIVIDADES DE TODO TIPO DE INVESTIGADORES PRIVADOS, INDEPENDIENTEMENTE DEL TIPO DE CLIENTE Y DE LA FINALIDAD DE LA INVESTIGACIÓN, SERVICIOS DE INVESTIGACIÓN Y DE DETECTIVES Y OTRAS ACTIVIDADES DE INVESTIGACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2620,'N81','ACTIVIDADES DE SERVICIOS A EDIFICIOS Y PAISAJISMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2621,'N811','ACTIVIDADES COMBINADAS DE APOYO A INSTALACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2622,'N8110','ACTIVIDADES COMBINADAS DE APOYO A INSTALACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2623,'N81100','ACTIVIDADES COMBINADAS DE APOYO A INSTALACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2624,'N811000','PRESTACIÓN DE UNA COMBINACIÓN DE SERVICIOS DE APOYO EN LAS INSTALACIONES DE LOS CLIENTES, COMO LIMPIEZA GENERAL DE INTERIORES, MANTENIMIENTO, ELIMINACIÓN DE LA BASURAS, SEGURIDAD Y VIGILANCIA, ENVÍO DE CORREO, RECEPCIÓN, LAVANDERÍA Y SERVICIOS CONEXOS, A FIN DE FACILITAR EL FUNCIONAMIENTO DE LAS INSTALACIONES. LAS UNIDADES CLASIFICADAS EN ESTA CLASE PROPORCIONAN PERSONAL PARA LA REALIZACIÓN DE ESTAS ACTIVIDADES DE APOYO, PERO NO PARTICIPAN EN LAS ACTIVIDADES PRINCIPALES DE LOS CLIENTES NI SON RESPONSABLES DE ELLAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2625,'N812','ACTIVIDADES DE LIMPIEZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2626,'N8121','LIMPIEZA GENERAL DE EDIFICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2627,'N81210','LIMPIEZA GENERAL DE EDIFICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2628,'N812100','LIMPIEZA GENERAL (NO ESPECIALIZADA) DE TODO TIPO DE EDIFICIOS, ESTUDIOS PROFESIONALES, LOCALES COMERCIALES,  PROFESIONALES Y EDIFICIOS CON MÚLTIPLES UNIDADES RESIDENCIALES COMO: OFICINAS, CASAS Y DEPARTAMENTOS, FÁBRICAS, ESTABLECIMIENTOS COMERCIALES E INSTITUCIONES. ESTAS ACTIVIDADES CONSISTEN SOBRE TODO EN LA LIMPIEZA DE INTERIORES, AUNQUE PUEDEN ABARCAR LA LIMPIEZA DE ZONAS EXTERIORES CONEXAS, COMO VENTANAS Y PASADIZOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2629,'N8129','OTRAS ACTIVIDADES DE LIMPIEZA DE EDIFICIOS E INSTALACIONES INDUSTRIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2630,'N81291','OTRAS ACTIVIDADES DE LIMPIEZA DE EDIFICIOS E INSTALACIONES INDUSTRIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2631,'N812911','ACTIVIDADES DE LIMPIEZA EXTERIOR DE EDIFICIOS DE TODO TIPO, COMO OFICINAS, FÁBRICAS, ESTABLECIMIENTOS COMERCIALES, INSTITUCIONES Y OTROS LOCALES COMERCIALES, PROFESIONALES Y EDIFICIOS CON MÚLTIPLES UNIDADES RESIDENCIALES (MULTIFAMILIARES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2632,'N812912','ACTIVIDADES DE LIMPIEZA ESPECIALIZADA DE EDIFICIOS, COMO LIMPIEZA DE VENTANAS, LIMPIEZA DE CHIMENEAS Y HOGARES DE CHIMENEA, HORNOS, INCINERADORES, LIMPIEZA DE MAQUINARIA INDUSTRIAL, CALDERAS, CONDUCTOS DE VENTILACIÓN, EXTRACTORES DE AIRE, ACTIVIDADES DE LIMPIEZA DE EDIFICIOS E INSTALACIONES INDUSTRIALES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2633,'N81299','OTRAS ACTIVIDADES DE LIMPIEZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2634,'N812991','SERVICIOS DE LIMPIEZA Y MANTENIMIENTO DE PISCINAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2635,'N812992','LIMPIEZA DE TRENES, AUTOBUSES, AERONAVES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2636,'N812993','LIMPIEZA DEL INTERIOR DE CAMIONES CISTERNA Y BUQUES PETROLEROS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2637,'N812994','ACTIVIDADES DE DESINFECCIÓN, DESRATIZACIÓN Y EXTERMINIO DE PLAGAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2638,'N812995','ACTIVIDADES DE BARRIDO DE CALLES, RETIRADA DE NIEVE Y HIELO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2639,'N812999','OTRAS ACTIVIDADES DE LIMPIEZA: LIMPIEZA DE BOTELLAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2640,'N813','ACTIVIDADES DE PAISAJISMO Y SERVICIOS DE MANTENIMIENTO CONEXOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2641,'N8130','ACTIVIDADES DE PAISAJISMO Y SERVICIOS DE MANTENIMIENTO CONEXOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2642,'N81301','PLANTACIÓN, CUIDADO Y MANTENIMIENTO DE PARQUES Y JARDINES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2643,'N813011','PLANTACIÓN, CUIDADO Y MANTENIMIENTO DE PARQUES Y JARDINES PARA: VIVIENDAS CON JARDÍN DE USO PRIVADO O COMUNITARIO, EDIFICIOS PÚBLICOS Y SEMIPÚBLICOS (HOSPITALES, ESCUELAS, EDIFICIOS ADMINISTRATIVOS, IGLESIAS, ETCÉTERA), EDIFICIOS INDUSTRIALES Y COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2644,'N813012','PLANTACIÓN, CUIDADO Y MANTENIMIENTO DE PARQUES Y JARDINES PARA: TERRENOS MUNICIPALES (PARQUES, ZONAS VERDES, CEMENTERIOS, ETCÉTERA) Y AJARDINAMIENTO DE VÍAS PÚBLICAS (CARRETERAS, LÍNEAS DE FERROCARRIL Y DE TRANVÍA, VÍAS DE NAVEGACIÓN INTERIOR, PUERTOS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2645,'N81302','PLANTACIÓN, CUIDADO, MANTENIMIENTO DE VEGETACIÓN Y OTRAS ACTIVIDADES DE PAISAJISMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2646,'N813021','PLANTACIÓN, CUIDADO Y MANTENIMIENTO DE VEGETACIÓN EN EDIFICIOS (AZOTEAS, FACHADAS, PATIOS INTERIORES), TERRENOS DEPORTIVOS (CAMPOS DE FÚTBOL, CAMPOS DE GOLF, ETCÉTERA), PARQUES INFANTILES, PRADERAS PARA TOMAR EL SOL Y OTROS PARQUES DE RECREO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2647,'N813022','PLANTACIÓN, CUIDADO Y MANTENIMIENTO DE VEGETACIÓN EN AGUA EMBALSADA Y CORRIENTE (FUENTES, ESTANQUES, PISCINAS, ACEQUIAS, CURSOS DE AGUA, SISTEMAS DE AGUAS RESIDUALES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2648,'N813023','ACTIVIDADES DE MANTENIMIENTO DE TERRENOS EN BUENAS CONDICIONES ECOLÓGICAS COMO LA PLANTACIÓN DE PLANTAS DE PROTECCIÓN CONTRA EL RUIDO, EL VIENTO, LA EROSIÓN, LA VISIBILIDAD Y EL DESLUMBRAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2649,'N82','ACTIVIDADES ADMINISTRATIVAS Y DE APOYO DE OFICINA Y OTRAS ACTIVIDADES DE APOYO A LAS EMPRESAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2650,'N821','ACTIVIDADES ADMINISTRATIVAS Y DE APOYO DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2651,'N8211','ACTIVIDADES COMBINADAS DE SERVICIOS ADMINISTRATIVOS DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2652,'N82110','ACTIVIDADES COMBINADAS DE SERVICIOS ADMINISTRATIVOS DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2653,'N821100','ACTIVIDADES DE PRESTACIÓN DE UNA SERIE DE SERVICIOS ADMINISTRATIVOS DE OFICINA CORRIENTES, COMO RECEPCIÓN, PLANIFICACIÓN FINANCIERA, FACTURACIÓN Y REGISTRO, PERSONAL Y DISTRIBUCIÓN FÍSICA (SERVICIOS DE MENSAJERÍA) Y LOGÍSTICA, A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2654,'N8219','FOTOCOPIADO, PREPARACIÓN DE DOCUMENTOS Y OTRAS ACTIVIDADES ESPECIALIZADAS DE APOYO DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2655,'N82190','FOTOCOPIADO, PREPARACIÓN DE DOCUMENTOS Y OTRAS ACTIVIDADES ESPECIALIZADAS DE APOYO DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2656,'N821901','SERVICIOS DE APOYO DE SECRETARÍA, TRANSCRIPCIÓN DE DOCUMENTOS Y OTROS SERVICIOS DE SECRETARÍA; ESCRITURA DE CARTAS O HISTORIALES PROFESIONALES (CURRÍCULUM), PREPARACIÓN DE DOCUMENTOS, EDICIÓN DE DOCUMENTOS Y CORRECCIÓN DE PRUEBAS; ACTIVIDADES DE MECANOGRAFÍA, PROCESAMIENTO DE TEXTO Y EDICIÓN ELECTRÓNICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2657,'N821902','ALQUILER DE APARTADOS DE CORREO Y OTRAS ACTIVIDADES RELACIONADAS CON EL CORREO (EXCEPTO LA PUBLICIDAD DIRECTA POR CORREO).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2658,'N821903','ACTIVIDADES DE FOTOCOPIADO Y REALIZACIÓN DE DUPLICADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2659,'N821909','OTROS SERVICIOS DE COPIA DE DOCUMENTOS NO ACOMPAÑADOS DE SERVICIOS DE IMPRESIÓN, COMO LOS DE IMPRESIÓN EN OFFSET, IMPRESIÓN RÁPIDA, IMPRESIÓN DIGITAL O SERVICIOS DE PREPARACIÓN PARA LA PRENSA, Y OTROS SERVICIOS ESPECIALIZADOS DE OFICINA, DISEÑO DE PROCESOS (CIANOTIPIA, BLUEPRINTING), ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2660,'N822','ACTIVIDADES DE CENTROS DE LLAMADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2661,'N8220','ACTIVIDADES DE CENTROS DE LLAMADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2662,'N82200','ACTIVIDADES DE CENTROS DE LLAMADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2663,'N822001','ACTIVIDADES DE CENTROS QUE ATIENDEN A LLAMADAS DE CLIENTES UTILIZANDO OPERADORES HUMANOS, SISTEMAS DE DISTRIBUCIÓN AUTOMÁTICA DE LLAMADAS, SISTEMAS INFORMATIZADOS DE TELEFONÍA, SISTEMAS INTERACTIVOS DE RESPUESTA DE VOZ O MÉTODOS SIMILARES PARA RECIBIR PEDIDOS, PROPORCIONAR INFORMACIÓN SOBRE PRODUCTOS, RESPONDER A SOLICITUDES DE ASISTENCIA DE LOS CLIENTES O ATENDER RECLAMACIONES (CALL - CENTER).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2664,'N822002','ACTIVIDADES DE CENTROS QUE REALIZAN LLAMADAS, USANDO TÉCNICAS SIMILARES, PARA VENDER O PROMOCIONAR BIENES O SERVICIOS A CLIENTES POTENCIALES, REALIZAR ESTUDIOS DE MERCADO O ENCUESTAS DE OPINIÓN PÚBLICA Y ACTIVIDADES SIMILARES PARA LOS CLIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2665,'N823','ORGANIZACIÓN DE CONVENCIONES Y EXPOSICIONES COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2666,'N8230','ORGANIZACIÓN DE CONVENCIONES Y EXPOSICIONES COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2667,'N82300','ORGANIZACIÓN DE CONVENCIONES Y EXPOSICIONES COMERCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2668,'N823000','ORGANIZACIÓN, PROMOCIÓN Y/O GESTIÓN DE EVENTOS COMO EXPOSICIONES COMERCIALES O EMPRESARIALES, CONVENCIONES, CONFERENCIAS Y REUNIONES, ESTÉN INCLUIDAS O NO LA GESTIÓN DE ESAS INSTALACIONES Y LA DOTACIÓN DE PERSONAL NECESARIO PARA SU FUNCIONAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2669,'N829','ACTIVIDADES DE SERVICIOS DE APOYO A LAS EMPRESAS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2670,'N8291','ACTIVIDADES DE AGENCIAS DE COBRO Y AGENCIAS DE CALIFICACIÓN CREDITICIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2671,'N82910','ACTIVIDADES DE AGENCIAS DE COBRO Y AGENCIAS DE CALIFICACIÓN CREDITICIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2672,'N829101','ACTIVIDADES DE COBRO DE CANTIDADES ADEUDADAS Y ENTREGA DE ESOS FONDOS A LOS CLIENTES, COMO SERVICIOS DE COBRO DE DEUDAS O FACTURAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2673,'N829102','ACTIVIDADES DE RECOPILACIÓN DE INFORMACIÓN, COMO HISTORIALES DE CRÉDITO Y DE EMPLEO DE PERSONAS E HISTORIALES DE CRÉDITO DE EMPRESAS, Y SUMINISTRO DE ESA INFORMACIÓN A INSTITUCIONES FINANCIERAS, EMPRESAS DE VENTA AL POR MENOR Y OTRAS ENTIDADES QUE NECESITAN PODER EVALUAR LA SOLVENCIA DE ESAS PERSONAS Y EMPRESAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2674,'N8292','ACTIVIDADES DE ENVASADO Y EMPAQUETADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2675,'N82920','ACTIVIDADES DE ENVASADO Y EMPAQUETADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2676,'N829201','ACTIVIDADES DE ENVASADO Y EMPAQUETADO A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO, CON INTERVENCIÓN O NO DE PROCESOS AUTOMATIZADOS: EMBOTELLADO DE LÍQUIDOS, INCLUIDOS ALIMENTOS Y BEBIDAS, ENVASADO O EMPAQUETADO DE SÓLIDOS (EMBALAJE CON PLÁSTICO DE BURBUJAS, RECUBRIMIENTO CON PAPEL ALUMINIO, ETCÉTERA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2677,'N829202','ACTIVIDADES DE ETIQUETADO, ESTAMPADO E IMPRESIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2678,'N829209','OTRAS ACTIVIDADES DE ENVASADO Y EMPAQUETADO: ACTIVIDADES DE EMPAQUETADO DE ENVÍOS Y ENVOLTURA DE REGALOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2679,'N8299','OTRAS ACTIVIDADES DE SERVICIOS DE APOYO A EMPRESAS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2680,'N82990','OTRAS ACTIVIDADES DE SERVICIOS DE APOYO A EMPRESAS N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2681,'N829901','ACTIVIDADES DE ELABORACIÓN DE ACTAS TEXTUALES Y REGISTRO EN TAQUIGRAFÍA (ESTENOTIPIA) DE PROCEDIMIENTOS JURÍDICOS EN DIRECTO Y TRANSCRIPCIÓN DE LOS MATERIALES CORRESPONDIENTES, COMO: SERVICIOS DE REDACCIÓN DE ACTAS JUDICIALES O DE REGISTRO EN ESTENOTIPIA, SERVICIOS PÚBLICOS DE ESTENOGRAFÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2682,'N829902','ACTIVIDADES DE SUBTITULADO SIMULTÁNEO PARA SORDOS EN TIEMPO REAL DE RETRANSMISIONES EN DIRECTO POR TELEVISIÓN, REUNIONES, CONFERENCIAS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2683,'N829903','SERVICIOS DE ORGANIZACIÓN DE LA RECAUDACIÓN DE FONDOS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATA, SERVICIOS DE RECUPERACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2684,'N829909','OTRAS ACTIVIDADES DE APOYO QUE SE PROPORCIONAN HABITUALMENTE A LAS EMPRESAS Y QUE NO CLASIFICAN EN OTRA PARTE: SERVICIO DE RECOGIDA DE MONEDAS DE PARQUÍMETROS, SERVICIOS DE ANILLADOS Y PLASTIFICADOS, PRECLASIFICACIÓN DE CORREO, IMPRESIÓN DE CÓDIGO DE BARRAS, CODIFICACIÓN DE LA BARRA DE DIRECCIÓN, PROGRAMAS DE FIDELIZACIÓN, SUBASTA POR CUENTA PROPIA, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2685,'O','ADMINISTRACIÓN PÚBLICA Y DEFENSA; PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2686,'O84','ADMINISTRACIÓN PÚBLICA Y DEFENSA; PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2687,'O841','ADMINISTRACIÓN DEL ESTADO Y APLICACIÓN DE LA POLÍTICA ECONÓMICA Y SOCIAL DE LA COMUNIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2688,'O8411','ACTIVIDADES DE LA ADMINISTRACIÓN PÚBLICA EN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2689,'O84110','ACTIVIDADES DE LA ADMINISTRACIÓN PÚBLICA EN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2690,'O841101','DESEMPEÑO DE LAS FUNCIONES EJECUTIVAS Y LEGISLATIVAS DE LOS ÓRGANOS Y ORGANISMOS CENTRALES, REGIONALES Y LOCALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2691,'O841102','ADMINISTRACIÓN Y SUPERVISIÓN DE LOS ASUNTOS FISCALES: APLICACIÓN DE LOS SISTEMAS TRIBUTARIOS, RECAUDACIÓN DE DERECHOS E IMPUESTOS SOBRE BIENES E INVESTIGACIÓN DE CASOS DE EVASIÓN DE IMPUESTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2692,'O841103','ADMINISTRACIÓN DE ADUANAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2693,'O841104','EJECUCIÓN PRESUPUESTARIA Y ADMINISTRACIÓN DE FONDOS PÚBLICOS (HACIENDA) Y DE LA DEUDA PÚBLICA: OBTENCIÓN Y RECEPCIÓN DE FONDOS Y FISCALIZACIÓN DE SU DESEMBOLSO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2694,'O841105','APLICACIÓN DE LA POLÍTICA GENERAL DE INVESTIGACIÓN Y DESARROLLO (CIVILES) Y ADMINISTRACIÓN DE LOS FONDOS CORRESPONDIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2695,'O841106','ADMINISTRACIÓN Y GESTIÓN DE LOS SERVICIOS GENERALES DE PLANIFICACIÓN ECONÓMICA, SOCIAL Y DE ESTADÍSTICA EN LOS DIVERSOS NIVELES DE LA ADMINISTRACIÓN PÚBLICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2696,'O8412','REGULACIÓN DE LAS ACTIVIDADES DE ORGANISMOS QUE PRESTAN SERVICIOS SANITARIOS, EDUCATIVOS, CULTURALES Y OTROS SERVICIOS SOCIALES, EXCEPTO SERVICIOS DE SEGURIDAD SOCIAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2697,'O84121','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2698,'O841211','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN SALUD; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESTE ÁMBITO Y DE LOS FONDOS CORRESPONDIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2699,'O841212','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN EDUCACIÓN, CULTURA Y DEPORTE; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESOS ÁMBITOS Y DE LOS FONDOS CORRESPONDIENTES, CONCESIÓN DE BECAS PÚBLICAS A ARTISTAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2700,'O841213','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN ESPARCIMIENTO; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESTE ÁMBITO Y DE LOS FONDOS CORRESPONDIENTES, PATROCINIO DE ACTIVIDADES RECREATIVAS Y CULTURALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2701,'O841214','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN MEDIO AMBIENTE; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESTE ÁMBITO Y DE LOS FONDOS CORRESPONDIENTES, ADMINISTRACIÓN DE PROGRAMAS DE PROTECCIÓN DEL MEDIO AMBIENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2702,'O841215','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN VIVIENDA; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESTE ÁMBITO Y DE LOS FONDOS CORRESPONDIENTES, ADMINISTRACIÓN DE PROGRAMAS DE VIVIENDA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2703,'O841216','ADMINISTRACIÓN PÚBLICA DE PROGRAMAS DESTINADOS A PROMOVER EL BIENESTAR PERSONAL EN SERVICIOS SOCIALES; ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO ADOPTADAS EN ESTE ÁMBITO Y DE LOS FONDOS CORRESPONDIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2704,'O84129','OTROS SERVICIOS SOCIALES, EXCEPTO SERVICIOS DE SEGURIDAD SOCIAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2705,'O841291','ACTIVIDADES DE ADMINISTRACIÓN DE PROGRAMA DE SUMINISTRO DE AGUA POTABLE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2706,'O841292','ACTIVIDADES DE ADMINISTRACIÓN DE SERVICIOS DE RECOLECCIÓN Y ELIMINACIÓN DE DESPERDICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2707,'O8413','REGULACIÓN Y FACILITACIÓN DE LA ACTIVIDAD ECONÓMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2708,'O84131','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS SECTORES ECONÓMICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2709,'O841311','ADMINISTRACIÓN Y REGULACIÓN PÚBLICA, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE LA AGRICULTURA, GANADERÍA, SILVICULTURA Y PESCA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2710,'O841312','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE LA ORDENACIÓN DE TIERRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2711,'O841313','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE ENERGÍA Y MINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2712,'O841314','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE INFRAESTRUCTURA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2713,'O841315','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE TRANSPORTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2714,'O841316','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE COMUNICACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2715,'O841317','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE HOTELES Y TURISMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2716,'O841318','ADMINISTRACIÓN Y REGULACIÓN PÚBLICAS, INCLUIDA LA CONCESIÓN DE SUBVENCIONES, DE LOS DISTINTOS SECTORES ECONÓMICOS DE COMERCIO AL POR MAYOR Y AL POR MENOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2717,'O84139','OTRAS ACTIVIDADES DE REGULACIÓN Y FACILITACIÓN DE LA ACTIVIDAD ECONÓMICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2718,'O841391','ADMINISTRACIÓN DE LAS POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO DESTINADAS A MEJORAR LOS RESULTADOS ECONÓMICOS Y DE LOS FONDOS CORRESPONDIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2719,'O841392','ADMINISTRACIÓN DE LAS CUESTIONES LABORALES DE CARÁCTER GENERAL Y APLICACIÓN DE MEDIDAS DE DESARROLLO REGIONAL, POR EJEMPLO: MEDIDAS TENDIENTES A REDUCIR EL DESEMPLEO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2720,'O842','PRESTACIÓN DE SERVICIOS A LA COMUNIDAD EN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2721,'O8421','RELACIONES EXTERIORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2722,'O84210','RELACIONES EXTERIORES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2723,'O842101','ADMINISTRACIÓN Y FUNCIONAMIENTO DEL MINISTERIO DE RELACIONES EXTERIORES DE LAS MISIONES DIPLOMÁTICAS, CONSULARES ACREDITADAS EN EL EXTRANJERO Y ANTE ORGANIZACIONES INTERNACIONALES; ADMINISTRACIÓN, DIRECCIÓN Y RESPALDO DE SERVICIOS INFORMATIVOS Y CULTURALES QUE SE PRESTAN EN EL EXTRANJERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2724,'O842102','GESTIÓN DE ASUNTOS RELACIONADOS CON EL COMERCIO EXTERIOR, LA FINANCIACIÓN INTERNACIONAL Y CUESTIONES DE CARÁCTER TÉCNICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2725,'O842103','SUMINISTRO DE AYUDA A OTROS PAÍSES, SEA O NO CANALIZADO A TRAVÉS DE ORGANISMOS INTERNACIONALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2726,'O842104','SUMINISTRO DE ASISTENCIA MILITAR A OTROS PAÍSES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2727,'O8422','ACTIVIDADES DE DEFENSA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2728,'O84220','ACTIVIDADES DE DEFENSA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2729,'O842201','ADMINISTRACIÓN, SUPERVISIÓN Y GESTIÓN DE ASUNTOS Y FUERZAS DE DEFENSA MILITAR DEL EJÉRCITO DE TIERRA, MARINA, FUERZA AÉREA Y ESPACIAL COMO: ACTIVIDADES DE FUERZAS DE RESERVA Y AUXILIARES DEL SISTEMA DE DEFENSA, LOGÍSTICA MILITAR (ABASTECIMIENTO DE EQUIPO, ESTRUCTURAS, SUMINISTROS, ETCÉTERA), ACTIVIDADES SANITARIAS PARA EL PERSONAL MILITAR EN CAMPAÑA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2730,'O842202','ACTIVIDADES DE MANDOS Y FUERZAS DE INGENIERÍA, TRANSPORTE, COMUNICACIONES, INTELIGENCIA, SUMINISTRO DE MATERIALES, PERSONAL Y OTRAS FUERZAS CONEXAS NO DESTINADOS AL COMBATE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2731,'O842203','ACTIVIDADES DE ADMINISTRACIÓN, GESTIÓN Y EL RESPALDO DE FUERZAS DE DEFENSA CIVIL, PRESTACIÓN DE APOYO A LA ELABORACIÓN DE PLANES DE EMERGENCIA Y LA EJECUCIÓN DE MANIOBRAS CON LA PARTICIPACIÓN DE INSTITUCIONES CIVILES Y DE LA POBLACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2732,'O842204','ADMINISTRACIÓN DE POLÍTICAS DE INVESTIGACIÓN Y DESARROLLO RELACIONADAS CON LA DEFENSA Y LOS FONDOS CORRESPONDIENTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2733,'O8423','ACTIVIDADES DE MANTENIMIENTO DEL ORDEN PÚBLICO Y DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2734,'O84230','ACTIVIDADES DE MANTENIMIENTO DEL ORDEN PÚBLICO Y DE SEGURIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2735,'O842301','ADMINISTRACIÓN Y DIRECCIÓN DE FUERZAS DE POLICÍA, REGULARES Y AUXILIARES QUE DEPENDEN DE LAS AUTORIDADES PÚBLICAS, DE FUERZAS DE VIGILANCIA PORTUARIA, FRONTERIZA Y COSTERA Y DE OTRAS FUERZAS ESPECIALES DE POLICÍA ENTRE CUYAS FUNCIONES SE CUENTAN LA ORDENACIÓN DEL TRÁFICO, EL REGISTRO DE EXTRANJEROS Y EL MANTENIMIENTO DE FICHEROS DE DETENIDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2736,'O842302','PREVENCIÓN Y EXTINCIÓN DE INCENDIOS: ADMINISTRACIÓN Y FUNCIONAMIENTO DE CUERPOS ORDINARIOS Y AUXILIARES DE BOMBEROS QUE DEPENDEN DE LAS AUTORIDADES PÚBLICAS QUE REALIZAN ACTIVIDADES DE PREVENCIÓN Y EXTINCIÓN DE INCENDIOS, RESCATE DE PERSONAS Y ANIMALES, ASISTENCIA EN DESASTRES CÍVICOS, INUNDACIONES, ACCIDENTES DE TRÁFICO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2737,'O842303','ADMINISTRACIÓN Y FUNCIONAMIENTO DE TRIBUNALES CIVILES, ADMINISTRATIVOS Y PENALES, DE TRIBUNALES MILITARES Y DEL SISTEMA JUDICIAL EN GENERAL, INCLUIDO EL DESEMPEÑO DE FUNCIONES DE REPRESENTACIÓN JURÍDICA Y ASISTENCIA LETRADA EN NOMBRE DEL SECTOR PÚBLICO Y EN NOMBRE DE TERCEROS, CUANDO HAY FONDOS O SERVICIOS PÚBLICOS PREVISTOS CON ESE OBJETO; EMISIÓN DE FALLOS E INTERPRETACIÓN DE LA LEY Y ARBITRAJE EN PROCEDIMIENTOS CIVILES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2738,'O842304','ADMINISTRACIÓN DE PRISIONES Y PRESTACIÓN DE SERVICIOS CORRECCIONALES, INCLUIDOS LOS DE REHABILITACIÓN, INDEPENDIENTEMENTE DE QUE SU ADMINISTRACIÓN Y GESTIÓN SE ENCOMIENDE A UNIDADES PÚBLICAS O A UNIDADES PRIVADAS A CAMBIO DE UNA RETRIBUCIÓN O POR CONTRATO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2739,'O842305','ACTIVIDADES DE ABASTECIMIENTO DE SUMINISTROS PARA SU UTILIZACIÓN EN SITUACIONES DE EMERGENCIA INTERNA EN TIEMPOS DE PAZ CAUSADAS POR DESASTRES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2740,'O843','ACTIVIDADES DE PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2741,'O8430','ACTIVIDADES DE PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2742,'O84300','ACTIVIDADES DE PLANES DE SEGURIDAD SOCIAL DE AFILIACIÓN OBLIGATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2743,'O843000','FINANCIACIÓN Y ADMINISTRACIÓN DE LOS PROGRAMAS DE SERVICIOS PÚBLICOS DE SEGURIDAD SOCIAL: SEGUROS DE ENFERMEDAD, CONTRA ACCIDENTES LABORALES Y DE DESEMPLEO, PENSIONES DE JUBILACIÓN, PROGRAMAS QUE CUBREN LA PÉRDIDA DE INGRESOS EN CASOS DE MATERNIDAD, INCAPACIDAD TEMPORAL, VIUDEZ, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2744,'P','ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2745,'P85','ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2746,'P851','ENSEÑANZA PREPRIMARIA Y PRIMARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2747,'P8510','ENSEÑANZA PREPRIMARIA Y PRIMARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2748,'P85101','ENSEÑANZA PREPRIMARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2749,'P851011','LA EDUCACIÓN PREPRIMARIA O INICIAL (ES EL PROCESO DE ACOMPAÑAMIENTO AL DESARROLLO INTEGRAL QUE CONSIDERA LOS ASPECTOS COGNITIVOS, AFECTIVO, PSICOMOTRIZ, SOCIAL, DE IDENTIDAD, AUTONOMÍA Y PERTINENCIA A LA COMUNIDAD DISEÑADA PRINCIPALMENTE PARA INTRODUCIR A LOS NIÑOS Y NIÑAS, DESDE LOS TRES AÑOS HASTA LOS CINCO AÑOS DE EDAD EN UN ENTORNO EDUCATIVO DE TIPO ESCOLAR, ES DECIR, SERVIR DE PUENTE ENTRE EL HOGAR Y EL MEDIO ESCOLAR).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2750,'P851012','EDUCACIÓN PREPRIMARIA Ó INICIAL ESPECIAL, PARA ALUMNOS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2751,'P85102','ENSEÑANZA PRIMARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2752,'P851021','EDUCACIÓN PRIMARIA (DESARROLLA LAS CAPACIDADES, HABILIDADES, DESTREZAS Y COMPETENCIAS DE LAS NIÑAS, NIÑOS Y ADOLESCENTES, ESTÁ COMPUESTA POR SIETE AÑOS DE ESTUDIOS, COMPRENDE EL IMPARTIR FORMACIÓN ACADÉMICA Y OTRAS TAREAS RELACIONADAS A LOS ESTUDIANTES DE PRIMERO HASTA SÉPTIMO DE BÁSICA, QUE PROPORCIONAN UNA SÓLIDA EDUCACIÓN PARA LECTURA, ESCRITURA Y MATEMÁTICAS, ASÍ COMO UN NIVEL ELEMENTAL DE COMPRENSIÓN DE DISCIPLINAS COMO: HISTORIA, GEOGRAFÍA, CIENCIAS, ETCÉTERA; PUEDE SER PROVISTA EN SALONES DE CLASES O A TRAVÉS DE RADIO, TELEVISIÓN, INTERNET, CORRESPONDENCIA O EN EL HOGAR, INCLUYE LAS ACTIVIDADES DE ESCUELAS UNIDOCENTES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2753,'P851022','EDUCACIÓN PRIMARIA ESPECIAL, PARA ALUMNOS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2754,'P851023','PROGRAMAS DE ALFABETIZACIÓN PARA ADULTOS EN EL NIVEL PRIMARIO EDUCATIVO. LA EDUCACIÓN PUEDE SER PROVISTA EN SALONES DE CLASES O A TRAVÉS DE RADIO, TELEVISIÓN, INTERNET, CORRESPONDENCIA O EN EL HOGAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2755,'P852','ENSEÑANZA SECUNDARIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2756,'P8521','ENSEÑANZA SECUNDARIA DE FORMACIÓN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2757,'P85210','ENSEÑANZA SECUNDARIA DE FORMACIÓN GENERAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2758,'P852101','EDUCACIÓN SECUNDARIA (COMPRENDE SEIS AÑOS DE EDUCACIÓN A CONTINUACIÓN DE LA EDUCACIÓN PRIMARIA, DESDE OCTAVO DE BÁSICA HASTA TERCERO DE BACHILLERATO, CURSANDO UN TRONCO COMÚN DE ASIGNATURAS GENERALES, OPTANDO POR UN BACHILLERATO EN CIENCIAS O TÉCNICO. LA EDUCACIÓN PUEDE SER PROVISTA EN SALONES DE CLASES O A TRAVÉS DE RADIO, TELEVISIÓN, INTERNET, CORRESPONDENCIA O EN EL HOGAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2759,'P852102','EDUCACIÓN EN BACHILLERATOS COMPLEMENTARIOS (FORTALECE LA FORMACIÓN OBTENIDA EN EL BACHILLERATO GENERAL UNIFICADO, ES DE CARÁCTER OPTATIVO Y SU DURACIÓN ES DE UN AÑO ADICIONAL Y PUEDEN SER DEL TIPO: BACHILLERATO TÉCNICO PRODUCTIVO Y BACHILLERATO ARTÍSTICO. LA EDUCACIÓN PUEDE SER PROVISTA EN SALONES DE CLASES O A TRAVÉS DE RADIO, TELEVISIÓN, INTERNET, CORRESPONDENCIA O EN EL HOGAR).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2760,'P852103','EDUCACIÓN ESPECIAL SECUNDARIA PARA ESTUDIANTES DISCAPACITADOS. LA EDUCACIÓN PUEDE SER PROVISTA EN SALONES DE CLASES O A TRAVÉS DE RADIO, TELEVISIÓN, INTERNET, CORRESPONDENCIA O EN EL HOGAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2761,'P8522','ENSEÑANZA DE FORMACIÓN TÉCNICA Y PROFESIONAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2762,'P85220','ENSEÑANZA SECUNDARIA DE FORMACIÓN TÉCNICA Y PROFESIONAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2763,'P852201','ENSEÑANZA TÉCNICA Y PROFESIONAL DE NIVEL INFERIOR AL DE LA ENSEÑANZA SUPERIOR, CAPACITACIÓN PARA GUÍAS TURÍSTICOS, COCINEROS Y OTRO PERSONAL DE HOTELES Y RESTAURANTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2764,'P852202','ESCUELAS DE CONDUCIR PARA CHÓFERES PROFESIONALES: DE CAMIONES, BUSES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2765,'P852203','ESCUELAS DE COSMÉTICA Y DE PELUQUERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2766,'P852204','EDUCACIÓN ESPECIAL, ENSEÑANZA DE FORMACIÓN TÉCNICA Y PROFESIONAL PARA ALUMNOS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2767,'P852205','CAPACITACIÓN EN REPARACIÓN DE COMPUTADORAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2768,'P853','ENSEÑANZA SUPERIOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2769,'P8530','ENSEÑANZA SUPERIOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2770,'P85300','ENSEÑANZA DE NIVEL SUPERIOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2771,'P853001','EDUCACIÓN DE POSTBACHILLERATO Y NIVEL TÉCNICO SUPERIOR, DESTINADO A LA FORMACIÓN Y CAPACITACIÓN PARA LABORES DE CARÁCTER OPERATIVO, CORRESPONDEN A ESTE NIVEL LOS TÍTULOS PROFESIONALES DE TÉCNICO O TECNÓLOGO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2772,'P853002','EDUCACIÓN DE TERCER NIVEL, DESTINADO A LA FORMACIÓN BÁSICA EN UNA DISCIPLINA O A LA CAPACITACIÓN PARA EL EJERCICIO DE UNA PROFESIÓN. CORRESPONDEN A ESTE NIVEL EL GRADO DE LICENCIADO Y LOS TÍTULOS PROFESIONALES UNIVERSITARIOS O POLITÉCNICOS, QUE SON EQUIVALENTES, INCLUIDO LAS ACTIVIDADES DE ESCUELAS DE ARTES INTERPRETATIVAS QUE IMPARTEN ENSEÑANZA SUPERIOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2773,'P853003','EDUCACIÓN DE CUARTO NIVEL O DE POSGRADO, DESTINADO A LA ESPECIALIZACIÓN CIENTÍFICA O ENTRENAMIENTO PROFESIONAL AVANZADO. CORRESPONDEN A ESTE NIVEL LOS TÍTULOS INTERMEDIOS DE POSTGRADO DE ESPECIALISTA Y DIPLOMA SUPERIOR Y LOS GRADOS DE MAGÍSTER Y DOCTOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2774,'P854','OTROS TIPOS DE ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2775,'P8541','ENSEÑANZA DEPORTIVA Y RECREATIVA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2776,'P85410','ENSEÑANZA DEPORTIVA Y RECREATIVA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2777,'P854101','ENSEÑANZA EN ADIESTRAMIENTO DEPORTIVO: BÉISBOL, BASKETBALL, VOLLEYBALL, FÚTBOL, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2778,'P854102','ENSEÑANZA DE GIMNASIA, YOGA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2779,'P854103','ENSEÑANZA DE EQUITACIÓN EN ACADEMIAS O ESCUELAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2780,'P854104','ENSEÑANZA DE NATACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2781,'P854105','ENSEÑANZA DE ARTES MARCIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2782,'P854109','OTRO TIPO DE ENSEÑANZA DEPORTIVA Y RECREATIVA COMO: ACTIVIDADES DE ADIESTRAMIENTO EN CAMPAMENTOS DEPORTIVOS, CLASES DE JUEGO DE CARTAS POR EJEMPLO BRIDGE, ACTIVIDADES DE INSTRUCTORES, PROFESORES Y ENTRENADORES DEPORTIVOS, ENSEÑANZA PARA ANIMADORES DEPORTIVOS','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2783,'P8542','ENSEÑANZA CULTURAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2784,'P85420','ENSEÑANZA CULTURAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2785,'P854201','CLASES DE PIANO Y OTRAS ACTIVIDADES DE FORMACIÓN MUSICAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2786,'P854202','ACTIVIDADES DE FORMACIÓN ARTÍSTICA, ESCUELAS DE TEATRO, ESCUELAS DE BELLAS ARTES Y ESCUELAS DE ARTES INTERPRETATIVAS (EXCEPTO LAS ACADÉMICAS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2787,'P854203','ESCUELAS Y ACADEMIAS DE BAILE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2788,'P854204','ESCUELAS DE FOTOGRAFÍA (EXCEPTO LAS COMERCIALES).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2789,'P8549','OTROS TIPOS DE ENSEÑANZA N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2790,'P85491','OTROS TIPOS DE FORMACIÓN EDUCACIONAL PARA DESARROLLO PERSONAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2791,'P854911','ACTIVIDADES DE ENSEÑANZA QUE NO PUEDE ASIGNARSE A UN NIVEL DETERMINADO, INCLUYE LOS PROCESOS DE FORMACIÓN DOCENTE DE CAPACITACIÓN Y PERFECCIONAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2792,'P854912','ACTIVIDADES DE SERVICIOS DE  DEBERES DIRIGIDOS, TUTORÍA ACADÉMICA, PREPARACIÓN PARA EL INGRESO A LA UNIVERSIDAD, CENTROS DE ENSEÑANZA QUE OFRECEN CURSOS DE RECUPERACIÓN Y CURSOS DE REPASO PARA EXÁMENES PROFESIONALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2793,'P854913','ACTIVIDADES DE ENSEÑANZA DE IDIOMAS Y CLASES DE CONVERSACIÓN.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2794,'P854914','ACTIVIDADES DE ENSEÑANZA DE MÉTODOS DE LECTURA RÁPIDA Y CURSOS DE ORATORIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2795,'P854915','ACTIVIDADES DE FORMACIÓN RELIGIOSA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2796,'P854916','ACTIVIDADES DE CENTROS DE CAPACITACIÓN ARTESANAL: CORTE Y CONFECCIÓN, CARPINTERÍA, TALLADO EN MADERA, MANUALIDADES, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2797,'P854917','ACTIVIDADES DE CAPACITACIÓN EN INFORMÁTICA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2798,'P85499','OTROS TIPOS DE ENSEÑANZA N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2799,'P854991','ACTIVIDADES DE ESCUELAS DE CONDUCIR QUE NO CONCEDEN CERTIFICADOS NI PERMISOS PROFESIONALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2800,'P854992','ACTIVIDADES DE ESCUELAS DE VUELO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2801,'P854993','ACTIVIDADES DE CAPACITACIÓN DE SOCORRISTAS Y CURSOS DE SUPERVIVENCIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2802,'P855','ACTIVIDADES DE APOYO A LA ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2803,'P8550','ACTIVIDADES DE APOYO A LA ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2804,'P85500','ACTIVIDADES DE APOYO A LA ENSEÑANZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2805,'P855000','PRESTACIÓN DE SERVICIOS NO EDUCATIVOS DE APOYO A PROCESOS O SISTEMAS EDUCATIVOS COMO CONSULTORÍA DE EDUCACIÓN, ORIENTACIÓN EDUCATIVA, SERVICIOS DE EXÁMENES Y EVALUACIÓN DE LOS MISMOS, ORGANIZACIÓN DE PROGRAMAS DE INTERCAMBIO DE ESTUDIANTES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2806,'Q','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA Y DE ASISTENCIA SOCIAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2807,'Q86','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2808,'Q861','ACTIVIDADES DE HOSPITALES Y CLÍNICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2809,'Q8610','ACTIVIDADES DE HOSPITALES Y CLÍNICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2810,'Q86100','ACTIVIDADES DE HOSPITALES Y CLÍNICAS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2811,'Q861001','ACTIVIDADES A CORTO Y A LARGO PLAZO DE LOS HOSPITALES BÁSICOS Y GENERALES, ES DECIR, ACTIVIDADES MÉDICAS, DE DIAGNÓSTICO Y DE TRATAMIENTO (HOSPITALES: COMUNITARIOS Y REGIONALES, DE ORGANIZACIONES SIN FINES DE LUCRO, UNIVERSITARIOS, DE BASES MILITARES Y DE PRISIONES, DEL MINISTERIO DE GOBIERNO Y POLICÍA, DEL MINISTERIO DE DEFENSA NACIONAL, DE LA JUNTA DE BENEFICENCIA, DEL SEGURO SOCIAL, FISCO MISIONALES).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2812,'Q861002','ACTIVIDADES A CORTO Y A LARGO PLAZO DE CLÍNICAS DEL DÍA, BÁSICAS Y GENERALES, ES DECIR, ACTIVIDADES MÉDICAS, DE DIAGNÓSTICO Y DE TRATAMIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2813,'Q861003','ACTIVIDADES A CORTO Y A LARGO PLAZO DE LOS HOSPITALES ESPECIALIZADOS, ES DECIR, ACTIVIDADES MÉDICAS, DE DIAGNÓSTICO Y DE TRATAMIENTO (HOSPITALES PARA ENFERMOS MENTALES, CENTROS DE REHABILITACIÓN, HOSPITALES PARA ENFERMEDADES INFECCIOSAS, DE MATERNIDAD, SANATORIOS ESPECIALIZADOS, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2814,'Q861004','ACTIVIDADES A CORTO Y A LARGO PLAZO DE CLÍNICAS ESPECIALIZADAS, ES DECIR, ACTIVIDADES MÉDICAS, DE DIAGNÓSTICO Y DE TRATAMIENTO (CLÍNICAS PARA ENFERMOS MENTALES, DE REHABILITACIÓN, PARA ENFERMEDADES INFECCIOSAS, DE MATERNIDAD, ETCÉTERA).','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2815,'Q861005','SERVICIOS DE CENTROS DE PLANIFICACIÓN FAMILIAR QUE PROVEE TRATAMIENTOS MÉDICOS, COMO LOS DE ESTERILIZACIÓN Y DE INTERRUPCIÓN DEL EMBARAZO, CON ALOJAMIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2816,'Q862','ACTIVIDADES DE MÉDICOS Y ODONTÓLOGOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2817,'Q8620','ACTIVIDADES DE MÉDICOS Y ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2818,'Q86200','ACTIVIDADES DE MÉDICOS Y ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2819,'Q862001','CONSULTA Y TRATAMIENTO POR MÉDICOS GENERALES Y ESPECIALISTAS. ESTAS ACTIVIDADES PUEDEN REALIZARSE EN CONSULTORIOS PRIVADOS, EN CONSULTORIOS COLECTIVOS, EN CLÍNICAS AMBULATORIAS, EN CLÍNICAS ANEXAS A EMPRESAS, ESCUELAS, RESIDENCIAS DE ANCIANOS U ORGANIZACIONES SINDICALES O FRATERNALES Y EN LOS PROPIOS DOMICILIOS DE LOS PACIENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2820,'Q862002','ACTIVIDADES DE ATENCIÓN ODONTOLÓGICA DE CARÁCTER GENERAL O ESPECIALIZADO, POR EJEMPLO, ODONTOLOGÍA, ENDODONCIA Y ODONTOLOGÍA PEDIÁTRICA; ESTOMATOLOGÍA; ORTODONCIA. ESTAS ACTIVIDADES PUEDEN REALIZARSE EN CONSULTORIOS PRIVADOS, EN CONSULTORIOS COLECTIVOS, EN CLÍNICAS AMBULATORIAS, EN CLÍNICAS ANEXAS A EMPRESAS, ESCUELAS, RESIDENCIAS DE ANCIANOS U ORGANIZACIONES SINDICALES O FRATERNALES Y EN LOS PROPIOS DOMICILIOS DE LOS PACIENTES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2821,'Q862003','SERVICIOS DE CENTROS DE PLANIFICACIÓN FAMILIAR QUE PROVEE TRATAMIENTOS MÉDICOS, COMO LOS DE ESTERILIZACIÓN Y DE INTERRUPCIÓN DEL EMBARAZO, SIN ALOJAMIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2822,'Q862004','ACTIVIDADES DE ATENCIÓN ODONTOLÓGICA EN SALAS DE OPERACIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2823,'Q862005','SERVICIOS DE ASISTENCIA MÉDICA PRIVADA A PACIENTES INTERNOS POR MÉDICOS EXTERNOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2824,'Q869','OTRAS ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2825,'Q8690','OTRAS ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2826,'Q86901','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA QUE NO SE REALIZAN EN HOSPITALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2827,'Q869011','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR ENFERMEROS, ENFERMERAS Y AUXILIARES DE ENFERMERÍA, QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2828,'Q869012','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR PERSONAL PARAMÉDICO ESPECIALIZADO QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2829,'Q869013','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR PERSONAL ESPECIALIZADO EN OPTOMETRÍA Y OFTALMOLOGÍA QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2830,'Q869014','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR PERSONAL ESPECIALIZADO EN QUIROPRÁCTICA, QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2831,'Q869015','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR PERSONAL ESPECIALIZADO EN ACUPUNTURA, QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2832,'Q869016','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR PERSONAL ESPECIALIZADO EN HOMEOPATÍA, QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2833,'Q869017','ACTIVIDADES DE ATENCIÓN DE LA SALUD HUMANA REALIZADAS POR: PARTERAS,  PERSONAL ESPECIALIZADO EN FISIOTERAPIA, HIDROTERAPIA, MASAJE TERAPÉUTICO, ERGOTERAPIA, LOGOTERAPIA, PODOLOGÍA, ETCÉTERA; QUE NO SE LLEVAN A CABO EN HOSPITALES NI ENTRAÑAN LA PARTICIPACIÓN DE MÉDICOS NI DE ODONTÓLOGOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2834,'Q869018','ACTIVIDADES DE PERSONAL PARAMÉDICO DE ODONTOLOGÍA,  COMO TERAPEUTAS DENTALES, ENFERMEROS ESCOLARES CON CONOCIMIENTOS DE ODONTOLOGÍA E HIGIENISTAS DENTALES, QUE PUEDEN ATENDER A PACIENTES SIN LA PRESENCIA DEL ODONTÓLOGO PERO SON SUPERVISADOS PERIÓDICAMENTE POR ÉSTE.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2835,'Q86902','ACTIVIDADES DE LABORATORIOS MÉDICOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2836,'Q869021','ACTIVIDADES DE LABORATORIOS DE RADIOLOGÍA (RAYOS X) Y OTROS CENTROS DE DIAGNÓSTICO POR IMAGEN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2837,'Q869022','ACTIVIDADES DE LABORATORIOS CLÍNICOS DE ANÁLISIS DE SANGRE, ORINA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2838,'Q86909','OTROS SERVICIOS AUXILIARES DE LA SALUD HUMANA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2839,'Q869091','TRANSPORTE DE PACIENTES EN AMBULANCIAS CORRIENTES Y AMBULANCIAS AÉREAS. ESTOS SERVICIOS SE PRESTAN A MENUDO DURANTE UNA SITUACIÓN DE EMERGENCIA MÉDICA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2840,'Q869092','ACTIVIDADES DE BANCO DE SANGRE, DE ESPERMA, DE ÓRGANOS PARA TRANSPLANTES, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2841,'Q869099','OTROS SERVICIOS AUXILIARES AL TRATAMIENTO MÉDICO N.C.P. COMO APLICACIÓN DE VACUNAS, MEDICIÓN DE LA PRESIÓN ARTERIAL Y LA CAPACIDAD AUDITIVA, ETCÉTERA.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2842,'Q87','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2843,'Q871','ACTIVIDADES DE ATENCIÓN DE ENFERMERÍA EN INSTITUCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2844,'Q8710','ACTIVIDADES DE ATENCIÓN DE ENFERMERÍA EN INSTITUCIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2845,'Q87100','ACTIVIDADES DE ATENCIÓN DE ENFERMERÍA EN INSTITUCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2846,'Q871001','ACTIVIDADES DE RESIDENCIAS DE ANCIANOS CON ATENCIÓN DE ENFERMERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2847,'Q871002','ACTIVIDADES DE CASAS DE CONVALECENCIA, CLÍNICAS DE REPOSO CON ATENCIÓN DE ENFERMERÍA Y RESIDENCIAS CON CUIDADOS DE ENFERMERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2848,'Q871003','ACTIVIDADES DE CASAS DE SALUD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2849,'Q872','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS CON RETRASO MENTAL, ENFERMOS MENTALES Y TOXICÓMANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2850,'Q8720','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS CON RETRASO MENTAL, ENFERMOS MENTALES Y TOXICÓMANOS.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2851,'Q87200','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS CON RETRASO MENTAL, ENFERMOS MENTALES Y TOXICÓMANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2852,'Q872001','SERVICIOS DE ATENCIÓN EN INSTALACIONES PARA EL TRATAMIENTO DEL ALCOHOLISMO Y LA DROGODEPENDENCIA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2853,'Q872002','SERVICIOS DE ATENCIÓN EN CASAS DE CONVALECENCIA PSIQUIÁTRICA, SERVICIOS DE ATENCIÓN EN HOGARES RESIDENCIALES COLECTIVOS PARA PERSONAS CON PERTURBACIONES EMOCIONALES Y SERVICIOS DE ATENCIÓN EN HOGARES DE TRANSICIÓN PARA ENFERMOS MENTALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2854,'Q872003','SERVICIOS DE ATENCIÓN EN INSTALACIONES PARA PERSONAS CON RETRASO MENTAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2855,'Q873','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2856,'Q8730','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2857,'Q87300','ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2858,'Q873001','ACTIVIDADES DE ATENCIÓN EN INSTALACIONES RESIDENCIALES CON ASISTENCIA PARA LA VIDA COTIDIANA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2859,'Q873002','ACTIVIDADES DE ATENCIÓN EN HOGARES DE ANCIANOS CON ATENCIÓN MÍNIMA DE ENFERMERÍA, ACTIVIDADES DE ATENCIÓN EN CASAS DE REPOSO SIN ATENCIÓN DE ENFERMERÍA Y ACTIVIDADES DE ATENCIÓN EN COMUNIDADES DE JUBILADOS CON ATENCIÓN PERMANENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2860,'Q879','OTRAS ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2861,'Q8790','OTRAS ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2862,'Q87900','OTRAS ACTIVIDADES DE ATENCIÓN EN INSTITUCIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2863,'Q879001','ACTIVIDADES DESTINADAS A PROPORCIONAR ASISTENCIA SOCIAL LAS 24 HORAS DEL DÍA A NIÑOS Y A DETERMINADAS CATEGORÍAS DE PERSONAS QUE NO PUEDEN VALERSE PLENAMENTE POR SÍ MISMAS, EN LAS QUE EL TRATAMIENTO MÉDICO O LA ENSEÑANZA NO SON COMPONENTES IMPORTANTES, COMO: ORFANATOS, HOGARES Y ALBERGUES INFANTILES, ALBERGUES TEMPORALES PARA PERSONAS SIN HOGAR E INSTITUCIONES QUE ATIENDEN A MADRES SOLTERAS Y A SUS HIJOS. ESTAS ACTIVIDADES PUEDEN SER REALIZADAS POR ORGANIZACIONES PÚBLICAS O PRIVADAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2864,'Q879002','ACTIVIDADES DE ATENCIÓN EN HOGARES DE TRANSICIÓN COLECTIVOS PARA PERSONAS CON PROBLEMAS SOCIALES O PERSONALES, HOGARES DE TRANSICIÓN PARA DELINCUENTES Y CAMPAMENTOS DISCIPLINARIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2865,'Q88','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2866,'Q881','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2867,'Q8810','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2868,'Q88100','ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO PARA PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2869,'Q881000','SERVICIOS SOCIALES, DE ASESORAMIENTO, DE BIENESTAR SOCIAL, DE REMISIÓN Y SERVICIOS SIMILARES QUE PRESTAN A PERSONAS DE EDAD Y PERSONAS CON DISCAPACIDAD, EN SUS DOMICILIOS O EN OTROS LUGARES, ORGANIZACIONES PÚBLICAS O PRIVADAS, ORGANIZACIONES NACIONALES O LOCALES DE AUTOAYUDA Y ESPECIALISTAS EN SERVICIOS DE ASESORAMIENTO COMO VISITAS A ANCIANOS Y ENFERMOS, ACTIVIDADES DE ATENCIÓN DIURNA PARA ANCIANOS Y ADULTOS CON DISCAPACIDAD Y ACTIVIDADES DE ADIESTRAMIENTO Y READAPTACIÓN PROFESIONAL PARA PERSONAS CON DISCAPACIDAD, SIEMPRE QUE EL COMPONENTE DE EDUCACIÓN SEA LIMITADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2870,'Q889','OTRAS ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2871,'Q8890','OTRAS ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2872,'Q88900','OTRAS ACTIVIDADES DE ASISTENCIA SOCIAL SIN ALOJAMIENTO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2873,'Q889001','ACTIVIDADES DE GUARDERÍA O ATENCIÓN DIURNA DE NIÑOS, INCLUYENDO EL CUIDADO DIURNO DE NIÑOS CON DISCAPACIDAD.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2874,'Q889002','SERVICIOS DIURNOS PARA PERSONAS SIN HOGAR Y OTROS GRUPOS SOCIALMENTE DESFAVORECIDOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2875,'Q889003','ACTIVIDADES DE BIENESTAR SOCIAL Y DE ORIENTACIÓN PARA NIÑOS Y ADOLESCENTES, ACTIVIDADES DE ADOPCIÓN Y ACTIVIDADES PARA PREVENIR LA CRUELDAD CONTRA LOS NIÑOS Y OTRAS PERSONAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2876,'Q889004','SERVICIOS DE ASESORAMIENTO EN ECONOMÍA DOMÉSTICA, DE ORIENTACIÓN MATRIMONIAL Y FAMILIAR, ASESORAMIENTO EN CUESTIONES CREDITICIAS Y DE DEUDA, ACTIVIDADES COMUNITARIAS Y VECINALES Y ACTIVIDADES DE REHABILITACIÓN Y HABILITACIÓN PROFESIONAL PARA PERSONAS DESEMPLEADAS, SIEMPRE QUE EL COMPONENTE DE EDUCACIÓN SEA LIMITADO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2877,'Q889005','ACTIVIDADES DE DETERMINACIÓN DEL DERECHO A RECIBIR PRESTACIONES SOCIALES, SUBSIDIOS DE ALQUILER O CUPONES DE ALIMENTOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2878,'Q889009','ACTIVIDADES DE AYUDA A VÍCTIMAS DE DESASTRES, REFUGIADOS, INMIGRANTES, ETCÉTERA, INCLUIDO EL SUMINISTRO DE ALOJAMIENTO A ESAS PERSONAS A TÍTULO TEMPORAL O POR PERÍODOS PROLONGADOS, ACTIVIDADES DE BENEFICENCIA, COMO RECAUDACIÓN DE FONDOS Y OTRAS ACTIVIDADES DE APOYO CON FINES DE ASISTENCIA SOCIAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2879,'R','ARTES, ENTRETENIMIENTO Y RECREACIÓN.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2880,'R90','ACTIVIDADES CREATIVAS, ARTÍSTICAS Y DE ENTRETENIMIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2881,'R900','ACTIVIDADES CREATIVAS, ARTÍSTICAS Y DE ENTRETENIMIENTO.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2882,'R9000','ACTIVIDADES CREATIVAS, ARTÍSTICAS Y DE ENTRETENIMIENTO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2883,'R90000','ACTIVIDADES CREATIVAS, ARTÍSTICAS Y DE ENTRETENIMIENTO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2884,'R900001','PRODUCCIÓN DE OBRAS DE TEATRO, CONCIERTOS, ÓPERAS, ESPECTÁCULOS DE DANZA Y OTRAS ACTIVIDADES ESCÉNICAS COMO LAS ACTIVIDADES DE GRUPOS, CIRCOS O COMPAÑÍAS, ORQUESTAS O BANDAS, INCLUIDO ACTIVIDADES COMPLEMENTARIAS PARA LA PRODUCCIÓN Y OTRAS ACTIVIDADES ESCÉNICAS REALIZADAS EN DIRECTO COMO: ACTIVIDADES DE DIRECTORES, PRODUCTORES, DISEÑADORES Y CONSTRUCTORES DE ESCENARIOS, TRAMOYISTAS, MANEJO DE TELONES, TÉCNICOS DE ILUMINACIÓN Y SONIDO, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2885,'R900002','ACTIVIDADES DE ARTISTAS INDIVIDUALES, COMO ESCRITORES, DIRECTORES,  MÚSICOS, CONFERENCISTAS U ORADORES, ESCENÓGRAFOS, CONSTRUCTORES DE DECORADOS, ETCÉTERA; ESCRITORES DE TODO TIPO, POR EJEMPLO, OBRAS DE FICCIÓN, DE OBRAS TÉCNICAS, ETCÉTERA., ACTIVIDADES DE ESCULTORES, PINTORES, DIBUJANTES, CARICATURISTAS, GRABADORES, ETCÉTERA, SE INCLUYE LA RESTAURACIÓN DE OBRAS DE ARTE, COMO CUADROS, ETCÉTERA Y ACTIVIDADES DE LOS MODELOS INDEPENDIENTES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2886,'R900003','GESTIÓN DE SALAS DE CONCIERTOS, TEATROS Y OTRAS INSTALACIONES SIMILARES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2887,'R900004','ACTIVIDADES DE PRODUCTORES O EMPRESARIOS DE ESPECTÁCULOS ARTÍSTICOS EN VIVO, APORTEN O NO ELLOS MISMOS LAS INSTALACIONES CORRESPONDIENTES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2888,'R900005','ACTIVIDADES DE PERIODISTAS INDEPENDIENTES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2889,'R91','ACTIVIDADES DE BIBLIOTECAS, ARCHIVOS, MUSEOS Y OTRAS ACTIVIDADES CULTURALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2890,'R910','ACTIVIDADES DE BIBLIOTECAS, ARCHIVOS, MUSEOS Y OTRAS ACTIVIDADES CULTURALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2891,'R9101','ACTIVIDADES DE BIBLIOTECAS Y ARCHIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2892,'R91010','ACTIVIDADES DE BIBLIOTECAS Y ARCHIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2893,'R910100','ACTIVIDADES DE DOCUMENTACIÓN E INFORMACIÓN REALIZADAS POR BIBLIOTECAS DE TODO TIPO, SALAS DE LECTURA, AUDICIÓN Y PROYECCIÓN, ARCHIVOS PÚBLICOS ABIERTOS AL PÚBLICO EN GENERAL O A DETERMINADAS CATEGORÍAS DE PERSONAS, COMO ESTUDIANTES, CIENTÍFICOS, EMPLEADOS DE LA ORGANIZACIÓN A LA QUE PERTENECE LA BIBLIOTECA, Y GESTIÓN DE ARCHIVOS DE LA ADMINISTRACIÓN PÚBLICA: ORGANIZACIÓN DE FONDOS BIBLIOGRÁFICOS, CATALOGACIÓN DE COLECCIONES, MANTENIMIENTO Y PRÉSTAMO DE LIBROS, MAPAS, REVISTAS, PELÍCULAS, DISCOS, CINTAS GRABADAS, OBRAS DE ARTE, ETCÉTERA; ACTIVIDADES DE BÚSQUEDA PARA ATENDER A SOLICITUDES DE INFORMACIÓN, SERVICIO DE ARCHIVOS FOTOGRÁFICOS Y BANCOS DE IMÁGENES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2894,'R9102','ACTIVIDADES DE MUSEOS Y GESTIÓN DE LUGARES Y EDIFICIOS HISTÓRICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2895,'R91020','ACTIVIDADES DE MUSEOS Y GESTIÓN DE LUGARES Y EDIFICIOS HISTÓRICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2896,'R910200','ACTIVIDADES DE MUSEOS DE ARTE, ORFEBRERÍA, MUEBLES, TRAJES, CERÁMICA, PLATERÍA, MUSEOS DE HISTORIA NATURAL Y DE CIENCIAS, MUSEOS TECNOLÓGICOS, HISTÓRICOS, MILITARES Y AL AIRE LIBRE; SE INCLUYE LA GESTIÓN DE LUGARES Y EDIFICIOS HISTÓRICOS Y OTROS MUSEOS ESPECIALIZADOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2897,'R9103','ACTIVIDADES DE JARDINES BOTÁNICOS Y ZOOLÓGICOS Y RESERVAS NATURALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2898,'R91030','ACTIVIDADES DE JARDINES BOTÁNICOS Y ZOOLÓGICOS Y RESERVAS NATURALES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2899,'R910301','GESTIÓN DE JARDINES BOTÁNICOS Y ZOOLÓGICOS, INCLUIDOS ZOOLÓGICOS INFANTILES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2900,'R910302','GESTIÓN DE RESERVAS NATURALES, INCLUIDAS LAS ACTIVIDADES DE PRESERVACIÓN DE LA FLORA Y FAUNA SILVESTRES, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2901,'R92','ACTIVIDADES DE JUEGOS DE AZAR Y APUESTAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2902,'R920','ACTIVIDADES DE JUEGOS DE AZAR Y APUESTAS.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (2903,'R9200','ACTIVIDADES DE JUEGOS DE AZAR Y APUESTAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2904,'R92000','ACTIVIDADES DE JUEGOS DE AZAR Y APUESTAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2905,'R920001','VENTA DE BOLETOS DE LOTERÍA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2906,'R920002','GESTIÓN (EXPLOTACIÓN) DE MÁQUINAS DE JUEGOS DE AZAR ACCIONADAS CON MONEDAS Y EXPLOTACIÓN DE CASINOS, INCLUIDOS CASINOS FLOTANTES, BILLARES, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2907,'R920003','GESTIÓN DE SITIOS DE INTERNET DEDICADOS A LOS JUEGOS DE AZAR VIRTUALES, VIDEOJUEGOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2908,'R920004','APUESTAS SOBRE CARRERAS DE CABALLOS EN EL PROPIO HIPÓDROMO Y FUERA DEL HIPÓDROMO Y OTROS SERVICIOS DE APUESTAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2909,'R93','ACTIVIDADES DEPORTIVAS, DE ESPARCIMIENTO Y RECREATIVAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2910,'R931','ACTIVIDADES DEPORTIVAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2911,'R9311','EXPLOTACIÓN DE INSTALACIONES DEPORTIVAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2912,'R93110','EXPLOTACIÓN DE INSTALACIONES DEPORTIVAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2913,'R931101','EXPLOTACIÓN DE INSTALACIONES PARA ACTIVIDADES DEPORTIVAS BAJO TECHO O AL AIRE LIBRE (ABIERTAS, CERRADAS O TECHADAS, CON ASIENTOS PARA ESPECTADORES): CAMPOS Y ESTADIOS DE FÚTBOL, HOCKEY, BÉISBOL, ESTADIOS DE ATLETISMO, PISCINAS, CAMPOS DE GOLF, CIRCUITOS DE CARRERAS DE AUTOMÓVILES, CANÓDROMOS, HIPÓDROMOS, PISTAS Y ESTADIOS PARA DEPORTES DE INVIERNO Y PISTAS DE HOCKEY SOBRE HIELO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2914,'R931102','EXPLOTACIÓN DE INSTALACIONES PARA ACTIVIDADES DEPORTIVAS BAJO TECHO O AL AIRE LIBRE (ABIERTAS, CERRADAS O TECHADAS, CON ASIENTOS O SIN ELLOS PARA ESPECTADORES): PABELLONES DE BOXEO Y GIMNASIOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2915,'R931103','ORGANIZACIÓN Y GESTIÓN DE COMPETENCIAS DEPORTIVAS AL AIRE LIBRE O BAJO TECHO CON PARTICIPACIÓN DE DEPORTISTAS PROFESIONALES O AFICIONADOS, POR PARTE DE ORGANIZACIONES CON INSTALACIONES PROPIAS. SE INCLUYEN LA GESTIÓN DE ESAS INSTALACIONES Y LA DOTACIÓN DEL PERSONAL NECESARIO PARA SU FUNCIONAMIENTO.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2916,'R931104','EXPLOTACIÓN DE INSTALACIONES PARA ACTIVIDADES DEPORTIVAS BAJO TECHO O AL AIRE LIBRE (ABIERTAS, CERRADAS O TECHADAS, CON ASIENTOS O SIN ELLOS PARA ESPECTADORES): BOLERAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2917,'R9312','ACTIVIDADES DE CLUBES DEPORTIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2918,'R93120','ACTIVIDADES DE CLUBES DEPORTIVOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2919,'R931200','ACTIVIDADES DE CLUBES DEPORTIVOS PROFESIONALES, SEMIPROFESIONALES O DE AFICIONADOS QUE OFRECEN A SUS MIEMBROS LA OPORTUNIDAD DE PARTICIPAR EN ACTIVIDADES DEPORTIVAS, SE INCLUYEN LAS SIGUIENTES ACTIVIDADES: CLUBES DE FÚTBOL, CLUBES DE BOLOS, CLUBES DE NATACIÓN, CLUBES DE GOLF, CLUBES DE BOXEO, CLUBES DE FÍSICO CULTURISMO, CLUBES DE DEPORTES DE INVIERNO, CLUBES DE AJEDREZ, CLUBES DE ATLETISMO, CLUBES DE TIRO, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2920,'R9319','OTRAS ACTIVIDADES DEPORTIVAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2921,'R93190','OTRAS ACTIVIDADES DEPORTIVAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2922,'R931901','ACTIVIDADES DE PRODUCTORES PROMOTORES Y ACTIVIDADES RELACIONADAS CON LA PROMOCIÓN DE COMPETENCIAS DEPORTIVAS, CON O SIN INSTALACIONES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2923,'R931902','ACTIVIDADES POR CUENTA PROPIA DE DEPORTISTAS Y ATLETAS, ÁRBITROS, JUECES, CRONOMETRADORES, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2924,'R931903','ACTIVIDADES DE LAS LIGAS DEPORTIVAS Y DE ÓRGANOS REGULADORES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2925,'R931904','ACTIVIDADES DE LOS GUÍAS DE MONTAÑA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2926,'R931905','ACTIVIDADES RELACIONADAS CON CARRERAS DE CABALLOS, GALGOS Y AUTOMÓVILES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2927,'R931906','GESTIÓN DE RESERVAS Y ACTIVIDADES DE APOYO PARA LA CAZA Y PESCA DEPORTIVA O RECREATIVA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2928,'R932','OTRAS ACTIVIDADES DE ESPARCIMIENTO Y RECREATIVAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2929,'R9321','ACTIVIDADES DE PARQUES DE ATRACCIONES Y PARQUES TEMÁTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2930,'R93210','ACTIVIDADES DE PARQUES DE ATRACCIONES Y PARQUES TEMÁTICOS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2931,'R932100','ACTIVIDADES DE PARQUES DE ATRACCIÓN Y PARQUES TEMÁTICOS, INCLUIDA LA EXPLOTACIÓN DE DIVERSAS ATRACCIONES MECÁNICAS Y ACUÁTICAS, JUEGOS, ESPECTÁCULOS, EXPOSICIONES TEMÁTICAS Y LUGARES DE PICNICS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2932,'R9329','OTRAS ACTIVIDADES DE ESPARCIMIENTO Y RECREATIVAS N.C.P.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2933,'R93290','OTRAS ACTIVIDADES DE ESPARCIMIENTO Y RECREATIVAS N.C.P.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2934,'R932901','ACTIVIDADES DE PARQUES RECREATIVOS Y PLAYAS, INCLUIDO EL ALQUILER DE CASETAS, CASILLEROS, SILLAS, HAMACAS; LA GESTIÓN DE INSTALACIONES DE TRANSPORTE RECREATIVO; POR EJEMPLO, PUERTOS DEPORTIVOS, Y EL ALQUILER DE EQUIPO DE ESPARCIMIENTO Y RECREO COMO PARTE INTEGRAL DE LOS SERVICIOS DE ESPARCIMIENTO, BANANAS, LANCHAS, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2935,'R932902','ACTIVIDADES DE EXPLOTACIÓN DE FERIAS Y EXPOSICIONES DE CARÁCTER RECREATIVO, INCLUIDO LA EXPLOTACIÓN DE JUEGOS ACCIONADOS CON MONEDAS.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2936,'R932903','ACTIVIDADES DE EXPLOTACIÓN DE DISCOTECAS Y PISTAS DE BAILE INCLUYE KARAOKES, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2937,'R932904','ACTIVIDADES DE PRODUCTORES O EMPRESARIOS DE ESPECTÁCULOS EN VIVO DISTINTOS DE LOS ARTÍSTICOS O DEPORTIVOS, APORTEN O NO ELLOS MISMOS LAS INSTALACIONES CORRESPONDIENTES.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2938,'R932909','OTRAS ACTIVIDADES DE ESPARCIMIENTO Y RECREATIVAS (EXCEPTO LAS DE PARQUES DE ATRACCIONES Y PARQUES TEMÁTICOS) NO CLASIFICADAS EN OTRA PARTE, INCLUYE LA GESTIÓN DE ESTACIONES DE ESQUÍ, GALLERAS, PLAZAS DE TOROS, ETCÉTERA.','S',0.19,'S',0.13,'S',0.58,'N',0.00,'S',0.08,0.98,10.00,'A'),
	 (2939,'S','OTRAS ACTIVIDADES DE SERVICIOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2940,'S01','JUBILADO','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2941,'S02','ESTUDIANTE','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2942,'S03','AMA DE CASA','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2943,'S04','EMPLEADO PÚBLICO','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (2944,'S05','EMPLEADO PRIVADO','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2945,'S94','ACTIVIDADES DE ASOCIACIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2946,'S941','ACTIVIDADES DE ASOCIACIONES EMPRESARIALES, PROFESIONALES Y DE EMPLEADORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2947,'S9411','ACTIVIDADES DE ASOCIACIONES EMPRESARIALES Y DE EMPLEADORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2948,'S94110','ACTIVIDADES DE ASOCIACIONES EMPRESARIALES Y DE EMPLEADORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2949,'S941100','ACTIVIDADES DE ORGANIZACIONES CUYOS MIEMBROS SE INTERESAN PRINCIPALMENTE POR EL DESARROLLO Y LA PROSPERIDAD DE LAS EMPRESAS DE UN DETERMINADO SECTOR EMPRESARIAL O COMERCIAL INCLUIDO EL SECTOR AGROPECUARIO, O EN LA SITUACIÓN Y EL CRECIMIENTO ECONÓMICO DE UNA DETERMINADA ZONA GEOGRÁFICA O SUBDIVISIÓN POLÍTICA, INDEPENDIENTEMENTE DE LA RAMA DE ACTIVIDAD Y ACTIVIDADES DE CÁMARAS DE COMERCIO, GREMIOS Y ORGANIZACIONES SIMILARES. INCLUYE ACTIVIDADES DE FEDERACIONES EMPRESARIALES Y PATRONALES Y LA DIFUSIÓN DE LA INFORMACIÓN, ESTABLECIMIENTO Y FISCALIZACIÓN DEL CUMPLIMIENTO DE NORMAS PROFESIONALES, REPRESENTACIÓN ANTE ORGANISMOS PÚBLICOS, RELACIONES PÚBLICAS Y NEGOCIACIONES LABORALES DE LAS ASOCIACIONES EMPRESARIALES Y DE EMPLEADORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2950,'S9412','ACTIVIDADES DE ASOCIACIONES PROFESIONALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2951,'S94120','ACTIVIDADES DE ASOCIACIONES PROFESIONALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2952,'S941200','ACTIVIDADES DE LAS ORGANIZACIONES CUYOS MIEMBROS ESTÁN INTERESADOS PRINCIPALMENTE EN UNA DISCIPLINA CIENTÍFICA, PRÁCTICA PROFESIONAL O ESFERA TÉCNICA CONCRETA, COMO: COLEGIOS DE MÉDICOS, ABOGADOS, CONTABLES, INGENIEROS, ARQUITECTOS, ETCÉTERA; ACTIVIDADES DE ASOCIACIONES DE ESPECIALISTAS EN EL CAMPO CIENTÍFICO, ACADÉMICO O CULTURAL, COMO SOCIEDADES CIENTÍFICAS, ASOCIACIONES DE ESCRITORES, PINTORES, ARTISTAS DE DIVERSOS TIPOS, PERIODISTAS, ETCÉTERA; DIFUSIÓN DE INFORMACIÓN, ESTABLECIMIENTO Y FISCALIZACIÓN DEL CUMPLIMIENTO DE NORMAS PROFESIONALES, REPRESENTACIÓN ANTE ORGANISMOS PÚBLICOS Y RELACIONES PÚBLICAS DE LAS ASOCIACIONES PROFESIONALES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2953,'S942','ACTIVIDADES DE SINDICATOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2954,'S9420','ACTIVIDADES DE SINDICATOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2955,'S94200','ACTIVIDADES DE SINDICATOS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2956,'S942000','DEFENSA DE LOS INTERESES DE LOS SINDICATOS Y DE SUS AFILIADOS; ACTIVIDADES DE ASOCIACIONES CUYOS AFILIADOS SON EMPLEADOS INTERESADOS PRINCIPALMENTE EN DAR A CONOCER SUS OPINIONES SOBRE LA SITUACIÓN LABORAL Y SALARIAL Y EN TOMAR MEDIDAS CONCERTADAS POR CONDUCTO DE SU ORGANIZACIÓN; ACTIVIDADES DE SINDICATOS DE EMPRESAS, SINDICATOS CON FILIALES Y ORGANIZACIONES SINDICALES INTEGRADAS POR SINDICATOS AFILIADOS Y CONSTITUIDAS EN FUNCIÓN DEL OFICIO DE SUS MIEMBROS O EN FUNCIÓN DE CRITERIOS GEOGRÁFICOS, ESTRUCTURALES O DE OTRA ÍNDOLE.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2957,'S949','ACTIVIDADES DE OTRAS ASOCIACIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2958,'S9491','ACTIVIDADES DE ORGANIZACIONES RELIGIOSAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2959,'S94910','ACTIVIDADES DE ORGANIZACIONES RELIGIOSAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2960,'S949101','ACTIVIDADES DE LAS ORGANIZACIONES RELIGIOSAS O DE PARTICULARES QUE PRESTAN SERVICIOS DIRECTAMENTE A LOS FIELES EN IGLESIAS, MEZQUITAS, TEMPLOS, SINAGOGAS Y OTROS LUGARES DE CULTO Y SERVICIOS RELIGIOSOS DE HONRAS FÚNEBRES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2961,'S949102','ACTIVIDADES DE MONASTERIOS Y CONVENTOS, ACTIVIDADES DE RETIRO RELIGIOSO.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2962,'S9492','ACTIVIDADES DE ORGANIZACIONES POLÍTICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2963,'S94920','ACTIVIDADES DE ORGANIZACIONES POLÍTICAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2964,'S949200','ACTIVIDADES DE ORGANIZACIONES POLÍTICAS Y ORGANIZACIONES AUXILIARES: ORGANIZACIONES JUVENILES VINCULADAS A UN PARTIDO POLÍTICO, CUYA FINALIDAD ES INFLUIR EN LOS PROCESOS DE ADOPCIÓN DE DECISIONES DE LOS ÓRGANOS PÚBLICOS COLOCANDO EN PUESTOS POLÍTICOS A MIEMBROS Y SIMPATIZANTES DEL PARTIDO, Y REALIZAN ACTIVIDADES DE INFORMACIÓN, RELACIONES PÚBLICAS, RECAUDACIÓN DE FONDOS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2965,'S9499','ACTIVIDADES DE OTRAS ASOCIACIONES N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2966,'S94990','ACTIVIDADES DE OTRAS ASOCIACIONES N.C.P.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2967,'S949901','ACTIVIDADES DE ORGANIZACIONES NO AFILIADAS DIRECTAMENTE A UN PARTIDO POLÍTICO QUE PROMUEVEN UNA CAUSA O CUESTIÓN PÚBLICA MEDIANTE CAMPAÑAS DE EDUCACIÓN DEL PÚBLICO, INFLUENCIA POLÍTICA, RECAUDACIÓN DE FONDOS, ETCÉTERA; COMO INICIATIVAS CIUDADANAS Y MOVIMIENTOS DE PROTESTA; ACTIVIDADES DE MOVIMIENTOS AMBIENTALISTAS O ECOLOGISTA; ACTIVIDADES DE ORGANIZACIONES DE APOYO A SERVICIOS COMUNITARIOS Y EDUCATIVOS N.C.P.; ACTIVIDADES DE ORGANIZACIONES PARA LA PROTECCIÓN Y DEL ADELANTO DE GRUPOS ESPECIALES; POR EJEMPLO, GRUPOS ÉTNICOS Y MINORITARIOS Y ACTIVIDADES DE ASOCIACIONES CON FINES PATRIÓTICOS, INCLUIDAS ASOCIACIONES DE VETERANOS DE GUERRA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2968,'S949902','ACTIVIDADES DE ASOCIACIONES DE CONSUMIDORES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2969,'S949903','ACTIVIDADES DE ASOCIACIONES DE AUTOMOVILISTAS.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2970,'S949904','ACTIVIDADES DE ASOCIACIONES QUE FACILITAN EL CONTACTO CON OTRAS PERSONAS CON INTERESES SIMILARES, COMO CLUBES ROTARIOS, LOGIAS MASÓNICAS, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2971,'S949905','ACTIVIDADES DE ASOCIACIONES DE JÓVENES, ASOCIACIONES, CLUBES Y ORGANIZACIONES FRATERNALES DE ESTUDIANTES, ETCÉTERA, ACTIVIDADES DE ASOCIACIONES QUE PROMUEVEN ACTIVIDADES CULTURALES O RECREATIVAS O REÚNEN A PERSONAS QUE COMPARTEN UNA AFICIÓN (DIFERENTE DE UN DEPORTE O JUEGO), COMO CLUBES DE POESÍA, LITERARIOS O DE LIBROS, CLUBES DE HISTORIA, CLUBES DE JARDINERÍA, CLUBES DE CINE Y FOTOGRAFÍA, CLUBES MUSICALES Y ARTÍSTICOS, CLUBES DE ARTESANÍA Y DE COLECCIONISTAS, CLUBES SOCIALES, CLUBES DE CARNAVAL, ETCÉTERA.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2972,'S949906','ACTIVIDADES DE CONCESIÓN DE DONACIONES REALIZADAS POR ASOCIACIONES U OTRAS ORGANIZACIONES.','S',0.19,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.77,7.90,'A'),
	 (2973,'S95','REPARACIÓN DE COMPUTADORES Y DE EFECTOS PERSONALES Y ENSERES DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2974,'S951','REPARACIÓN DE COMPUTADORAS Y EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2975,'S9511','REPARACIÓN DE COMPUTADORAS Y EQUIPO PERIFÉRICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2976,'S95110','REPARACIÓN DE COMPUTADORAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2977,'S951101','REPARACIÓN Y MANTENIMIENTO DE: COMPUTADORAS DE ESCRITORIO, COMPUTADORAS PORTÁTILES, SERVIDORES INFORMÁTICOS, COMPUTADORAS DE MANO (ASISTENTES DIGITALES PERSONALES), UNIDADES DE DISCO MAGNÉTICO, UNIDADES DE MEMORIA USB Y OTROS DISPOSITIVOS DE ALMACENAMIENTO; UNIDADES DE DISCO ÓPTICO (CD-RW, CD-ROM, DVD-ROM, DVD-RW), MÓDEMS INTERNOS Y EXTERNOS, IMPRESORAS, PANTALLAS, TECLADOS, RATONES, PALANCAS DE MANDO Y BOLAS RODANTES, PROYECTORES INFORMÁTICOS, ESCÁNERES, INCLUIDOS LECTORES DE CÓDIGO DE BARRAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2978,'S951109','REPARACIÓN Y MANTENIMIENTO DE OTRAS TERMINALES INFORMÁTICAS ESPECIALIZADAS, LECTORES DE TARJETAS INTELIGENTES, CASCOS DE REALIDAD VIRTUAL, TERMINALES INFORMÁTICAS, COMO MONEDEROS AUTOMÁTICOS Y TERMINALES DE PUNTO DE VENTA NO ACCIONADAS MECÁNICAMENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2979,'S9512','REPARACIÓN DE EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2980,'S95120','REPARACIÓN DE EQUIPO DE COMUNICACIONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2981,'S951201','REPARACIÓN Y MANTENIMIENTO DE TELÉFONOS INALÁMBRICOS, TELÉFONOS CELULARES Y APARATOS DE FAX.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2982,'S951202','REPARACIÓN Y MANTENIMIENTO DE EMISORES-RECEPTORES DE RADIO, CÁMARAS DE TELEVISIÓN Y DE VIDEO DE USO COMERCIAL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2983,'S951209','REPARACIÓN Y MANTENIMIENTO DE OTRO TIPO DE EQUIPO DE COMUNICACIONES: EQUIPO DE TRANSMISIÓN DE COMUNICACIONES (POR EJEMPLO, ENRUTADORES, PUENTES, MÓDEMS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2984,'S952','REPARACIÓN DE EFECTOS PERSONALES Y ENSERES DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2985,'S9521','REPARACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2986,'S95210','REPARACIÓN DE APARATOS ELECTRÓNICOS DE CONSUMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2987,'S952100','REPARACIÓN Y MANTENIMIENTO DE APARATOS ELECTRÓNICOS DE USO DOMÉSTICO: APARATOS DE TELEVISIÓN Y DE RADIO, GRABADORAS DE VIDEO (VCR), REPRODUCTORES DE CD Y CÁMARAS DE VIDEO PARA USO FAMILIAR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2988,'S9522','REPARACIÓN DE APARATOS DE USO DOMÉSTICO Y EQUIPO DOMÉSTICO Y DE JARDINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2989,'S95220','REPARACIÓN DE APARATOS DE USO DOMÉSTICO Y EQUIPO DOMÉSTICO Y DE JARDINERÍA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2990,'S952201','REPARACIÓN Y MANTENIMIENTO DE APARATOS DE USO DOMÉSTICO, COMO REFRIGERADORES, COCINAS, LAVADORAS, SECADORES DE ROPA, APARATOS DE AIRE ACONDICIONADO, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (2991,'S952202','REPARACIÓN Y MANTENIMIENTO DE EQUIPO DOMÉSTICO Y DE JARDINERÍA, COMO SEGADORAS DE CÉSPED, BORDEADORES, SOPLANTES PARA NIEVE Y PARA HOJAS, CORTASETOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2992,'S9523','REPARACIÓN DE CALZADO Y ARTÍCULOS DE CUERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2993,'S95230','REPARACIÓN DE CALZADO Y ARTÍCULOS DE CUERO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2994,'S952301','REPARACIÓN Y MANTENIMIENTO DE CALZADO: ZAPATOS, BOTAS, ETCÉTERA; COLOCACIÓN DE TACONES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2995,'S952302','REPARACIÓN Y MANTENIMIENTO DE ARTÍCULOS DE CUERO, MALETAS Y ARTÍCULOS SIMILARES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2996,'S9524','REPARACIÓN DE MUEBLES Y ACCESORIOS DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2997,'S95240','REPARACIÓN DE MUEBLES Y ACCESORIOS DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2998,'S952401','RETAPIZADO, REPARACIÓN Y RESTAURACIÓN DE MUEBLES Y ACCESORIOS DOMÉSTICOS, INCLUIDOS MUEBLES DE OFICINA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (2999,'S952402','MONTAJE DE MUEBLES NO EMPOTRADOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3000,'S9529','REPARACIÓN DE OTROS BIENES PERSONALES Y ENSERES DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3001,'S95290','REPARACIÓN DE OTROS BIENES PERSONALES Y ENSERES DOMÉSTICOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3002,'S952901','REPARACIÓN DE BICICLETAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3003,'S952902','REPARACIÓN Y ARREGLO DE PRENDAS DE VESTIR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3004,'S952903','REPARACIÓN Y ARREGLO DE JOYAS, REPARACIÓN DE RELOJES DE PULSERA Y DE PARED Y DE SUS PARTES, COMO CAJAS Y BASTIDORES DE TODOS LOS MATERIALES; MECANISMOS, CRONÓMETROS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3005,'S952904','REPARACIÓN DE INSTRUMENTOS MUSICALES Y AFINACIÓN DE PIANOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3006,'S952909','REPARACIÓN DE OTROS EFECTOS PERSONALES Y ENSERES DOMÉSTICOS: LIBROS, JUGUETES Y ARTÍCULOS SIMILARES, ARTÍCULOS DEPORTIVOS (EXCEPTO ARMAS DEPORTIVAS), ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3007,'S96','OTRAS ACTIVIDADES DE SERVICIOS PERSONALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3008,'S960','OTRAS ACTIVIDADES DE SERVICIOS PERSONALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3009,'S9601','LAVADO Y LIMPIEZA, INCLUIDA LA LIMPIEZA EN SECO, DE PRODUCTOS TEXTILES Y DE PIEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3010,'S96010','LAVADO Y LIMPIEZA, INCLUIDA LA LIMPIEZA EN SECO, DE PRODUCTOS TEXTILES Y DE PIEL.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3011,'S960101','LAVADO Y LIMPIEZA EN SECO, PLANCHADO, ETCÉTERA, DE TODO TIPO DE PRENDAS DE VESTIR (INCLUSO DE PIEL) Y DE PRODUCTOS TEXTILES QUE SE REALIZAN CON EQUIPO MECÁNICO, A MANO O EN MÁQUINAS ACCIONADAS CON MONEDAS PARA EL PÚBLICO EN GENERAL O PARA CLIENTES INDUSTRIALES O COMERCIALES, INCLUYE ACTIVIDADES DE REPARACIÓN Y ARREGLOS MENORES DE PRENDAS DE VESTIR Y OTROS ARTÍCULOS TEXTILES, SI SE REALIZAN EN COMBINACIÓN CON LAS DE LIMPIEZA, RECOGIDA Y ENTREGA DE ROPA POR LAS LAVANDERÍAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3012,'S960102','LAVADO DE ALFOMBRAS Y TAPICES CON CHAMPÚ Y LIMPIEZA DE CORTINAS Y COLGADURAS, SE REALICEN O NO EN EL LOCAL O LA RESIDENCIA DEL CLIENTE.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3013,'S960103','SUMINISTRO DE ROPA BLANCA, UNIFORMES DE TRABAJO Y ARTÍCULOS SIMILARES POR LAS LAVANDERÍAS Y SERVICIOS DE SUMINISTRO DE PAÑALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3014,'S9602','ACTIVIDADES DE PELUQUERÍA Y OTROS TRATAMIENTOS DE BELLEZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3015,'S96020','ACTIVIDADES DE PELUQUERÍA Y OTROS TRATAMIENTOS DE BELLEZA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3016,'S960200','ACTIVIDADES DE LAVADO, CORTE, RECORTE, PEINADO, TEÑIDO, COLORACIÓN, ONDULACIÓN Y ALISADO DEL CABELLO Y OTRAS ACTIVIDADES SIMILARES PARA HOMBRES Y MUJERES; AFEITADO Y RECORTE DE LA BARBA; MASAJES FACIALES, MANICURA Y PEDICURA, TATUAJES, MAQUILLAJE, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3017,'S9603','POMPAS FÚNEBRES Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3018,'S96030','POMPAS FÚNEBRES Y ACTIVIDADES CONEXAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3019,'S960301','ACTIVIDADES DE SEPULTURA E INCINERACIÓN DE CADÁVERES HUMANOS O ANIMALES Y ACTIVIDADES CONEXAS: PREPARACIÓN DE LOS DESPOJOS PARA SU INHUMACIÓN O CREMACIÓN Y SERVICIOS DE EMBALSAMIENTO Y OTROS SERVICIOS DE POMPAS FÚNEBRES; PRESTACIÓN DE SERVICIOS DE INHUMACIÓN Y CREMACIÓN, ALQUILER DE LOCALES ESPECIALES EN FUNERARIAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3020,'S960302','ACTIVIDADES DE ALQUILER Y VENTA DE TUMBAS, MANTENIMIENTO DE TUMBAS Y MAUSOLEOS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3021,'S9609','OTRAS ACTIVIDADES DE SERVICIOS PERSONALES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3022,'S96090','OTRAS ACTIVIDADES DE SERVICIOS PERSONALES N.C.P.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3023,'S960901','ACTIVIDADES DE BAÑOS TURCOS, SAUNAS Y BAÑOS DE VAPOR, CENTROS DE SPA, SOLARIOS, SALONES DE ADELGAZAMIENTO, SALONES DE MASAJE, BAÑOS PÚBLICOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3024,'S960902','ACTIVIDADES DE ASTROLOGÍA Y ESPIRITISMO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3025,'S960903','ACTIVIDADES DE CLUBES NOCTURNOS (NIGHT CLUBS).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3026,'S960904','ACTIVIDADES DE RELACIÓN SOCIAL, COMO LAS AGENCIAS QUE SE ENCARGAN DE LA CONTRATACIÓN DE ACOMPAÑANTES O PONER EN CONTACTO ENTRE SÍ A PERSONAS QUE BUSCAN COMPAÑÍA O AMISTAD, Y LAS AGENCIAS MATRIMONIALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3027,'S960905','ACTIVIDADES DE SERVICIOS PARA ANIMALES DOMÉSTICOS, COMO LAS RESIDENCIAS Y PELUQUERÍAS PARA ANIMALES, PASEO Y ADIESTRAMIENTO DE ANIMALES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3028,'S960906','ACTIVIDADES DE ORGANIZACIONES GENEALÓGICAS.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3029,'S960907','ACTIVIDADES DE LIMPIABOTAS (BETUNEROS), PORTEADORES DE MALETAS, PERSONAS ENCARGADAS DE ESTACIONAR VEHÍCULOS, ETCÉTERA.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3030,'S960908','EXPLOTACIÓN DE MÁQUINAS DE SERVICIOS PERSONALES ACCIONADAS CON MONEDAS (FOTOMATONES, BÁSCULAS, APARATOS PARA TOMAR LA TENSIÓN, TAQUILLAS ACCIONADAS CON MONEDAS, ETCÉTERA).','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3031,'T','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES; ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE BIENES Y SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3032,'T97','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3033,'T970','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3034,'T9700','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3035,'T97000','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOMÉSTICO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3036,'T970000','ACTIVIDADES DE LOS HOGARES COMO EMPLEADORES DE PERSONAL DOMÉSTICO, COMO SIRVIENTES, COCINEROS, CAMAREROS, AYUDANTES DE CÁMARA, MAYORDOMOS, LAVANDEROS, JARDINEROS, PORTEROS, MOZOS DE CUADRA, CONDUCTORES, CONSERJES, INSTITUTRICES, NIÑERAS, PRECEPTORES, SECRETARIOS, ETCÉTERA. EL PERSONAL DOMÉSTICO EMPLEADO PUEDE ASÍ DECLARAR LA ACTIVIDAD DE SU EMPLEADOR EN LOS CENSOS O ESTUDIOS, AUNQUE EL EMPLEADOR SEA UN PARTICULAR. EL PRODUCTO RESULTANTE DE ESA ACTIVIDAD ES CONSUMIDO POR EL PROPIO HOGAR EMPLEADOR.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3037,'T98','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE BIENES Y SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3038,'T981','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE BIENES Y SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3039,'T9810','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE BIENES Y SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3040,'T98100','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE BIENES Y SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3041,'T981000','ACTIVIDADES NO DIFERENCIADAS DE HOGARES COMO PRODUCTORES DE BIENES DE SUBSISTENCIA, ES DECIR, LAS ACTIVIDADES DE LOS HOGARES QUE PRODUCEN DIVERSOS BIENES PARA SU PROPIA SUBSISTENCIA. ESAS ACTIVIDADES COMPRENDEN LA CAZA Y LA RECOLECCIÓN, LA AGRICULTURA, LA CONSTRUCCIÓN DE VIVIENDAS Y LA CONFECCIÓN DE PRENDAS DE VESTIR Y OTROS BIENES PRODUCIDOS POR LOS HOGARES PARA SU PROPIA SUBSISTENCIA. SI LOS HOGARES SE DEDICAN A LA PRODUCCIÓN DE BIENES PARA EL MERCADO, SE CLASIFICAN EN LA RAMA DE PRODUCCIÓN CORRESPONDIENTE A ESOS BIENES. SI SE DEDICAN PRINCIPALMENTE A LA PRODUCCIÓN DE BIENES DE SUBSISTENCIA ESPECÍFICOS, SE CLASIFICAN EN LA RAMA DE PRODUCCIÓN CORRESPONDIENTE A ESOS BIENES.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3042,'T982','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3043,'T9820','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3044,'T98200','ACTIVIDADES NO DIFERENCIADAS DE LOS HOGARES COMO PRODUCTORES DE SERVICIOS PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3045,'T982000','ACTIVIDADES NO DIFERENCIADAS DE HOGARES COMO PRODUCTORES DE SERVICIOS SE SUBSISTENCIA, ES DECIR, ACTIVIDADES DE LOS HOGARES QUE PRODUCEN DIVERSOS SERVICIOS PARA SU PROPIA SUBSISTENCIA. ESAS ACTIVIDADES COMPRENDEN LA COCINA, LA ENSEÑANZA, EL CUIDADO DE LOS MIEMBROS DE LA FAMILIA Y OTROS SERVICIOS PRODUCIDOS POR LOS HOGARES PARA SU PROPIA SUBSISTENCIA. SI LOS HOGARES TAMBIÉN SE DEDICAN A LA PRODUCCIÓN DE DIVERSOS BIENES PARA SU PROPIA SUBSISTENCIA, SE CLASIFICAN EN LAS ACTIVIDADES NO DIFERENCIADAS DE HOGARES COMO PRODUCTORES DE BIENES PARA USO PROPIO.','N',0.00,'N',0.00,'N',0.00,'N',0.00,'N',0.00,0.00,1.00,'B'),
	 (3046,'U','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (3047,'U99','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES.','N',0.00,'N',0.00,'S',0.58,'N',0.00,'N',0.00,0.58,5.90,'M'),
	 (3048,'U990','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (3049,'U9900','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (3050,'U99000','ACTIVIDADES DE ORGANIZACIONES Y ÓRGANOS EXTRATERRITORIALES.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
INSERT INTO tbl_act_economica (aec_codigo,aec_auxcod,aec_descri,aec_preg01,aec_vapr01,aec_preg02,aec_vapr02,aec_preg03,aec_vapr03,aec_preg04,aec_vapr04,aec_preg05,aec_vapr05,aec_total,aec_ponder,aec_nivrie) VALUES
	 (3051,'U990001','ACTIVIDADES DE ORGANIZACIONES INTERNACIONALES, COMO LAS NACIONES UNIDAS Y LOS ORGANISMOS ESPECIALIZADOS DEL SISTEMA DE LAS NACIONES UNIDAS, ÓRGANOS REGIONALES, ETCÉTERA, EL FONDO MONETARIO INTERNACIONAL, EL BANCO MUNDIAL, LA ORGANIZACIÓN DE COOPERACIÓN Y DESARROLLO ECONÓMICOS, LA ORGANIZACIÓN DE PAÍSES EXPORTADORES DE PETRÓLEO, LAS COMUNIDADES EUROPEAS, LA ASOCIACIÓN EUROPEA DE LIBRE COMERCIO, ETCÉTERA.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A'),
	 (3052,'U990002','ACTIVIDADES DE MISIONES DIPLOMÁTICAS Y CONSULARES CUANDO ESTÁN DETERMINADAS POR EL PAÍS EN EL QUE SE ENCUENTRAN Y NO DEL PAÍS QUE REPRESENTAN.','N',0.00,'S',0.13,'S',0.58,'N',0.00,'N',0.00,0.71,7.20,'A');
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/

create table sco_matrices(
emp_codigo smallint not null,
mat_codigo smallint not null,
mat_descri varchar(50) not null,
mat_marimp numeric(6,2) not null --margen de imprevitos %
);
alter table sco_matrices add constraint pk_sco_mat primary key (emp_codigo,mat_codigo);
insert into sco_matrices values(1,1,'MICROCREDITO',40.00);
insert into sco_matrices values(1,2,'CONSUMO',40.00);

create table sco_ponderaciones(
emp_codigo smallint not null,
mat_codigo smallint not null,
pon_codigo smallint not null,
pon_estado char(1) not null,
pon_estdes varchar(50) not null,
pon_minval numeric(5,2) not null,
pon_maxval numeric(5,2) not null,
pon_color varchar(75) not null,
pon_ponder char(1) not null, -- para saber si el registro se toma en cuanta en la ponderación de datos.
unique(mat_codigo,pon_estado)
);
alter table sco_ponderaciones add constraint pk_sco_pon primary key (emp_codigo,mat_codigo,pon_codigo);
insert into sco_ponderaciones values(1,1,1,'P','EN PROCESO',-1,-0.1,'','N');
insert into sco_ponderaciones values(1,1,2,'A','APROBADO',0.79,999.99,'green','S');
insert into sco_ponderaciones values(1,1,3,'S','SUSPENSO',0.60,0.80,'grey','S');
insert into sco_ponderaciones values(1,1,4,'R','RECHAZADO',0.00,0.59,'red','S');

insert into sco_ponderaciones values(1,2,1,'P','EN PROCESO',-1,-0.1,'','N');
insert into sco_ponderaciones values(1,2,2,'A','APROBADO',0.79,999.99,'green','S');
insert into sco_ponderaciones values(1,2,3,'S','SUSPENSO',0.60,0.80,'grey','S');
insert into sco_ponderaciones values(1,2,4,'R','RECHAZADO',0.00,0.59,'red','S');

create table sco_indicadores(
emp_codigo smallint not null,
mat_codigo smallint not null,
ind_codigo smallint not null,
ind_descri varchar(50) not null,
ind_valpor numeric(5,2) not null
);
alter table sco_indicadores add constraint pk_sco_ind primary key (emp_codigo,mat_codigo,ind_codigo);
insert into sco_indicadores values(1,1,1,'ANALISIS DE LA CAPACIDAD DE PAGO DEL DEUDOR',20.00);
insert into sco_indicadores values(1,1,2,'ANALISIS DE CARÁCTER DEL DEUDOR',20.00);
insert into sco_indicadores values(1,1,3,'ANALISIS DE CAPITAL DEL DEUDOR',20.00);
insert into sco_indicadores values(1,1,4,'ANALISIS COLATERAL DEL DEUDOR',20.00);
insert into sco_indicadores values(1,1,5,'ANALISIS DE CONDICIÓN DEL DEUDOR',20.00);

insert into sco_indicadores values(1,2,1,'ANALISIS DE LA CAPACIDAD DE PAGO DEL DEUDOR',20.00);
insert into sco_indicadores values(1,2,2,'ANALISIS DE CARÁCTER DEL DEUDOR',20.00);
insert into sco_indicadores values(1,2,3,'ANALISIS DE CAPITAL DEL DEUDOR',20.00);
insert into sco_indicadores values(1,2,4,'ANALISIS COLATERAL DEL DEUDOR',20.00);
insert into sco_indicadores values(1,2,5,'ANALISIS DE CONDICIÓN DEL DEUDOR',20.00);

create table sco_cab_var_indicadores(--variables de indicadores
emp_codigo smallint not null,
mat_codigo smallint not null,
ind_codigo smallint not null,
cvi_codigo smallint not null,
cvi_descri varchar(150) not null,
cvi_valpor numeric(5,2) not null,
cvi_tomar char(1) null
);
alter table sco_cab_var_indicadores add constraint pk_sco_cabvar primary key (emp_codigo,mat_codigo,ind_codigo,cvi_codigo);
insert into sco_cab_var_indicadores values(1,1,1,1,'EXPERIENCIA EN EL NEGOCIO Y/O TRABAJO',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,2,'UTILIDAD SOBRE LAS VENTAS',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,3,'TOTAL INGRESOS MENOS GASTOS VS CUOTA DE PAGO ',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,4,'DEPENDENCIA DE PROVEEDORES',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,5,'DEPENDENCIA DE PERSONAL',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,6,'FUENTE DE INGRESO',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,7,'CAPACIDAD PARA ADMINISTRAR',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,8,'LOCAL DEL NEGOCIO',10.00,null);
insert into sco_cab_var_indicadores values(1,1,1,9,'ACTIVIDAD ECONOMICA',20.00,null);

insert into sco_cab_var_indicadores values(1,2,1,1,'EXPERIENCIA EN EL NEGOCIO Y/O TRABAJO',25.00,null);
insert into sco_cab_var_indicadores values(1,2,1,2,'TOTAL INGRESOS MENOS GASTOS VS CUOTA DE PAGO',25.00,null);
insert into sco_cab_var_indicadores values(1,2,1,3,'FUENTE DE INGRESO',25.00,null);
insert into sco_cab_var_indicadores values(1,2,1,4,'ACTIVIDAD ECONOMICA',25.00,null);
------------------------------------------------------------------------------
insert into sco_cab_var_indicadores values(1,1,2,1,'EXPERIENCIA CREDITICIA EN LA COOPERATIVA, ULTIMOS 3 AÑOS',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,2,'REFERENCIAS FAMILIARES / COMERCIALES',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,3,'EDAD',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,4,'MOROSIDAD EXTERNA',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,5,'MOROSIDAD INTERNA',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,6,'SALDO PROMEDIO ULTIMO TRIMESTRE EN AHORROS Y CERTIFICADOS DE DEPOSITO A PLAZO',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,7,'ARRAIGO RESIDENCIAL',12.50,null);
insert into sco_cab_var_indicadores values(1,1,2,8,'ESTADO CIVIL',12.50,null);

insert into sco_cab_var_indicadores values(1,2,2,1,'EXPERIENCIA CREDITICIA EN LA COOPERATIVA, ULTIMOS 3 AÑOS',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,2,'REFERENCIAS FAMILIARES / COMERCIALES',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,3,'EDAD',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,4,'MOROSIDAD EXTERNA',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,5,'MOROSIDAD INTERNA',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,6,'SALDO PROMEDIO ULTIMO TRIMESTRE EN AHORROS Y CERTIFICADOS DE DEPOSITO A PLAZO',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,7,'ARRAIGO RESIDENCIAL',12.50,null);
insert into sco_cab_var_indicadores values(1,2,2,8,'ESTADO CIVIL',12.50,null);

-----------------------------------------------------------------------------
insert into sco_cab_var_indicadores values(1,1,3,1,'ENDEUDAMIENTO',0.00,'N');
insert into sco_cab_var_indicadores values(1,1,3,2,'PASIVO INCLUIDO EL CREDITO EN ANALISIS/ACTIVO',25.00,null);
insert into sco_cab_var_indicadores values(1,1,3,3,'INDICE DE SOLVENCIA',0.00,'N');
insert into sco_cab_var_indicadores values(1,1,3,4,'ACTIVO / PASIVO',25.00,null);
insert into sco_cab_var_indicadores values(1,1,3,5,'INDICE DE LIQUIDEZ',0.00,'N');
insert into sco_cab_var_indicadores values(1,1,3,6,'ACTIVO CORRIENTE INVENTARIO / PASIVO CORRIENTE',25.00,null);
insert into sco_cab_var_indicadores values(1,1,3,7,'CAPITAL DE TRABAJO',0.00,'N');
insert into sco_cab_var_indicadores values(1,1,3,8,'ACTIVO CORRIENTE / PASIVO CORRIENTE',25.00,null);

insert into sco_cab_var_indicadores values(1,2,3,1,'ENDEUDAMIENTO',25.00,'N');
insert into sco_cab_var_indicadores values(1,2,3,2,'PASIVO INCLUIDO EL CREDITO EN ANALISIS/ACTIVO',25.00,null);
insert into sco_cab_var_indicadores values(1,2,3,3,'INDICE DE SOLVENCIA',25.00,'N');
insert into sco_cab_var_indicadores values(1,2,3,4,'ACTIVO / PASIVO',25.00,null);

-----------------------------------------------------------------------------
insert into sco_cab_var_indicadores values(1,1,4,1,'BIENES INMUEBLES SOCIO',20.00,null);
insert into sco_cab_var_indicadores values(1,1,4,2,'BIENES INMUEBLES GARANTE',20.00,null);
insert into sco_cab_var_indicadores values(1,1,4,3,'BIENES MUEBLES',20.00,null);
insert into sco_cab_var_indicadores values(1,1,4,4,'BIENES MUEBLES GARANTES',20.00,null);
insert into sco_cab_var_indicadores values(1,1,4,5,'TIPO DE VIVIENDA',20.00,null);

insert into sco_cab_var_indicadores values(1,2,4,1,'BIENES INMUEBLES SOCIO',20.00,null);
insert into sco_cab_var_indicadores values(1,2,4,2,'BIENES INMUEBLES GARANTE',20.00,null);
insert into sco_cab_var_indicadores values(1,2,4,3,'BIENES MUEBLES',20.00,null);
insert into sco_cab_var_indicadores values(1,2,4,4,'BIENES MUEBLES GARANTES',20.00,null);
insert into sco_cab_var_indicadores values(1,2,4,5,'TIPO DE VIVIENDA',20.00,null);
-----------------------------------------------------------------------------
insert into sco_cab_var_indicadores values(1,1,5,1,'NIVEL DE COMPETENCIA',30.00,null);
insert into sco_cab_var_indicadores values(1,1,5,2,'DINAMICA DEL SECTOR',30.00,null);
insert into sco_cab_var_indicadores values(1,1,5,3,'ACEPTACIÓN DE PRODUCTO',40.00,null);

insert into sco_cab_var_indicadores values(1,2,5,1,'DINAMICA DEL SECTOR',50.00,null);
insert into sco_cab_var_indicadores values(1,2,5,2,'ACTIVIDAD ECONOMICA',50.00,null);

-----------------------------------------------------------------------------

create table sco_det_var_indicadores(
emp_codigo smallint not null,
mat_codigo smallint not null,
ind_codigo smallint not null,
cvi_codigo smallint not null,
dvi_codigo smallint not null,
dvi_descri varchar(150) not null,
dvi_valor numeric(5,2) not null,
dvi_defsel char(1) null,
dvi_tomar char(1) null
);
alter table sco_det_var_indicadores add constraint pk_sco_detvar primary key (emp_codigo,mat_codigo,ind_codigo,cvi_codigo,dvi_codigo);
insert into sco_det_var_indicadores values(1,1,1,1,1,'MÁS DE 5 AÑOS',8.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,1,2,'MÁS DE 4 A 5 AÑOS',7.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,1,3,'MÁS DE 3 A 4 AÑOS',6.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,1,4,'MÁS DE 1 A 3 AÑOS ',5.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,1,5,'MENOR O IGUAL A UN AÑO',5.00,null,null);---

insert into sco_det_var_indicadores values(1,2,1,1,1,'MÁS DE 5 AÑOS',8.00,'A',null);
insert into sco_det_var_indicadores values(1,2,1,1,2,'MÁS DE 4 A 5 AÑOS',7.50,null,null);
insert into sco_det_var_indicadores values(1,2,1,1,3,'MÁS DE 3 A 4 AÑOS',6.50,null,null);
insert into sco_det_var_indicadores values(1,2,1,1,4,'MÁS DE 1 A 3 AÑOS ',5.50,null,null);
insert into sco_det_var_indicadores values(1,2,1,1,5,'MENOR O IGUAL A UN AÑO',5.00,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,1,2,1,'MAYOR AL 25% SOBRE LAS VENTAS',6.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,2,2,'ENTRE EL 10% Y 25% SOBRE LAS VENTAS',5.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,2,3,'MENOR DE 10% SOBRE LAS VENTAS',5.00,null,null);---

insert into sco_det_var_indicadores values(1,1,1,3,1,'EL 80% O MÁS DEL INGRESO NETO SI CUBRE LA CUOTA DE AMORTIZACIÓN ',10.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,3,2,'EL 80 % DE INGRESOS NETO NO CUBRE LA CUOTA DE AMORTIZACIÓN',0.00,null,null);---

insert into sco_det_var_indicadores values(1,2,1,2,1,'EL 80% O MÁS DEL INGRESO NETO SI CUBRE LA CUOTA DE AMORTIZACIÓN ',10.00,'A',null);
insert into sco_det_var_indicadores values(1,2,1,2,2,'EL 80 % DE INGRESOS NETO NO CUBRE LA CUOTA DE AMORTIZACIÓN',0.00,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,1,4,1,'MAS DE  3 PROVEEDORES',5.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,4,2,'MAS DE 1 A 3 PROVEEDORES',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,4,3,'1 PROVEEDOR',4.00,null,null);---
insert into sco_det_var_indicadores values(1,1,1,5,1,'MAS DE 10 TRABAJADORES',5.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,5,2,'MENOS DE 10 TRABAJADORES',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,5,3,'FAMILIAR',4.00,null,null);---

insert into sco_det_var_indicadores values(1,1,1,6,1,'MAS DE 2 ACTIVIDADES',5.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,6,2,'2 ACTIVIDADES',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,6,3,'1 ACTIVIDAD',4.00,null,null);---

insert into sco_det_var_indicadores values(1,2,1,3,1,'MAS DE 2 ACTIVIDADES',5.00,'A',null);
insert into sco_det_var_indicadores values(1,2,1,3,2,'2 ACTIVIDADES',4.50,null,null);
insert into sco_det_var_indicadores values(1,2,1,3,3,'1 ACTIVIDAD',4.00,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,1,7,1,'SUPERIOR',5.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,7,2,'TECNICO',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,7,3,'ARTESANAL',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,7,4,'SECUNDARIA',4.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,7,5,'PRIMARIA',4.50,null,null);---
insert into sco_det_var_indicadores values(1,1,1,8,1,'PROPIO',6.00,'A',null);
insert into sco_det_var_indicadores values(1,1,1,8,2,'ARRENDADO',5.50,null,null);
insert into sco_det_var_indicadores values(1,1,1,8,3,'AMBULANTE',5.00,null,null);---

insert into sco_det_var_indicadores values(1,1,1,9,1,'ALTO',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,1,9,2,'MEDIO',3.00,null,null);
insert into sco_det_var_indicadores values(1,1,1,9,3,'BAJO',5.00,'A',null);---

insert into sco_det_var_indicadores values(1,2,1,4,1,'ALTO',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,1,4,2,'MEDIO',3.00,null,null);
insert into sco_det_var_indicadores values(1,2,1,4,3,'BAJO',5.00,'A',null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,1,1,'MÁS DE 36 MESES',4.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,1,2,'DE 25 A 36 MESES',3.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,1,3,'DE 13 A 24 MESES',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,1,4,'HASTA 12 MESES',1.00,null,null);-----

insert into sco_det_var_indicadores values(1,2,2,1,1,'MÁS DE 36 MESES',4.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,1,2,'DE 25 A 36 MESES',3.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,1,3,'DE 13 A 24 MESES',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,1,4,'HASTA 12 MESES',1.00,null,null);-----
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,2,1,'DOS BUENAS',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,2,2,'UNA BUENA',2.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,2,3,'UNA MALA',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,2,4,'DOS MALAS',0.50,null,null);-----

insert into sco_det_var_indicadores values(1,2,2,2,1,'DOS BUENAS',3.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,2,2,'UNA BUENA',2.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,2,3,'UNA MALA',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,2,4,'DOS MALAS',0.50,null,null);-----
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,3,1,'DE 18 A 23 AÑOS',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,3,2,'DE 24 A 65 AÑOS',2.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,3,3,'DE 65 A 80 AÑOS',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,3,4,'MÁS DE 80 AÑOS',0.50,null,null);----

insert into sco_det_var_indicadores values(1,2,2,3,1,'DE 18 A 23 AÑOS',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,3,2,'DE 24 A 65 AÑOS',2.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,3,3,'DE 65 A 80 AÑOS',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,3,4,'MÁS DE 80 AÑOS',0.50,null,null);----
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,4,1,'HASTA 15 DÍAS',4.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,4,2,'DE 15 A 30 DÍAS',3.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,4,3,'DE 30 A 90 DÍAS',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,4,4,'MÁS DE 90 DÍAS',0.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,4,5,'SIN ENDEUDAMIENTO',3.50,null,null);----

insert into sco_det_var_indicadores values(1,2,2,4,1,'HASTA 15 DÍAS',4.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,4,2,'DE 15 A 30 DÍAS',3.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,4,3,'DE 30 A 90 DÍAS',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,4,4,'MÁS DE 90 DÍAS',0.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,4,5,'SIN ENDEUDAMIENTO',3.50,null,null);----
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,5,1,'HASTA 15 DÍAS',4.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,5,2,'DE 15 A 30 DÍAS',3.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,5,3,'DE 30 A 90 DÍAS',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,5,4,'MÁS DE 90 DÍAS',0.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,5,5,'SIN ENDEUDAMIENTO',3.50,null,null);----

insert into sco_det_var_indicadores values(1,2,2,5,1,'HASTA 15 DÍAS',4.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,5,2,'DE 15 A 30 DÍAS',3.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,5,3,'DE 30 A 90 DÍAS',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,5,4,'MÁS DE 90 DÍAS',0.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,5,5,'SIN ENDEUDAMIENTO',3.50,null,null);----
----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,2,6,1,'MENOR O IGUAL A $100.00',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,6,2,'DE $100.00 A $499.00',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,6,3,'DE $500.00 A $1000.00',2.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,6,4,'MÁS DE $1000.00',3.00,'A',null);----
insert into sco_det_var_indicadores values(1,1,2,7,1,'MÁS DE 3 AÑOS',2.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,7,2,'ENTRE DOS A TRES AÑOS',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,2,7,3,'MENOS DE 2 AÑOS',0.50,null,null);----
insert into sco_det_var_indicadores values(1,1,2,8,1,'SOLTERO/A',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,8,2,'CASADO/A',2.00,'A',null);
insert into sco_det_var_indicadores values(1,1,2,8,3,'DIVORCIADO/A',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,8,4,'UNION LIBRE',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,2,8,5,'VIUDO/A',1.50,null,null);----

insert into sco_det_var_indicadores values(1,2,2,6,1,'MENOR O IGUAL A $100.00',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,6,2,'DE $100.00 A $499.00',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,6,3,'DE $500.00 A $1000.00',2.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,6,4,'MÁS DE $1000.00',3.00,'A',null);----

insert into sco_det_var_indicadores values(1,2,2,7,1,'MÁS DE 3 AÑOS',2.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,7,2,'ENTRE DOS A TRES AÑOS',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,2,7,3,'MENOS DE 2 AÑOS',0.50,null,null);----

insert into sco_det_var_indicadores values(1,2,2,8,1,'SOLTERO/A',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,8,2,'CASADO/A',2.00,'A',null);
insert into sco_det_var_indicadores values(1,2,2,8,3,'DIVORCIADO/A',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,8,4,'UNION LIBRE',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,2,8,5,'VIUDO/A',1.50,null,null);----
-----------------------------------------------------------------------------

insert into sco_det_var_indicadores values(1,1,3,1,1,'S/N',0.00,'A','N');----

insert into sco_det_var_indicadores values(1,2,3,1,1,'S/N',0.00,'A','N');----
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,3,2,1,'MENOR O IGUAL AL 30%',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,3,2,2,'MAS DEL 30% AL 40%',2.00,null,null);
insert into sco_det_var_indicadores values(1,1,3,2,3,'MAS DEL 40% AL 50%',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,3,2,4,'MAS DEL 50%',1.00,null,null);---

insert into sco_det_var_indicadores values(1,2,3,2,1,'MENOR O IGUAL AL 30%',3.00,'A',null);
insert into sco_det_var_indicadores values(1,2,3,2,2,'MAS DEL 30% AL 40%',2.00,null,null);
insert into sco_det_var_indicadores values(1,2,3,2,3,'MAS DEL 40% AL 50%',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,3,2,4,'MAS DEL 50%',1.00,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,3,3,1,'S/N',0.00,'A','N');---

insert into sco_det_var_indicadores values(1,2,3,3,1,'S/N',0.00,'A','N');---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,3,4,1,'MAYOR A 1',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,3,4,2,'IGUAL A 1',2.50,null,null);
insert into sco_det_var_indicadores values(1,1,3,4,3,'MENOR A 1',2.00,null,null);---.

insert into sco_det_var_indicadores values(1,2,3,4,1,'MAYOR A 1',3.00,'A',null);
insert into sco_det_var_indicadores values(1,2,3,4,2,'IGUAL A 1',2.50,null,null);
insert into sco_det_var_indicadores values(1,2,3,4,3,'MENOR A 1',2.00,null,null);---.
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,3,5,1,'S/N',0.00,null,'N');---
insert into sco_det_var_indicadores values(1,1,3,6,1,'MAYOR A 1',2.00,'A',null);
insert into sco_det_var_indicadores values(1,1,3,6,2,'IGUAL A 1',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,3,6,3,'MENOR A 1',1.00,null,null);---
insert into sco_det_var_indicadores values(1,1,3,7,1,'S/N',0.00,null,'N');---
insert into sco_det_var_indicadores values(1,1,3,8,1,'MAYOR A 1',2.00,'A',null);
insert into sco_det_var_indicadores values(1,1,3,8,2,'IGUAL A 1',1.50,null,null);
insert into sco_det_var_indicadores values(1,1,3,8,3,'MENOR A 1',1.00,null,null);

insert into sco_det_var_indicadores values(1,1,4,1,1,'TERRENO VALDIO',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,4,1,2,'CASA',2.00,'A',null);---

insert into sco_det_var_indicadores values(1,2,4,1,1,'TERRENO VALDIO',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,4,1,2,'CASA',2.00,'A',null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,4,2,1,'TERRENO VALDIO',1.00,null,null);
insert into sco_det_var_indicadores values(1,1,4,2,2,'CASA',2.00,'A',null);---

insert into sco_det_var_indicadores values(1,2,4,2,1,'TERRENO VALDIO',1.00,null,null);
insert into sco_det_var_indicadores values(1,2,4,2,2,'CASA',2.00,'A',null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,4,3,1,'mas de 3 años',1.00,'A',null);
insert into sco_det_var_indicadores values(1,1,4,3,2,'menos de 3 años',0.50,null,null);---

insert into sco_det_var_indicadores values(1,2,4,3,1,'mas de 3 años',1.00,'A',null);
insert into sco_det_var_indicadores values(1,2,4,3,2,'menos de 3 años',0.50,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,4,4,1,'mas de 3 años',1.00,'A',null);
insert into sco_det_var_indicadores values(1,1,4,4,2,'menos de 3 años',0.50,null,null);---

insert into sco_det_var_indicadores values(1,2,4,4,1,'mas de 3 años',1.00,'A',null);
insert into sco_det_var_indicadores values(1,2,4,4,2,'menos de 3 años',0.50,null,null);---
-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,4,5,1,'PROPIA',1.00,'A',null);
insert into sco_det_var_indicadores values(1,1,4,5,2,'ARRENDADA',0.50,null,null);
insert into sco_det_var_indicadores values(1,1,4,5,3,'PRESTADA',0.50,null,null);
insert into sco_det_var_indicadores values(1,1,4,5,4,'FAMILIAR',0.50,null,null);---

insert into sco_det_var_indicadores values(1,2,4,5,1,'PROPIA',1.00,'A',null);
insert into sco_det_var_indicadores values(1,2,4,5,2,'ARRENDADA',0.50,null,null);
insert into sco_det_var_indicadores values(1,2,4,5,3,'PRESTADA',0.50,null,null);
insert into sco_det_var_indicadores values(1,2,4,5,4,'FAMILIAR',0.50,null,null);---
-----------------------------------------------------------------------------

insert into sco_det_var_indicadores values(1,1,5,1,1,'SIN COMPETENCIA EN EL MEDIO',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,5,1,2,'MEDIANA COMPETENCIA',2.50,null,null);
insert into sco_det_var_indicadores values(1,1,5,1,3,'ALTA COMPETENCIA',2.00,null,null);---

insert into sco_det_var_indicadores values(1,1,5,2,1,'SECTOR DE CRECIMIENTO',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,5,2,2,'SECTOR DE ESTABILIDAD',2.50,null,null);
insert into sco_det_var_indicadores values(1,1,5,2,3,'SECTOR ESTANCADO',2.00,null,null);
insert into sco_det_var_indicadores values(1,1,5,2,4,'SECTOR EN RECESION',0.00,null,null);---

insert into sco_det_var_indicadores values(1,2,5,1,1,'SECTOR DE CRECIMIENTO',3.00,'A',null);
insert into sco_det_var_indicadores values(1,2,5,1,2,'SECTOR DE ESTABILIDAD',2.50,null,null);
insert into sco_det_var_indicadores values(1,2,5,1,3,'SECTOR ESTANCADO',2.00,null,null);
insert into sco_det_var_indicadores values(1,2,5,1,4,'SECTOR EN RECESION',0.00,null,null);---

insert into sco_det_var_indicadores values(1,2,5,2,1,'ESTABLE',3.00,'A',null);
insert into sco_det_var_indicadores values(1,2,5,2,2,'MEDIA',1.50,null,null);
insert into sco_det_var_indicadores values(1,2,5,2,3,'RIESGO',0.50,null,null);

-----------------------------------------------------------------------------
insert into sco_det_var_indicadores values(1,1,5,3,1,'ALTA ACEPTACION',3.00,'A',null);
insert into sco_det_var_indicadores values(1,1,5,3,2,'MADIANA ACEPTACION',2.50,null,null);
insert into sco_det_var_indicadores values(1,1,5,3,3,'BAJA ACEPTACION',2.00,null,null);

create table sco_clientes(
emp_codigo smallint not null,
age_codigo smallint not null,
cli_codigo int not null,
tdo_codigo char(1) not null,
cli_identi varchar(15) not null,
cli_nrosoc varchar(10) not null,
cli_apelli varchar(100) not null,
cli_nombre varchar(100) not null,
cli_edad smallint not null,
cli_fecnac date not null,
cli_genero char(1) not null,
eci_codigo char(1) not null,--estado civil
pro_codigo smallint not null,
can_codigo smallint not null,
cli_dirdom text,
cli_secdom text,--SECTOR DOMIMICILIO
cli_telefo varchar(15),
cli_celula varchar(15),
cli_dirtra text,
cli_sectra text,
cli_teltra varchar(15),
unique(emp_codigo,cli_identi)
);
alter table sco_clientes add constraint pk_clis primary key (emp_codigo,cli_codigo);
insert into sco_clientes values(1,1,1,'C','0703887497',245875,'CHAMBA','BRYAN',27,'1996-01-10','M','C',1,1,'DIRDOM','SECDOM','000','111','DRITRA','SECTRA','333');

/*--------------------------*/
create table sco_tit_matrices(
emp_codigo smallint not null,
mat_codigo smallint not null,
tma_codigo smallint not null,
tma_descri varchar(100) not null,
tma_cobpat boolean not null--marca si se debe carcular la cobertura patrimonial	
);
alter table sco_tit_matrices add constraint pk_titmatr primary key (emp_codigo,mat_codigo,tma_codigo);
alter table sco_tit_matrices add constraint fk_titmatr_to_matr foreign key (emp_codigo,mat_codigo)
	references sco_matrices (emp_codigo,mat_codigo);
insert into sco_tit_matrices values(1,1,1,'DATOS DE LA UNIDAD FAMILIAR',false);
insert into sco_tit_matrices values(1,1,2,'ESTADO FINANCIERO',true);
insert into sco_tit_matrices values(1,2,1,'DATOS ECONÓMICOS',true);

create table sco_det_matrices(
emp_codigo smallint not null,
mat_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dma_descri varchar(100) not null,
dma_show boolean not null,
dma_signo char(1) not null
);
alter table sco_det_matrices add constraint pk_detmatr primary key (emp_codigo,mat_codigo,tma_codigo,dma_codigo);
alter table sco_det_matrices add constraint fk_detmatr_to_matr foreign key (emp_codigo,mat_codigo,tma_codigo)
	references sco_tit_matrices (emp_codigo,mat_codigo,tma_codigo);
insert into sco_det_matrices values(1,1,1,1,'NEGOCIO',true,'+');
insert into sco_det_matrices values(1,1,1,2,'FAMILIA',true,'+');
insert into sco_det_matrices values(1,1,2,1,'ACTIVOS',true,'+');
insert into sco_det_matrices values(1,1,2,2,'PASIVOS',true,'-');
insert into sco_det_matrices values(1,2,1,1,'INGRESOS',true,'+');
insert into sco_det_matrices values(1,2,1,2,'EGRESOS',true,'-');
insert into sco_det_matrices values(1,2,1,3,'PATRIMONIO',true,'+');

create table sco_det_matri_items(
emp_codigo smallint not null,
mat_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dmi_codigo smallint not null,
dmi_descri varchar(100) not null,
dmi_show boolean not null,
dmi_signo char(1) not null
);

alter table sco_det_matri_items add constraint pk_detmatritems primary key (emp_codigo,mat_codigo,tma_codigo,dma_codigo,dmi_codigo);
alter table sco_det_matri_items add constraint fk_detmatritems_to_detmatr foreign key (emp_codigo,mat_codigo,tma_codigo,dma_codigo)
	references sco_det_matrices (emp_codigo,mat_codigo,tma_codigo,dma_codigo);
insert into sco_det_matri_items values(1,1,1,1,1,'INGRESOS NEGOCIO',true,'+');
insert into sco_det_matri_items values(1,1,1,1,2,'(-) GASTOS NEGOCIO',true,'-');
insert into sco_det_matri_items values(1,1,1,2,1,'OTROS INGRESOS FAMILIARES',true,'+');
insert into sco_det_matri_items values(1,1,1,2,2,'(-) GASTOS FAMILIARES',true,'-');
insert into sco_det_matri_items values(1,1,2,1,1,'ACTIVO CORRIENTE',true,'+');
insert into sco_det_matri_items values(1,1,2,1,2,'ACTIVO FIJO',true,'+');
insert into sco_det_matri_items values(1,1,2,2,1,'PASIVO CORTO PLAZO',true,'+');
insert into sco_det_matri_items values(1,1,2,2,2,'PASIVO LARGO PLAZO',true,'+');

insert into sco_det_matri_items values(1,2,1,1,1,'FAMILIARES MENSUALES',true,'+');
insert into sco_det_matri_items values(1,2,1,1,2,'OTROS INGRESOS',true,'+');
insert into sco_det_matri_items values(1,2,1,2,1,'FAMILIARES MENSUALES',true,'+');
insert into sco_det_matri_items values(1,2,1,2,2,'DEUDAS FINANCIERAS',true,'+');
insert into sco_det_matri_items values(1,2,1,2,3,'OTROS GASTOS',true,'+');
insert into sco_det_matri_items values(1,2,1,3,1,'PATRIMONIO',true,'+');


create table sco_det_matri_items_det(
emp_codigo smallint not null,
mat_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dmi_codigo smallint not null,
mid_codigo smallint not null,
mid_descri varchar(100) not null,
mid_show boolean not null,
mid_signo char(1) not null
);
alter table sco_det_matri_items_det add constraint pk_detmatritemsdet primary key (emp_codigo,mat_codigo,tma_codigo,dma_codigo,dmi_codigo,mid_codigo);
alter table sco_det_matri_items_det add constraint fk_detmatritemsdet_to_detmatritems foreign key (emp_codigo,mat_codigo,tma_codigo,dma_codigo,dmi_codigo)
	references sco_det_matri_items (emp_codigo,mat_codigo,tma_codigo,dma_codigo,dmi_codigo);
insert into sco_det_matri_items_det values(1,1,1,1,1,1,'VENTAS DE CONTADO',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,1,2,'RECUPERACIÓN VENTAS CRÉDITO',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,1,3,'(-) COMPRAS',true,'-');
insert into sco_det_matri_items_det values(1,1,1,1,2,1,'SALARIOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,2,'FLETES',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,3,'SERVICIOS BÁSICOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,4,'CUOTA PRÉSTAMO (MENSUAL)',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,5,'MANTENIMIENTO/REPARACIÓN',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,6,'OTROS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,1,2,7,'IMPREVISTOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,1,1,'INGRESO SUELDOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,1,2,'INGRESO ARRIENDOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,1,3,'PENSIONES',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,1,4,'OTROS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,1,'ARRIENDO',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,2,'ALIMENTACIÓN',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,3,'SERVICIOS BÁSICOS',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,4,'TRANSPORTE/COMBUSTIBLE',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,5,'EDUCACIÓN',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,6,'SALUD',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,7,'INTERNET',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,8,'VESTIMENTA',true,'+');
insert into sco_det_matri_items_det values(1,1,1,2,2,9,'PLANES CELULARES',true,'+');

insert into sco_det_matri_items_det values(1,1,2,1,1,1,'EFECTIVO',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,2,'AHORROS EN LA INSTITUCIÓN',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,3,'AHORROS EN OTRAS INTITUCIONES',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,4,'MERCADERÍA E INSUMOS',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,5,'PRODUCTOS EN PROCESO',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,6,'CUENTAS POR COBRAR',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,1,7,'OTROS',true,'+');

insert into sco_det_matri_items_det values(1,1,2,1,2,1,'TERRENOS',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,2,'CASA',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,3,'MAQUINARIA/EQUIPO',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,4,'EQUIPOS TECNOLÓGICOS',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,5,'VEHÍCULOS',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,6,'MUEBLES Y ENSERES',true,'+');
insert into sco_det_matri_items_det values(1,1,2,1,2,7,'OTROS',true,'+');

insert into sco_det_matri_items_det values(1,1,2,2,1,1,'DEUDA INSTITUCIONES FINANCIERAS (DIRECTO)',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,1,2,'DEUDA INSTITUCIONES FINANCIERAS (INDIRECTO)',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,1,3,'TARJETAS DE CRÉDITO',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,1,4,'DEUDAS PROVEEDORES',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,1,5,'OTROS',true,'+');

insert into sco_det_matri_items_det values(1,1,2,2,2,1,'DEUDA INSTITUCIONES FINANCIERAS',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,2,2,'CRÉDITO EN LA INSTITUCIÓN',true,'+');
insert into sco_det_matri_items_det values(1,1,2,2,2,3,'OTROS',true,'+');


insert into sco_det_matri_items_det values(1,2,1,1,1,1,'SUELDO FIJO SOLICITANTE (RELACIÓN DEPENDENCIA)',true,'+');
insert into sco_det_matri_items_det values(1,2,1,1,1,2,'SUELDO FIJO CONYUGE (RELACIÓN DEPENDENCIA)',true,'+');
insert into sco_det_matri_items_det values(1,2,1,1,1,3,'INGRESO POR ARRIENDOS HABITACIONALES',true,'+');
insert into sco_det_matri_items_det values(1,2,1,1,1,4,'PENSIONES ALIMENTICIAS HIJOS O JUBILACIONES',true,'+');

insert into sco_det_matri_items_det values(1,2,1,1,2,1,'OTROS',true,'+');


insert into sco_det_matri_items_det values(1,2,1,2,1,1,'ALIMENTACIÓN FAMILIA CON CARGAS',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,2,'EDUCACIÓN',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,3,'VESTUARIO',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,4,'ARRIENDO',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,5,'SERVICIOS BÁSICOS',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,6,'PLANES CELULARES',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,7,'TRANSPORTE / COMBUSTIBLE',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,1,8,'INTERNET',true,'+');

insert into sco_det_matri_items_det values(1,2,1,2,2,1,'DEUDAS COOPERATIVA',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,2,2,'DEUDAS OTRAS INSTITUCIONES',true,'+');
insert into sco_det_matri_items_det values(1,2,1,2,2,3,'TARJETAS DE CRÉDITO',true,'+');

insert into sco_det_matri_items_det values(1,2,1,2,3,1,'OTROS',true,'+');

insert into sco_det_matri_items_det values(1,2,1,3,1,1,'EFECTIVO, BANCOS, COACS',true,'+');
insert into sco_det_matri_items_det values(1,2,1,3,1,2,'CASAS, TERRENOS',true,'+');
insert into sco_det_matri_items_det values(1,2,1,3,1,3,'VEHÍCULOS',true,'+');
insert into sco_det_matri_items_det values(1,2,1,3,1,4,'MUEBLES Y ENSERES',true,'+');
insert into sco_det_matri_items_det values(1,2,1,3,1,5,'MAQUINARIA',true,'+');
insert into sco_det_matri_items_det values(1,2,1,3,1,6,'OTROS',true,'+');

create table sco_sol_clientes(
emp_codigo smallint not null,
age_codigo smallint not null,
cli_codigo int not null,
scl_codigo smallint not null,
tdo_codigo char(1) not null,
cli_identi varchar(15) not null,
cli_nrosoc varchar(10) not null,
cli_apelli varchar(100) not null,
cli_nombre varchar(100) not null,
cli_edad smallint not null,
cli_fecnac date not null,
cli_genero char(1) not null,
eci_codigo char(1) not null,--estado civil
pro_codigo smallint not null,
can_codigo smallint not null,
cli_dirdom text,
cli_secdom text,--SECTOR DOMIMICILIO
cli_telefo varchar(15),
cli_celula varchar(15),
cli_dirtra text,
cli_sectra text,
cli_teltra varchar(15)
);
alter table sco_sol_clientes add constraint pk_sol_clis primary key (emp_codigo,cli_codigo,scl_codigo);
alter table sco_sol_clientes add constraint fk_solcli_to_cli foreign key (emp_codigo,cli_codigo)
	references sco_clientes (emp_codigo,cli_codigo);

create table sco_solicitudes(
age_codigo smallint not null,
sol_codigo int not null,
emp_codigo smallint not null,
cli_codigo int not null,
scl_codigo smallint not null,
aec_codigo smallint not null,
mat_codigo smallint not null,
sol_fecha date not null,
sol_monto numeric(12,2) not null,
sol_intere numeric(12,2) not null,
sol_plazo smallint not null,
sol_cuota numeric(12,2) not null,
sol_listas char(2) not null,
sol_vincul char(2) not null,
sol_inspec char(2) not null,
sol_estado char(1) not null,
sol_reccre char(2) not null,--recomienda el credito
sol_derecr text not null,--descripcion recomienda el credito
sol_auxest char(1) not null,
sol_marimp numeric(6,2) not null,--margen de imprevistos
sol_fecsis timestamp not null,
sol_usuari varchar(25) not null
);
alter table sco_solicitudes add constraint pk_solicit primary key (emp_codigo,age_codigo,sol_codigo);
alter table sco_solicitudes add constraint fk_solit_to_cli foreign key (emp_codigo,cli_codigo,scl_codigo)
	references sco_sol_clientes (emp_codigo,cli_codigo,scl_codigo);
alter table sco_solicitudes add constraint fk_solit_to_aec foreign key (aec_codigo)
	references tbl_act_economica (aec_codigo);
alter table sco_solicitudes add constraint fk_solit_to_matr foreign key (emp_codigo,mat_codigo)
	references sco_matrices (emp_codigo,mat_codigo);
alter table sco_solicitudes add constraint fk_solit_to_user foreign key (emp_codigo,sol_usuari)
	references sec_usuarios (emp_codigo,usu_login);

create table sco_sol_ponderaciones(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo smallint not null,
pon_codigo smallint not null,
pon_estado char(1) not null,
pon_estdes varchar(50) not null,
pon_minval numeric(5,2) not null,
pon_maxval numeric(5,2) not null,
pon_color varchar(75) not null,
pon_ponder char(1) not null -- para saber si el registro se toma en cuanta en la ponderación de datos.
);
alter table sco_sol_ponderaciones add constraint pk_sco_solpon primary key (emp_codigo,age_codigo,sol_codigo,pon_codigo);
alter table sco_sol_ponderaciones add constraint fk_lg_ponder_to_sol foreign key (emp_codigo,age_codigo,sol_codigo)
	references sco_solicitudes (emp_codigo,age_codigo,sol_codigo);

create table sco_log_impresiones(
lim_codigo serial not null,
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo int not null,
lim_filpdf varchar(150) not null,
lim_ipaddr varchar(33) not null,
lim_fecsis timestamp not null,
lim_usuari varchar(25) not null
);
alter table sco_log_impresiones add constraint pk_lg_impre primary key(lim_codigo);
alter table sco_log_impresiones add constraint fk_lg_impre_to_sol foreign key (emp_codigo,age_codigo,sol_codigo)
	references sco_solicitudes (emp_codigo,age_codigo,sol_codigo);

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_sol_create_sol(
p_emp_codigo smallint,
p_age_codigo smallint,
p_cli_codigo int,
p_aec_codigo smallint,
p_mat_codigo smallint,
p_sol_fecha date,
p_sol_monto numeric(12,2),
p_sol_intere numeric(12,2),
p_sol_plazo smallint,
p_sol_cuota numeric(12,2),
p_sol_listas char(2),
p_sol_vincul char(2),
p_sol_inspec char(2),
p_sol_usuari varchar(25)
)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ declare
   	valor character varying = '';
    auxnum int = 0;
    i record;
    codsol smallint;
    codclisol smallint;
begin
	select coalesce(max(sol_codigo), 0) + 1 from sco_solicitudes
		where emp_codigo = p_emp_codigo and age_codigo = p_age_codigo
		into codsol;
	
	select coalesce(max(scl_codigo), 0) + 1 from sco_sol_clientes
		where emp_codigo = p_emp_codigo and age_codigo = p_age_codigo and cli_codigo = p_cli_codigo
		into codclisol;
	
	insert into sco_sol_clientes select 
		emp_codigo,age_codigo,cli_codigo,codclisol,tdo_codigo,cli_identi,cli_nrosoc,
		cli_apelli,cli_nombre,cli_edad,cli_fecnac,cli_genero,eci_codigo,pro_codigo,
		can_codigo,cli_dirdom,cli_secdom,cli_telefo,cli_celula,cli_dirtra,cli_sectra,cli_teltra
		from sco_clientes where emp_codigo = p_emp_codigo and cli_codigo = p_cli_codigo;
	
	GET DIAGNOSTICS auxnum = ROW_COUNT;

	if auxnum > 0 then
		insert into sco_solicitudes values(
			p_age_codigo,
			codsol,
			p_emp_codigo,
			p_cli_codigo,
			codclisol,
			p_aec_codigo,
			p_mat_codigo,
			p_sol_fecha,
			p_sol_monto,
			p_sol_intere,
			p_sol_plazo,
			p_sol_cuota,
			p_sol_listas,
			p_sol_vincul,
			p_sol_inspec,
			'P',
			'',
			'',
			'A',
			(select mat_marimp from sco_matrices where emp_codigo = p_emp_codigo and mat_codigo = p_mat_codigo),
			current_timestamp,
			p_sol_usuari
		);
		perform * from f_car_solicitud(
			p_emp_codigo,
			p_age_codigo,
			codsol,
			p_mat_codigo
		);
		valor = '[true, "¡Registro guardado!",'||p_age_codigo||','||codsol||']';
	else
		valor = '[false, "¡No se pudo inserta información del cliente!"]';
	end if;
	
	return valor;
END;
$function$;
---///----///----
---///----///----
/*----------------------------------*/

create table sco_sol_tit_matrices(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo smallint not null,
tma_codigo smallint not null,
tma_descri varchar(100) not null,
tma_cobpat boolean not null	
);
alter table sco_sol_tit_matrices add constraint pk_sol_titmatr primary key (emp_codigo,age_codigo,sol_codigo,tma_codigo);
alter table sco_sol_tit_matrices add constraint fk_sol_titmatr_to_soli foreign key (emp_codigo,age_codigo,sol_codigo)
	references sco_solicitudes (emp_codigo,age_codigo,sol_codigo);

create table sco_sol_det_matrices(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dma_descri varchar(100) not null,
dma_show boolean not null,
dma_signo char(1) not null
);
alter table sco_sol_det_matrices add constraint pk_sol_detmatr primary key (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo);
alter table sco_sol_det_matrices add constraint fk_sol_detmatr_to_matr foreign key (emp_codigo,age_codigo,sol_codigo,tma_codigo)
	references sco_sol_tit_matrices (emp_codigo,age_codigo,sol_codigo,tma_codigo);

create table sco_sol_det_matri_items(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dmi_codigo smallint not null,
dmi_descri varchar(100) not null,
dmi_show boolean not null,
dmi_signo char(1) not null
);
alter table sco_sol_det_matri_items add constraint pk_sol_detmatritems primary key (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo,dmi_codigo);
alter table sco_sol_det_matri_items add constraint fk_sol_detmatritems_to_detmatr foreign key (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo)
	references sco_sol_det_matrices (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo);

create table sco_sol_det_matri_items_det(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo smallint not null,
tma_codigo smallint not null,
dma_codigo smallint not null,
dmi_codigo smallint not null,
mid_codigo smallint not null,
mid_descri varchar(100) not null,
mid_valor numeric(12,2) not null,
mid_signo char(1) not null
);
alter table sco_sol_det_matri_items_det add constraint pk_sol_detmatritemsdet primary key (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo,dmi_codigo,mid_codigo);
alter table sco_sol_det_matri_items_det add constraint fk_sol_detmatritemsdet_to_detmatritems foreign key (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo,dmi_codigo)
	references sco_sol_det_matri_items (emp_codigo,age_codigo,sol_codigo,tma_codigo,dma_codigo,dmi_codigo);

/*-------------------------------*/

create table sco_sol_indicadores(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo int not null,
ind_codigo smallint not null,
ind_descri varchar(50) not null,
ind_valpor numeric(5,2) not null
);
alter table sco_sol_indicadores add constraint pk_sco_sol_ind primary key (emp_codigo,age_codigo,sol_codigo,ind_codigo);

create table sco_sol_cab_var_indicadores(--variables de indicadores
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo int not null,
ind_codigo smallint not null,
cvi_codigo smallint not null,
cvi_descri varchar(150) not null,
cvi_valpor numeric(5,2) not null,
cvi_tomar char(1) null
);
alter table sco_sol_cab_var_indicadores add constraint pk_sco_sol_cabvar primary key (emp_codigo,age_codigo,sol_codigo,ind_codigo,cvi_codigo);

create table sco_sol_det_var_indicadores(
emp_codigo smallint not null,
age_codigo smallint not null,
sol_codigo int not null,
ind_codigo smallint not null,
cvi_codigo smallint not null,
dvi_codigo smallint not null,
dvi_descri varchar(150) not null,
dvi_valor numeric(5,2) not null,
dvi_select char(1) null,
dvi_defsel char(1) null,
dvi_tomar char(1) null
);
alter table sco_sol_det_var_indicadores add constraint pk_sco_sol_detvar primary key (emp_codigo,age_codigo,sol_codigo,ind_codigo,cvi_codigo,dvi_codigo);

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_sol_updated_acteco(
p_empcod smallint,
p_agecod smallint,
p_solcod smallint,
p_matcod smallint
)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ declare
   	valor character varying;
    auxnum int;
    i record;
begin
	valor = '';

	select case
			when a.aec_nivrie = 'A' then 1
			when a.aec_nivrie = 'M' then 2
			when a.aec_nivrie = 'B' then 3
			else 0
		end as nivel
		from sco_solicitudes s, tbl_act_economica a
		where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
		s.aec_codigo = a.aec_codigo
		into auxnum;
	
	if p_matcod = 1 then 
	
		update sco_sol_det_var_indicadores set dvi_select = null 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 1 and cvi_codigo = 9;
		
		update sco_sol_det_var_indicadores set dvi_select = 'A' 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 1 and cvi_codigo = 9 and dvi_codigo = auxnum;
		
	elseif p_matcod = 2 then
	
		update sco_sol_det_var_indicadores set dvi_select = null 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 1 and cvi_codigo = 4;
	
		update sco_sol_det_var_indicadores set dvi_select = 'A' 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 1 and cvi_codigo = 4 and dvi_codigo = auxnum;
	
	else
	
	end if;
	
	return valor;
END;
$function$;
---///----///----
---///----///----

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_car_solicitud(
p_empcod smallint,
p_agecod smallint,
p_solcod smallint,
p_matcod smallint
)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ declare
   	valor character varying;
    auxnum int;
    i record;
begin
	valor = '';

	insert into sco_sol_ponderaciones
		select emp_codigo,p_agecod,p_solcod,pon_codigo,pon_estado,pon_estdes,pon_minval,pon_maxval,pon_color,pon_ponder
		from sco_ponderaciones where emp_codigo = p_empcod and mat_codigo = p_matcod 
		order by pon_codigo;
	
	insert into sco_sol_tit_matrices 
		select emp_codigo,p_agecod,p_solcod,tma_codigo,tma_descri,tma_cobpat
		from sco_tit_matrices where emp_codigo = p_empcod and mat_codigo = p_matcod
		order by tma_codigo;
	
	insert into sco_sol_det_matrices
		select emp_codigo,p_agecod,p_solcod,tma_codigo,dma_codigo,dma_descri,dma_show,dma_signo
		from sco_det_matrices where emp_codigo = p_empcod and mat_codigo = p_matcod 
		order by tma_codigo,dma_codigo;
	
	insert into sco_sol_det_matri_items
		select emp_codigo,p_agecod,p_solcod,tma_codigo,dma_codigo,dmi_codigo,dmi_descri,dmi_show,dmi_signo
		from sco_det_matri_items where emp_codigo = p_empcod and mat_codigo = p_matcod 
		order by tma_codigo,dma_codigo,dmi_codigo;
	
	insert into sco_sol_det_matri_items_det
		select emp_codigo,p_agecod,p_solcod,tma_codigo,dma_codigo,dmi_codigo,mid_codigo,mid_descri,0.00,mid_signo
		from sco_det_matri_items_det where emp_codigo = p_empcod and mat_codigo = p_matcod 
		order by tma_codigo,dma_codigo,dmi_codigo,mid_codigo;
	
	/*---------------------------------*/
	
	insert into sco_sol_indicadores 
		select emp_codigo,p_agecod,p_solcod,ind_codigo,ind_descri,ind_valpor
		from sco_indicadores where emp_codigo = p_empcod and mat_codigo = p_matcod
		order by ind_codigo;
	
	insert into sco_sol_cab_var_indicadores 
		select emp_codigo,p_agecod,p_solcod,ind_codigo,cvi_codigo,cvi_descri,cvi_valpor,cvi_tomar
		from sco_cab_var_indicadores where emp_codigo = p_empcod and mat_codigo = p_matcod
		order by ind_codigo,cvi_codigo;
	
	insert into sco_sol_det_var_indicadores 
		select emp_codigo,p_agecod,p_solcod,ind_codigo,cvi_codigo,dvi_codigo,dvi_descri,dvi_valor,null,dvi_defsel,dvi_tomar
		from sco_det_var_indicadores where emp_codigo = p_empcod and mat_codigo = p_matcod
		order by ind_codigo,cvi_codigo,dvi_codigo;
	
	perform * from f_sol_updated_acteco(p_empcod,p_agecod,p_solcod,p_matcod);
	
	return valor;
END;
$function$;
---///----///----
---///----///----

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_cal_saldo(
p_empcod smallint,
p_agecod smallint,
p_solcod smallint
)
 RETURNS numeric(16,2)
 LANGUAGE plpgsql
AS $function$ declare
   	saldo numeric(16,2) = 0;
   	auxsal1 numeric(16,2) = 0;
   	auxsal2 numeric(16,2) = 0;
   	auxnum numeric(16,2) = 0;
    matcod smallint;
    i record;
begin

	select mat_codigo from sco_solicitudes 
		where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod
		into matcod;
	
	if matcod = 1 then --micro
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = matcod and dma_codigo = 1
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			auxsal1 = auxsal1 + auxnum;
		end loop;
		-------------------------  
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = matcod and dma_codigo = 2
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			auxsal2 = auxsal2 + auxnum;
		end loop;
		saldo = auxsal1 + auxsal2;
	end if;

	if matcod = 2 then --consu
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = 1 and dma_codigo = 1
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			auxsal1 = auxsal1 + auxnum;
		end loop;
		-------------------------
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = 1 and dma_codigo = 2
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			auxsal2 = auxsal2 + auxnum;
		end loop;
		saldo = auxsal1 - auxsal2;
	end if;
	
	return saldo;
END;
$function$;
---///----///----
---///----///----

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_cal_total_pasivo_egresos(
p_empcod smallint,
p_agecod smallint,
p_solcod smallint
)
 RETURNS numeric(16,2)
 LANGUAGE plpgsql
AS $function$ declare
   	total numeric(16,2) = 0;
   	auxnum numeric(16,2) = 0;
    matcod smallint;
    i record;
begin

	select mat_codigo from sco_solicitudes 
		where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod
		into matcod;
	
	if matcod = 1 then --micro
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = 2 and dma_codigo = 2
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			total = total + auxnum;
		end loop;
	end if;

	if matcod = 2 then --consu
		for i in 
			select tm.dmi_descri,tm.dmi_signo,
			(coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) 
			- 
			coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
				where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '-'),0)) as valor 
			from sco_sol_det_matri_items tm 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and tma_codigo = 1 and dma_codigo = 1 and dmi_codigo = 1
		loop
			if i.dmi_signo = '+' then auxnum = i.valor; else auxnum = i.valor*-1; end if;
			total = total + auxnum;
		end loop;
	end if;
	
	return total;
END;
$function$;
---///----///----
---///----///----

---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_cal_solicitud(
p_empcod smallint,
p_agecod smallint,
p_solcod smallint
)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ declare
   	valor character varying;
    matcod smallint;
    monto numeric(12,2);
    auxnua numeric(10,2) = 0;
   	auxnub numeric(10,2) = 0;
    auxnuc numeric(10,2) = 0;
    auxnud numeric(10,2) = 0;
    i record;
   	auxiliar numeric(16,2);
    saldo numeric(16,2);
    total_pasivo_egreso numeric(16,2);
    ingresos numeric(16,2);
    egresos numeric(16,2);
begin
	valor = '';

	select mat_codigo,sol_monto from sco_solicitudes 
		where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod
		into matcod,monto;
	
	select * from f_cal_saldo(p_empcod,p_agecod,p_solcod) into saldo;
	select * from f_cal_total_pasivo_egresos(p_empcod,p_agecod,p_solcod) into total_pasivo_egreso;
	
	if matcod = 1 then --micro
		for i in 
			select * from sco_sol_det_var_indicadores 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 3 and cvi_codigo in (1,3,5,7)
		loop
			if i.cvi_codigo = 1 then --Capacidad endeudamiento
				if (total_pasivo_egreso+monto) > 0 then 
					auxiliar = saldo/(total_pasivo_egreso+monto);
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;
		
			if i.cvi_codigo = 3 then --Indice solvencia
				if total_pasivo_egreso > 0 then 
					auxiliar = saldo/total_pasivo_egreso;
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;
		
			if i.cvi_codigo = 5 then --Indice liquidez
				if total_pasivo_egreso > 0 then
					select (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
							where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0) / total_pasivo_egreso) as valor
						from sco_sol_det_matri_items tm 
						where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
							tma_codigo = 2 and dma_codigo = 1 and dmi_codigo = 1
						into auxiliar;
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;
		
			if i.cvi_codigo = 7 then --Capital de trabajo
				select (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
						where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0)) as valor
					from sco_sol_det_matri_items tm 
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						tma_codigo = 2 and dma_codigo = 2 and dmi_codigo = 1
					into auxiliar;
				if auxiliar > 0 then
					select (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
							where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0)) as valor
						from sco_sol_det_matri_items tm 
						where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
							tma_codigo = 2 and dma_codigo = 1 and dmi_codigo = 1
						into auxiliar;
					select auxiliar / (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
							where emp_codigo = tm.emp_codigo and age_codigo = tm.age_codigo and sol_codigo = tm.sol_codigo and tma_codigo = tm.tma_codigo and dma_codigo = tm.dma_codigo and dmi_codigo = tm.dmi_codigo and mid_signo = '+'),0)) as valor
						from sco_sol_det_matri_items tm 
						where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
							tma_codigo = 2 and dma_codigo = 2 and dmi_codigo = 1
						into auxiliar;
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;
		
		end loop;
	end if;
	if matcod = 2 then --consu
		select (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
			where emp_codigo = 1 and age_codigo = 1 and sol_codigo = 2 and tma_codigo = 1 and dma_codigo = 1),0)) as ingresos
			into ingresos;
		select (coalesce((select sum(mid_valor) from sco_sol_det_matri_items_det 
			where emp_codigo = 1 and age_codigo = 1 and sol_codigo = 2 and tma_codigo = 1 and dma_codigo = 2),0)) as egresos
			into egresos;
		for i in 
			select * from sco_sol_det_var_indicadores 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
			ind_codigo = 3 and cvi_codigo in (1,3,5,7)
		loop
			
			if i.cvi_codigo = 1 then --Capacidad endeudamiento
				if (egresos+monto) > 0 then 
					auxiliar = ingresos/(egresos+monto);
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;

			if i.cvi_codigo = 3 then --Indice solvencia
				if egresos > 0 then 
					auxiliar = ingresos/egresos;
					update sco_sol_det_var_indicadores set 
						dvi_descri = auxiliar::character varying,
						dvi_valor = auxiliar,
						dvi_select = 'A'
					where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and 
						ind_codigo = 3 and cvi_codigo = i.cvi_codigo;
				end if;
			end if;

		end loop;
	end if;
	-----------------------------------------------------------------------------
	-----------------------------------------------------------------------------
	if true then
		--metodo uno select * from sco_sol_cab_var_indicadores
		select coalesce(sum((d.dvi_valor*c.cvi_valpor)/100)*(ins.ind_valpor/100), 0) as ponderacion
			from sco_sol_cab_var_indicadores c, sco_sol_det_var_indicadores d, sco_sol_indicadores ins
			where c.emp_codigo = d.emp_codigo and c.sol_codigo = d.sol_codigo and 
			c.ind_codigo = d.ind_codigo and c.cvi_codigo = d.cvi_codigo and 
			c.emp_codigo = ins.emp_codigo and c.sol_codigo = ins.sol_codigo and 
			c.ind_codigo = ins.ind_codigo and 
			c.emp_codigo = p_empcod and 
			c.age_codigo = p_agecod and 
			c.sol_codigo = p_solcod and 
			d.dvi_select = 'A' and 
			d.dvi_tomar is null
			group by ins.ind_valpor
			into auxnud;
		for i in select 
			pon_estado, pon_minval as vmin, pon_maxval as vmax
			from sco_sol_ponderaciones 
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and pon_ponder = 'S'
		loop 
			if auxnud >= i.vmin and auxnud <= i.vmax then 
				update sco_solicitudes set sol_estado = i.pon_estado
			       where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod;
			end if;
		end loop;
		--fin metodo uno
	else
		--metodo dos
		select sum(dvi_valor) from sco_sol_det_var_indicadores  
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and dvi_defsel is not null
			into auxnua;
	
		select count(dvi_valor),coalesce(sum(dvi_valor),0) from sco_sol_det_var_indicadores  
			where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod and dvi_select is not null
			into auxnub,auxnuc;
		
		auxnud = auxnuc / auxnua;
	
		if auxnub >= 5 then
		update sco_solicitudes set sol_estado = case
	           when auxnud > 0.79 then 'A'
	           when auxnud > 0.6 and auxnud < 0.79 then 'S'
	           else 'R'
	       end
	       where emp_codigo = p_empcod and age_codigo = p_agecod and sol_codigo = p_solcod;
		end if;
		--fin metodo dos
	end if;

	valor = auxnua::character varying||' -- '||
	auxnuc::character varying||' -- '||
	auxnud::character varying;
	return valor;
END;
$function$;
---///----///----
---///----///----
-- select * from f_cal_solicitud(1::smallint,1::smallint,2::smallint);
---///----///----
---///----///----
CREATE OR REPLACE FUNCTION f_add_usuario(
p_empcod smallint,
p_agecod smallint,
p_usuari character varying,
p_contra character varying,
p_cedula character varying,
p_apelli character varying,
p_nombre character varying,
p_email character varying,
p_curusu character varying
)
 RETURNS smallint
 LANGUAGE plpgsql
AS $function$ declare
   	valor smallint = 0;
    duscod smallint;
    i record;
begin

	select coalesce(max(dus_codigo),0)+1 from tbl_dat_usuarios 
		where emp_codigo = p_empcod
		into duscod;
	
	insert into tbl_dat_usuarios values(
		p_empcod,duscod,'C',p_cedula,p_apelli,p_nombre,p_email,p_usuari,current_timestamp
	) returning dus_codigo into valor;

	if valor > 0 then
		insert into sec_usuarios values(
			p_empcod,p_agecod,duscod,p_usuari,p_contra,'A','all',p_curusu,current_timestamp
		);
	else
		valor = -1;
	end if;
	
	return valor;
END;
$function$;
---///----///----
---///----///----

---///----///----
---///----///----
---///----///----
---///----///----
---///----///----
---///----///----
-----SISTEMA-----
---///----///----
---///----///----
---///----///----
---///----///----
---///----///----
---///----///----