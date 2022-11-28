--crear un esquema de trabajo
CREATE SCHEMA practica_ee AUTHORIZATION gwxlnkne;

--crear la tabla de grupos de empresas
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
			kilometros decimal(8,2) not null,
			importe decimal(3,2) not null,
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
			nombre varchar(200) not null,
			id_tipo_seguro varchar(10) not null,	--FK3
			prima_anual decimal(5,2) not null,
			pagos_extra decimal(5,2) not null,
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

--rellenar la tabla de grupos de empresas
INSERT INTO practica_ee.grupos
(id_grupo, nombre, comentario)
VALUES('01', 'VAN', '');






