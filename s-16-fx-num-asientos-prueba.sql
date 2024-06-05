--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script prueba funcion número asientos del proyecto

Prompt =======================Prueba 1==========================

set serveroutput on

declare

v_num_asientos number(10,0);

begin
  select num_asientos(10025) as "numero_asientos" into v_num_asientos from dual;
  if v_num_asientos is null then
    dbms_output.put_line('No se encontró el vuelo');
  end if;
end;
/
Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
