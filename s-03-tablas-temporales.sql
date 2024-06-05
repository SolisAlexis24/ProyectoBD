--@Autor(es): Jair C., Alexis S.
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear tablas temporales

Prompt ==============================TABLAS TEMPORALES==============================

connect sc_proy_admin/admin


--Se desea crear una tabla que contenga el numero de aeronaves de carga
--agrupado por el aeropuerto donde se resguardan 

create global temporary table carga_aeropuertos_temp
  on commit preserve rows as
  select aeropuerto_id, nombre, count(*) num_aeronaves
  from aeronave_carga c
  join aeropuerto a 
  on a.aeropuerto_id = c.aeropuerto_resguardo_id
  group by aeropuerto_id, nombre;


-- Se desea crear una tabla que contenga a los empleados y a su jefe inmediato
-- esta tabla debe ser global, pues es consultada por distintas sesiones

create global temporary table empleado_jefe_temp
  on commit delete rows as
  select e.nombre as empleado_nombre , j.nombre as jefe_nombre
  from empleado e
  left join empleado j 
  on e.jefe_id = j.empleado_id;
