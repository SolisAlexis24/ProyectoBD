--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear índices del proyecto

--índices non unique
create index vuelo_aeronave_id_ix on vuelo(aeronave_id);
create index aeronave_comercial_aeronave_id_ix on aeronave_comercial(aeronave_id);
create index aeronave_carga_aeronave_id_ix on aeronave_carga(aeronave_id);
create index aeronave_carga_aeropuerto_resguardo_id_ix on aeronave_carga(aerpuerto_resguardo_id);
create index empleado_jefe_id_ix on empleado(jefe_id);

--Índices unique
create unique index puesto_clave_puesto_iuk on puesto(clave);
create unique index vuelo_estado_clave_iuk on vuelo_estado(clave);
create unique index tipo_paquete_clave_iuk on tipo_paquete(clave);
create unique index rol_nombre_iuk on rol(nombre);
create unique index aeropuerto_clave_iuk on aeropuerto(clave);
create unique index pag_web_emp_direccion_iuk on pag_web_emp(direccion);

--Índices compuestos unique
create unique index maleta_pase_abordar_id_iuk on maleta(pase_abordar_id,num_maleta);
create unique index vuelo_ubicacion_num_medicion_iuk on vuelo_ubicacion(vuelo_id,num_medicion);

--Índices basados en funciones
create index vuelo_fecha_salida_ifx on vuelo(to_char(fecha_salida,'mm/yyyy'));
