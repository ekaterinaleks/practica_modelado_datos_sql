--crear un esquema de trabajo
CREATE SCHEMA practica_ee AUTHORIZATION gwxlnkne;

--crear la tabla de grupos automovilisticos
CREATE TABLE practica_ee.grupos(
			id_grupo varchar(10) not null,    --PK
			nombre varchar(200) not null,
			comentario varchar(512) null
);

ALTER TABLE practica_ee.grupos
ADD CONSTRAINT grupos_PK primary key(id_grupo);

--crear la tabla de marcas de coches
CREATE TABLE practica_ee.marcas(
			id_marca varchar(10) not null,    --PK
			nombre varchar(200) not null,
			id_grupo varchar(10) not null,   --FK
			comentario varchar(512) null
);

ALTER TABLE practica_ee.marcas
ADD CONSTRAINT marcas_PK primary key(id_marca);

ALTER TABLE practica_ee.marcas
ADD CONSTRAINT marcas_FK foreign key(id_grupo)
REFERENCES practica_ee.grupos(id_grupo);

--crear la tabla de modelos de coches
CREATE TABLE practica_ee.modelos(
			id_modelo varchar(10) not null, 	--PK
			nombre varchar(200) not null,
			id_marca varchar(10) not null, 		--FK
			comentario varchar(512) null 

);

ALTER TABLE practica_ee.modelos
ADD CONSTRAINT modelos_PK primary key(id_modelo);

ALTER TABLE practica_ee.modelos
ADD CONSTRAINT modelos_FK foreign key(id_marca)
REFERENCES practica_ee.marcas(id_marca);

--crear la tabla de colores
CREATE TABLE practica_ee.colores(
			id_color varchar(10) not null, 	--PK
			nombre varchar(50) not null
);

 ALTER TABLE practica_ee.colores
 ADD CONSTRAINT colores_PK primary key(id_color);

--crear la tabla de coches
CREATE TABLE practica_ee.coches(
			id_coche varchar(10) not null, 	    --PK
			matricula varchar(15) not null,
			id_color varchar(10) not null,		--FK1
			fecha_compra date not null default '4000-01-01',
			id_modelo varchar(10) not null, 	--FK2
			flag_activo boolean not null default true,
			comentario varchar(512) null
);

ALTER TABLE practica_ee.coches
ADD CONSTRAINT coches_PK primary key(id_coche);

ALTER TABLE practica_ee.coches
ADD CONSTRAINT coches_FK1 foreign key(id_modelo)
REFERENCES practica_ee.modelos(id_modelo);

ALTER TABLE practica_ee.coches
ADD CONSTRAINT coches_FK2 foreign key(id_color)
REFERENCES practica_ee.colores(id_color);

--crear la tabla de divisas
CREATE TABLE practica_ee.divisas(
			id_divisa varchar(10) not null,		--PK
			codigo varchar(10) not null,
			nombre varchar(200) not null,
			comentario varchar(512) null
);

ALTER TABLE practica_ee.divisas
ADD CONSTRAINT divisas_PK primary key(id_divisa);

--crear la tabla de revisiones
CREATE TABLE practica_ee.revisiones(
			id_coche varchar(10) not null,	    --PK,FK
			fecha_revision date not null default '4000-01-01',   --PK
			kilometros decimal(14,2) not null,
			importe decimal(9,2) not null,
			id_divisa varchar(10) not null, 	--FK
			comentario varchar(512) null
);

ALTER TABLE practica_ee.revisiones
ADD CONSTRAINT revisiones_PK primary key(id_coche, fecha_revision);

ALTER TABLE practica_ee.revisiones
ADD CONSTRAINT revisones_FK1 foreign key(id_coche)
REFERENCES practica_ee.coches(id_coche);

ALTER TABLE practica_ee.revisiones
ADD CONSTRAINT revisiones_FK2 foreign key(id_divisa)
REFERENCES practica_ee.divisas(id_divisa);

--crear la tabla de aseguradoras
CREATE TABLE practica_ee.aseguradoras(
			id_aseguradora varchar(10) not null, 	--PK
			nombre varchar(200) not null,
			comentario varchar(512) null

);

ALTER TABLE practica_ee.aseguradoras
ADD CONSTRAINT aseguradoras_PK primary key(id_aseguradora);


--crear la tabla de tipos de seguro
CREATE TABLE practica_ee.tipo_seguro(
			id_tipo_seguro varchar(10) not null, 	--PK
			nombre varchar(200) not null,
			comentario varchar(512) null
);

ALTER TABLE practica_ee.tipo_seguro
ADD CONSTRAINT tipo_seguro_PK primary key(id_tipo_seguro);



--crear la tabla de polizas
CREATE TABLE practica_ee.polizas(
			num_poliza varchar(20) not null, --PK
			id_coche varchar(10) not null, --PK, FK1
			id_aseguradora varchar(10) not null, --FK2
			id_tipo_seguro varchar(10) not null,	--FK3
			prima_anual decimal(11,2) not null,
			pagos_extra decimal(11,2) not null,
			id_divisa varchar(10) not null, 	--FK4
			fecha_contratacion date not null default '4000-01-01',
			fecha_inicio date not null default '4000-01-01',
			fecha_fin date not null default '4000-01-01',
			comentario varchar(512) null

);

ALTER TABLE practica_ee.polizas
ADD CONSTRAINT polizas_PK primary key(num_poliza, id_coche);

ALTER TABLE practica_ee.polizas
ADD CONSTRAINT polizas_FK1 foreign key(id_coche)
REFERENCES practica_ee.coches(id_coche);

ALTER TABLE practica_ee.polizas
ADD CONSTRAINT polizas_FK2 foreign key(id_aseguradora)
REFERENCES practica_ee.aseguradoras(id_aseguradora);

ALTER TABLE practica_ee.polizas
ADD CONSTRAINT polizas_FK3 foreign key(id_tipo_seguro)
REFERENCES practica_ee.tipo_seguro(id_tipo_seguro);

ALTER TABLE practica_ee.polizas
ADD CONSTRAINT polizas_FK4 foreign key(id_divisa)
REFERENCES practica_ee.divisas(id_divisa);

--rellenar la tabla de grupos automovilísticos
INSERT INTO practica_ee.grupos
(id_grupo, nombre, comentario)
VALUES('01', 'PSA', 'Peugeot Societe Anonyme');

INSERT INTO practica_ee.grupos
(id_grupo, nombre, comentario)
VALUES('02', 'Volkswagen', 'Volkswagen Aktiengesellschaft');

--rellenar la tabla de marcas de coches

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('01', 'Citroen', '01', 'Automobiles Citroen');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('02', 'Opel', '01', 'Opel Automobile GmbH');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('03', 'Peugeot', '01', 'Societe des automobiles Peugeot');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('04', 'Skoda', '02', 'Skoda Auto a.s.');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('05', 'SEAT', '02', 'Sociedad Espanola de Automoviles de Turismo');

--rellenar la tabla de modelos de coches
INSERT INTO practica_ee.modelos 
(id_modelo, nombre, id_marca, comentario)
VALUES('01', 'Citroen C4', '01', '');

INSERT INTO practica_ee.modelos 
(id_modelo, nombre, id_marca, comentario)
VALUES('02', 'Opel Astra', '02', '');

INSERT INTO practica_ee.modelos 
(id_modelo, nombre, id_marca, comentario)
VALUES('03', 'Peugeot 308', '03', '');

INSERT INTO practica_ee.modelos 
(id_modelo, nombre, id_marca, comentario)
VALUES('04', 'Skoda Octavia', '04', '');

INSERT INTO practica_ee.modelos 
(id_modelo, nombre, id_marca, comentario)
VALUES('05', 'SEAT Ibiza', '05', '');

--rellenar la tabla de colores
INSERT INTO practica_ee.colores
(id_color, nombre)
VALUES('01','azul');

INSERT INTO practica_ee.colores
(id_color, nombre)
VALUES('02','verde');

INSERT INTO practica_ee.colores
(id_color, nombre)
VALUES('03','gris');

INSERT INTO practica_ee.colores
(id_color, nombre)
VALUES('04','negro');

INSERT INTO practica_ee.colores
(id_color, nombre)
VALUES('05','beige');

--rellenar la tabla de coches
INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo)
VALUES('01', '1111 BBBB', '05', '2008-08-09', '05');

INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo)
VALUES('02', '3333 DDDD', '04', '2009-02-09', '04');

INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo)
VALUES('03', '7777 KKKK', '03', '2010-02-09', '03');

INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo)
VALUES('04', '5555 LLLL', '02', '2018-02-09', '02');

INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo)
VALUES('05', '9999 NNNN', '01', '2019-08-09', '01');

INSERT INTO practica_ee.coches
(id_coche, matricula, id_color, fecha_compra, id_modelo, flag_activo)
VALUES('06', '0000 PPPP', '05', '1999-08-09', '01', false);


--rellenar la tabla de divisas
INSERT INTO practica_ee.divisas
(id_divisa, codigo, nombre)
VALUES('01', 'EUR', 'euro');

INSERT INTO practica_ee.divisas
(id_divisa, codigo, nombre)
VALUES('02', 'USD', 'd�lar estadounidense');

--rellenar la tabla de revisiones
INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('01', '2019-01-01', 2000000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('01', '2020-01-01', 2500000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('02', '2019-01-01', 3000000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('02', '2020-01-01', 3600000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('03', '2019-01-01', 1500000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('03', '2020-01-01', 1700000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('04', '2019-01-01', 700000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('04', '2020-01-01', 900000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('05', '2019-01-01', 400000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('05', '2020-01-01', 500000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('06', '2015-01-01', 50000000, 50, '01');

--rellenar la tabla de aseguradoras
INSERT INTO practica_ee.aseguradoras
(id_aseguradora, nombre)
VALUES('01', 'Mapfre');

INSERT INTO practica_ee.aseguradoras
(id_aseguradora, nombre)
VALUES('02', 'Allianz');

INSERT INTO practica_ee.aseguradoras
(id_aseguradora, nombre)
VALUES('03', 'Axa');

--rellenar la tabla de tipos de seguro
INSERT INTO practica_ee.tipo_seguro
(id_tipo_seguro, nombre, comentario)
VALUES('01', 'Seguro a terceros', 'Responsabilidad civil obligatoria');

INSERT INTO practica_ee.tipo_seguro
(id_tipo_seguro, nombre, comentario)
VALUES('02', 'Seguro a terceros ampliado', 'Responsabilidad civil voluntaria, la defensa y reclamaci�n y el seguro de accidentes');

INSERT INTO practica_ee.tipo_seguro
(id_tipo_seguro, nombre, comentario)
VALUES('03', 'Seguro a todo riesgo con franquicia', 'Se abona una parte del coste de las reparaciones o servicios de asistencia');

INSERT INTO practica_ee.tipo_seguro
(id_tipo_seguro, nombre, comentario)
VALUES('04', 'Seguro a todo riesgo sin franquicia', 'La aseguradora asume por completo los costes');

--rellenar la tabla de polizas
INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('123456789', '01', '03', '01', 130, 50, '01', '2016-10-01', '2017-01-01', '2020-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('987654322', '01', '02', '01', 130, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('554321789', '02', '03', '02', 150, 0, '01', '2017-10-01', '2018-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('978954311', '03', '01', '03', 300, 100, '01', '2016-10-01', '2017-01-01', '2020-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('779845321', '03', '02', '01', 130, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('557793212', '04', '01', '04', 450, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('112256789', '05', '03', '03', 300, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('000056789', '06', '01', '01', 130, 200, '01', '1999-10-01', '1999-01-01', '2020-01-01');

