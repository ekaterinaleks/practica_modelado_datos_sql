--DROP SCHEMA practica_ee CASCADE;

--crear un esquema de trabajo
CREATE SCHEMA practica_ee AUTHORIZATION gwxlnkne;

--crear la tabla de grupos automovilísticos
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


--crear la tabla de divisas
CREATE TABLE practica_ee.divisas(
			id_divisa varchar(10) not null,		--PK
			codigo varchar(10) not null,
			nombre varchar(200) not null,
			comentario varchar(512) null
);

ALTER TABLE practica_ee.divisas
ADD CONSTRAINT divisas_PK primary key(id_divisa);

--crear la tabla de coches
CREATE TABLE practica_ee.coches(
			id_coche varchar(10) not null, 	    --PK
			matricula varchar(15) not null,
			color varchar(20) not null,
			fecha_compra date not null default '4000-01-01',
			id_modelo varchar(10) not null, 	--FK
			comentario varchar(512) null
);

ALTER TABLE practica_ee.coches
ADD CONSTRAINT coches_PK primary key(id_coche);

ALTER TABLE practica_ee.coches
ADD CONSTRAINT coches_FK foreign key(id_modelo)
REFERENCES practica_ee.modelos(id_modelo);


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
VALUES('01', 'PSA', 'Peugeot Société Anonyme');

INSERT INTO practica_ee.grupos
(id_grupo, nombre, comentario)
VALUES('02', 'Volkswagen', 'Volkswagen AG');

--rellenar la tabla de marcas de coches

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('01', 'Citroën', '01', 'Automobiles Citroën');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('02', 'Opel', '01', 'Opel Automobile GmbH');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('03', 'Peugeot', '01', 'Société des automobiles Peugeot');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('04', 'Skoda', '02', 'Škoda Auto a.s.');

INSERT INTO practica_ee.marcas
(id_marca, nombre, id_grupo, comentario)
VALUES('05', 'Volkswagen', '02', ' VW');

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
VALUES('05', 'Volkswagen Golf', '05', '');

--rellenar la tabla de coches
INSERT INTO practica_ee.coches
(id_coche, matricula, color, fecha_compra, id_modelo)
VALUES('01', '1111 BBBB', 'azul', '2008-08-09', '05');

INSERT INTO practica_ee.coches
(id_coche, matricula, color, fecha_compra, id_modelo)
VALUES('02', '3333 DDDD', 'verde', '2009-02-09', '04');

INSERT INTO practica_ee.coches
(id_coche, matricula, color, fecha_compra, id_modelo)
VALUES('03', '7777 KKKK', 'gris', '2010-02-09', '03');

INSERT INTO practica_ee.coches
(id_coche, matricula, color, fecha_compra, id_modelo)
VALUES('04', '5555 LLLL', 'blanco', '2018-02-09', '02');

INSERT INTO practica_ee.coches
(id_coche, matricula, color, fecha_compra, id_modelo)
VALUES('05', '9999 NNNN', 'negro', '2019-08-09', '01');


--rellenar la tabla de divisas
INSERT INTO practica_ee.divisas
(id_divisa, codigo, nombre)
VALUES('01', 'EUR', 'euro');

INSERT INTO practica_ee.divisas
(id_divisa, codigo, nombre)
VALUES('02', 'USD', 'dólar estadounidense');

--rellenar la tabla de revisiones
INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('01', '2019-01-01', 200000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('01', '2020-01-01', 250000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('02', '2019-01-01', 300000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('02', '2020-01-01', 360000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('03', '2019-01-01', 1500000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('03', '2020-01-01', 1700000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('04', '2019-01-01', 70000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('04', '2020-01-01', 90000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('05', '2019-01-01', 40000, 50, '01');

INSERT INTO practica_ee.revisiones
(id_coche, fecha_revision, kilometros, importe, id_divisa)
VALUES('05', '2020-01-01', 50000, 50, '01');

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
VALUES('02', 'Seguro a terceros ampliado', 'Responsabilidad civil voluntaria, la defensa y reclamación y el seguro de accidentes');

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
VALUES('987654321', '01', '02', '01', 130, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('654321789', '02', '03', '02', 150, 0, '01', '2016-10-01', '2017-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('678954321', '03', '01', '03', 300, 100, '01', '2016-10-01', '2017-01-01', '2020-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('679845321', '03', '02', '01', 130, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('55779321', '04', '01', '04', 450, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

INSERT INTO practica_ee.polizas
(num_poliza, id_coche, id_aseguradora, id_tipo_seguro, prima_anual, pagos_extra, id_divisa, fecha_contratacion, fecha_inicio, fecha_fin)
VALUES('112256789', '05', '03', '03', 300, 0, '01', '2019-10-01', '2020-01-01', '2023-01-01');

