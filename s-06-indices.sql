--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear índices del proyecto

Prompt ==============================INDICES==============================

--índices non unique
create index vuelo_aeronave_id_ix on vuelo(aeronave_id);
create index aeronave_carga_aeropuerto_resguardo_id_ix on aeronave_carga(aeropuerto_resguardo_id);
create index empleado_jefe_id_ix on empleado(jefe_id);

--Índices unique
create unique index rol_nombre_iuk on rol(nombre);
create unique index pag_web_emp_direccion_iuk on pag_web_emp(direccion);

--Índices compuestos unique
create unique index maleta_pase_abordar_id_iuk on maleta(pase_abordar_id,num_maleta);
create unique index vuelo_ubicacion_num_medicion_iuk on vuelo_ubicacion(vuelo_id,num_medicion);
create unique index vuelo_pasajero_id_num_asiento_iuk on vuelo_pasajero(pasajero_id,num_asiento);

--Índices basados en funciones
create index vuelo_fecha_salida_ifx on vuelo(to_char(fecha_salida,'mm/yyyy'));
