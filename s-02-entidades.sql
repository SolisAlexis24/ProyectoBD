--@Autor(es): Solis Hernández Ian Alexis
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear las tablas del proyecto

connect sc_proy_admin/admin

--==============================
--Tabla: Pasajero
--==============================
create table pasajero(
  pasajero_id         number(10,0),
  curp                varchar2(18)   not null,
  nombre              varchar2(40)   not null,
  apellido_paterno    varchar2(40)   not null,
  apellido_materno    varchar2(40),
  email               varchar2(40),
  fecha_nacimiento    date           not null,
  constraint pasajero_pk primary key(pasajero_id),
  constraint pasajero_curp_uk unique(curp)
);

--==============================
--Tabla: Tipo paquete
--==============================
create table tipo_paquete(
  tipo_paquete_id          number(10,0),
  clave                    varchar2(15)    not null,
  descripcion              varchar2(100)   not null,
  instrucciones            varchar2(200)   not null,
  constraint tipo_paquete_pk primary key(tipo_paquete_id),
  constraint tipo_paquete_clave_uk unique(clave)
);

--==============================
--Tabla: Aeropuerto
--==============================
create table aeropuerto(
  aeropuerto_id     number(10,0),
  clave             varchar2(13)  not null,
  nombre            varchar2(40)  not null,
  latitud           number(10,0)  not null,
  longitud          number(10,0)  not null,
  activo            number(1,0)   not null,
  constraint aeropuerto_pk primary key(aeropuerto_id),
  constraint aeropuerto_clave_uk unique(clave),
  constraint aeropuerto_tipo_chk check(activo = 1 or activo = 0)
);

--==============================
--Tabla: Estado del vuelo
--==============================
create table vuelo_estado(
  vuelo_estado_id     number(10,0),
  clave               varchar2(15)    not null,
  descripcion         varchar2(30)    not null,
  activo              number(1,0)     not null,
  constraint vuelo_estado_pk primary key(vuelo_estado_id),
  constraint vuelo_estado_clave_pk unique(clave),
  constraint vuelo_estado_tipo_chk check(activo = 1 or activo = 0)
);

--==============================
--Tabla: Rol 
--==============================
create table rol(
  rol_id        number(10,0),
  nombre        varchar2(40)   not null,
  descripcion   varchar2(40)   not null,
  constraint rol_id_pk primary key(rol_id)
);

--==============================
--Tabla: Puesto
--==============================

create table puesto(
  puesto_id         number(10,0),
  clave             varchar2(20)  not null,
  nombre            varchar2(30)  not null,
  descripcion       varchar2(40)  not null,
  sueldo_mensual    number(8,2)   not null,
  sueldo_quincenal  number(8,2)  as(sueldo_mensual/2),
  constraint puesto_puesto_pk primary key(puesto_id),
  constraint puesto_clave_uk unique(clave)
);

--==============================
--Tabla: Empleado
--==============================
create table empleado(
  empleado_id       number(10,0),
  nombre            varchar2(40) not null,
  apellidos         varchar2(40) not null,
  rfc               varchar2(13) not null,
  curp              varchar2(18) not null,
  foto              BLOB         null,
  puesto_id                      not null,
  jefe_id                            null,
  constraint empleado_empleado_pk primary key(empleado_id),
  constraint empleado_rfc_uk unique(rfc),
  constraint empleado_curp_uk unique(curp),
  constraint empleado_puesto_id_fk foreign key(puesto_id) 
    references puesto(puesto_id),
  constraint empleado_empleado_id_fk foreign key(jefe_id) 
    references empleado(empleado_id)
);

--==============================
--Tabla: Pagina(s) web del empleado
--==============================

create table pag_web_emp(
  pag_web_emp_id    number(10,0)  not null,
  direccion         varchar2(200) not null,
  empleado_id                     not null,
  constraint pag_web_emp_pk primary key(pag_web_emp_id),
  constraint pag_web_emp_empleado_id_fk foreign key(empleado_id)
    references empleado(empleado_id)
);

--=====================================================================================
--==============================
--Tabla: SUPERTIPO Aeronave
--==============================
create table aeronave(
  aeronave_id             number(10,0),
  es_carga                number(1,0)     not null,
  es_comercial            number(1,0)     not null,
  matricula               varchar2(10)    not null,
  modelo                  varchar2(50)    not null,
  especificaciones_pdf    varchar2(50)    not null,
  constraint aeronave_pk primary key(aeronave_id),
  constraint aeronave_matricula_uk unique(matricula),
  constraint aeronave_tipo_chk check(es_carga = 1 or es_comercial = 1)
);

--==============================
--Tabla: SUBTIPO AERONAVE COMERCIAL
--==============================

create table aeronave_comercial(
  aeronave_id                 number(10,0) not null,
  capacidad_ordinarios        number(10,0) not null,
  capacidad_discapacitados    number(10,0) not null,
  capacidad_vip               number(10,0) not null,
  constraint aeronave_comercial_pk primary key(aeronave_id),
  constraint aeronave_comercial_aeronave_id_fk foreign key(aeronave_id)
    references aeronave(aeronave_id)
);

--==============================
--Tabla: SUBTIPO AERONAVE CARGA
--==============================

create table aeronave_carga(
  aeronave_id                 number(10,0) not null,
  capacidad_carga             number(10,0) not null,
  numero_bodegas              number(10,0) not null,
  bodegas_alto                number(10,0) not null,
  bodegas_ancho               number(10,0) not null,
  bodegas_profundidad         number(10,0) not null,
  aeropuerto_resguardo_id     number(10,0) not null,
  volumen_bodegas             varchar2(100) as('Volumen: ' 
  ||bodegas_alto*bodegas_ancho*bodegas_profundidad || ' Lts.'),
  constraint aeronave_carga_pk primary key(aeronave_id),
  constraint aeronave_carga_aeronave_id_fk foreign key(aeronave_id)
    references aeronave(aeronave_id),
  constraint aeronave_carga_aeropuerto_id_fk foreign key(aeropuerto_resguardo_id)
    references aeropuerto(aeropuerto_id)
);

--==============================
--Tabla: Vuelo
--==============================

create table vuelo(
  vuelo_id                  number(10,0)        not null,
  num_vuelo                 number(5,0)         not null,
  es_comercial              number(1,0)         not null,
  es_carga                  number(1,0)         not null,
  fecha_estado              date                not null,
  sala_abordar              varchar2(10)            null,
  fecha_salida              date                default sysdate,
  fecha_aprox_llegada       date                not null,
  aeropuerto_origen_id      number(10,0)        not null,
  aeropuerto_llegada_id     number(10,0)        not null,
  aeronave_id               number(10,0)        not null,
  vuelo_estado_id           number(10,0)        not null,
  folio                     varchar2(19)          as(
    'V-'
    || to_char(num_vuelo, 'fm00000')
    || '-'
    || to_char(fecha_salida, 'dd-mm-yyyy')
  ) virtual,
  constraint vuelo_kp primary key(vuelo_id),
  constraint vuelo_num_vuelo_uk unique(num_vuelo),
  constraint vuelo_aeropuerto_llegada_id_fk foreign key(aeropuerto_llegada_id)
    references aeropuerto(aeropuerto_id),
  constraint vuelo_aeropuerto_origen_id_fk foreign key(aeropuerto_origen_id)
    references aeropuerto(aeropuerto_id),
  constraint vuelo_aeronave_id_fk foreign key(aeronave_id)
    references aeronave(aeronave_id),
  constraint vuelo_estado_id_fk foreign key(vuelo_estado_id)
    references vuelo_estado(vuelo_estado_id)
);

--==============================
--Tabla: Empleado vuelo
--==============================

create table empleado_vuelo(
  empleado_id     number(10,0) not null,
  vuelo_id        number(10,0) not null,
  puntos          number(3,0)  not null,
  rol_id          number(10,0) not null,
  constraint empleado_vuelo_pk primary key(empleado_id, vuelo_id),
  constraint empleado_vuelo_empleado_id_fk foreign key(empleado_id)
    references empleado(empleado_id),
  constraint empleado_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id),
  constraint empleado_vuelo_rol_id_fk foreign key(rol_id)
    references rol(rol_id),
  constraint empleado_vuelo_puntos_chk check(puntos >=0 and puntos <= 100)
);

--==============================
--Tabla: Ubicación del vuelo
--==============================

create table vuelo_ubicacion(
  num_medicion      number(10,0)  not null,
  vuelo_id          number(10,0)  not null,
  latitud           number(7,5)   not null,
  longitud          number(7,5)   not null,
  fecha             date          default sysdate,
  constraint datos_vuelo_pk primary key(num_medicion, vuelo_id),
  constraint datos_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id)
);

--==============================
--Tabla: Histórico
--==============================

create table historico_estados_vuelo(
  historico_estados_vuelo_id    number(10,0)  not null,
  fecha_estado                  date          not null,
  vuelo_estado_id               number(10,0)  not null,
  vuelo_id                      number(10,0)  not null,
  constraint historico_estados_vuelo_pk primary key(historico_estados_vuelo_id),
  constraint historico_estados_vuelo_vuelo_estado_id_fk foreign key(vuelo_estado_id)
    references vuelo_estado(vuelo_estado_id),
  constraint historico_estados_vuelo_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id)
);

--==============================
--Tabla: Paquete del vuelo
--==============================

create table paquete(
  paquete_id        number(10,0)    not null,
  folio             number(18,0)    not null,
  peso_kg           number(8,2)     not null,
  tipo_paquete_id   number(10,0)    not null,
  vuelo_id          number(10,0)    not null,
  constraint paquete_pk primary key(paquete_id),
  constraint paquete_folio_uk unique(folio),
  constraint paquete_tipo_paquete_id_fk foreign key(tipo_paquete_id)
    references tipo_paquete(tipo_paquete_id),
  constraint paquete_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id)
);

--==============================
--Tabla: Vuelo del pasajero
--==============================

create table vuelo_pasajero(
  vuelo_pasajero_id       number(10,0)    not null,
  num_asiento             number(5,0)     not null,
  atencion_especial       varchar2(200)   not null,
  pasajero_id             number(10,0)    not null,
  vuelo_id                number(10,0)    not null,
  constraint vuelo_pasajero_pk primary key(vuelo_pasajero_id),
  constraint vuelo_pasajero_pasajero_id_fk foreign key(pasajero_id)
    references pasajero(pasajero_id),
  constraint vuelo_pasajero_vuelo_id_fk foreign key(vuelo_id)
    references vuelo(vuelo_id)
);

--==============================
--Tabla: Pase de abordar
--==============================

create table pase_abordar(
  pase_abordar_id       number(10,0)    not null,
  folio                 varchar2(8)     not null,
  fecha_impresion       date            default sysdate,
  hora_llegada          date            not null,
  vuelo_pasajero_id     number(10,0)    not null,
  constraint pase_abordar_pk primary key(pase_abordar_id),
  constraint pase_abordar_folio_uk unique(folio),
  constraint pase_abordar_vuelo_pasajero_id_fk foreign key(vuelo_pasajero_id)
    references vuelo_pasajero(vuelo_pasajero_id)
);

--==============================
--Tabla: Maleta
--==============================

create table maleta(
  num_maleta          number(10,0)    not null,
  pase_abordar_id     number(10,0)    not null,
  peso_kg             number(7,2)     not null,
  constraint maleta_pk primary key(num_maleta, pase_abordar_id),
  constraint maleta_pase_abordar_id_fk foreign key(pase_abordar_id)
    references pase_abordar(pase_abordar_id)
);