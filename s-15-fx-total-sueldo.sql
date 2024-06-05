--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para funcion sueldo por departamento del proyecto

Prompt ==============================FUNCIÓN 3==============================

create or replace function sueldo_total(
  v_nombre_puesto varchar2
) return number is

  v_puesto_id puesto.puesto_id%type;
  v_sueldo_puesto puesto.sueldo_mensual%type;
  v_num_emp number(10,0);
  v_total_sueldo number(8,2);

  begin
    select puesto_id, sueldo_mensual into v_puesto_id, v_sueldo_puesto from puesto where nombre=v_nombre_puesto;
    select count(*) into v_num_emp from empleado where puesto_id=v_puesto_id;
    
    v_total_sueldo:=v_num_emp*v_sueldo_puesto;
    return v_total_sueldo;
  exception
  when no_data_found then
    return null;
  end;
/
show errors
