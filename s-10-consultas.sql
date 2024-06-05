--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para consultas del proyecto

--Consulta vuelos cancelados el dia de hoy
select * from v_vuelos_cancelados
where to_char(fecha_salida,'dd/mm/yyyy')=to_char(sysdate,'dd/mm/yyyy');

--Consulta pasajeros vetados en el año 2016
select pasajero_id, ap_paterno, nombre, fecha_veto 
from pasajero_vetado
where to_char(fecha_veto,'yyyy')='2016';

--Consulta los aeropuertos que alamcenan más de 3 aviones de carga
select aeropuerto_id, nombre
from carga_aeropuertos_temp
where num_aeronaves>3;

--Consulta pasajeros que vuelan hoy con su número de maletas
select q.num_vuelo, q.nombre, q.apellido_paterno, q.num_asiento, r.pase_abordar_id, r.num_maletas
from
(select v.num_vuelo, v.fecha_salida, p.nombre, p.apellido_paterno, vp.num_asiento, vp.vuelo_pasajero_id, pa.pase_abordar_id
  from vuelo v, vuelo_pasajero vp, pasajero p, pase_abordar pa where pa.vuelo_pasajero_id=vp.vuelo_pasajero_id and v.vuelo_id=vp.vuelo_id and vp.pasajero_id=p.pasajero_id) q,
(select pa.pase_abordar_id, count(*) num_maletas from pase_abordar pa, equipaje e where pa.pase_abordar_id=e.pase_abordar_id group by pa.pase_abordar_id) r
where q.pase_abordar_id=r.pase_abordar_id
and to_char(q.fecha_salida,'dd/mm/yyyy')=to_char(sysdate,'dd/mm/yyyy');

--Consulta empleados que no son jefes
select empleado_id, nombre, apellidos, rfc
from trabajador
minus
select empleado_id, nombre, apellidos, rfc
from v_empleados_jefes;

--Consulta nombre de empleado con nombre de su jefe
select e.empleado_id, e.nombre nombre_empleado, e.apellidos apellidos_empleado, e.rfc rfc_empleado, j.empleado_id jefe_id, j.nombre nombre_jefe, j.apellidos apellidos_jefe
from empleado e left join empleado j
on e.jefe_id=j.empleado_id;

--Consulta número de pasajeros que volarán hoy
select r.vuelo_id, q.num_pasajeros
from
(select v.fecha_salida, count(*) num_pasajeros from vuelo v, vuelo_pasajero vp 
  where v.vuelo_id=vp.vuelo_id group by v.fecha_salida having to_char(fecha_salida,'dd-mm-yyyy')=to_char(sysdate,'dd-mm-yyyy')) q,
(select vuelo_id, fecha_salida from vuelo) r
where q.fecha_salida=r.fecha_salida;

--Consulta puesto y nombre de empleados sin jefe
select e.empleado_id, e.nombre, e.apellidos, p.nombre puesto, p.sueldo_mensual
from empleado e join puesto p using(puesto_id)
intersect
select e.empleado_id, e.nombre, e.apellidos, p.nombre puesto, p.sueldo_mensual 
from empleado e join puesto p using(puesto_id) 
where jefe_id is null;

--Consulta vuelos hoy
select num_vuelo, fecha_salida, fecha_aprox_llegada
from v_vuelos_comerciales_hoy
union
select num_vuelo, fecha_salida, fecha_aprox_llegada
from v_vuelos_carga_hoy;

