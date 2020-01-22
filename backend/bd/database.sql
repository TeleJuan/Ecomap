CREATE TABLE usuario
(
    email VARCHAR(255),
    user_name VARCHAR(255),
    user_pass VARCHAR(255),
    points VARCHAR(255)
);

CREATE TABLE contenedor
(
    user_name VARCHAR(255),
    codigo_qr VARCHAR(255),
);

CREATE TABLE pto_reciclaje
(
    ubicacion VARCHAR(255),
);

CREATE TABLE pto_recogida
(
    user_name VARCHAR(255),
    ubicacion VARCHAR(255),
);

CREATE TABLE evento_reciclar
(
    fecha DATETIME,
    user_name VARCHAR(255),
    pto_reciclaje VARCHAR(255),
);

CREATE TABLE evento_recoger
(
    fecha DATETIME,
    user_name VARCHAR(255),
    pto_recogida VARCHAR(255),
);

CREATE TABLE evento_depositar
(
    fecha DATETIME,
    user_name VARCHAR(255),
    contenedor_id VARCHAR(255),
);

CREATE TABLE objeto
(
    type_name VARCHAR(255),
);

CREATE TABLE tipo_objeto
(
    type_name VARCHAR(255),
);

