--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script prueba funcion sueldo por departamento del proyecto

Prompt =======================PRUEBA 1 FUNCIÓN 2==========================

set serveroutput on

declare

v_sueldo_total number(8,2);

begin
  select sueldo_total('MANTENIMIENTO') as "sueldo_total" into v_sueldo_total from dual;
  if v_sueldo_total is null then
    dbms_output.put_line('No se encontró el puesto');
  end if;
end;
/
Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
