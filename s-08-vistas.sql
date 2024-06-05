--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear vistas del proyecto

Prompt ==============================VISTAS==============================

create or replace view v_vuelos_comerciales_hoy(num_vuelo, sala_abordar, fecha_salida, fecha_aprox_llegada, num_pasajeros) 
as select r.num_vuelo, r.sala_abordar, r.fecha_salida, r.fecha_aprox_llegada, q.num_pasajeros
from (select v.vuelo_id, count(*) num_pasajeros from vuelo v, vuelo_pasajero vp where v.vuelo_id=vp.vuelo_id group by v.vuelo_id) q,
(select vuelo_id, num_vuelo, sala_abordar, fecha_salida, fecha_aprox_llegada from vuelo where es_comercial=1 and es_carga=0 and to_char(fecha_salida,'dd-mm-yyyy')=to_char(sysdate,'dd-mm-yyyy')) r
where q.vuelo_id=r.vuelo_id;

create or replace view v_vuelos_carga_hoy(num_vuelo, fecha_salida, fecha_aprox_llegada, num_paquetes)
as select r.num_vuelo, r.fecha_salida, r.fecha_aprox_llegada, q.num_paquetes
from (select v.vuelo_id, count(*) num_paquetes from vuelo v, paquete p where v.vuelo_id=p.vuelo_id group by v.vuelo_id) q,
(select vuelo_id, num_vuelo, fecha_salida, fecha_aprox_llegada from vuelo where es_comercial=0 and es_carga=1 and to_char(fecha_salida,'dd-mm-yyyy')=to_char(sysdate,'dd-mm-yyyy')) r
where q.vuelo_id=r.vuelo_id;

create or replace view v_empleados_jefes(empleado_id, nombre, apellidos, rfc, puesto)
as select r.empleado_id, r.nombre, r.apellidos, r.rfc, r.puesto
from (select jefe_id from empleado where jefe_id is not null) q,
(select e.empleado_id, e.nombre, e.apellidos, e.rfc, p.nombre puesto from empleado e, puesto p where e.puesto_id=p.puesto_id) r
where r.empleado_id=q.jefe_id;

create or replace view v_vuelos_cancelados(num_vuelo, comercial, carga, fecha_salida)
as select v.num_vuelo, v.es_comercial, v.es_carga, v.fecha_salida
from vuelo v, vuelo_estado ve 
where v.vuelo_estado_id=ve.vuelo_estado_id and ve.clave='CANCELADO';

