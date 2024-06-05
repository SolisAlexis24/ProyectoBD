--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script prueba funcion sueldo por departamento del proyecto

Prompt =======================PRUEBA FUNCIÓN 3==========================

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Sueldo total de un puesto que no existe
Prompt ========================================


declare

v_sueldo_total number(8,2);

begin
 v_sueldo_total := sueldo_total('MANTENIMIENTO');
  if v_sueldo_total is null then
    dbms_output.put_line('No se encontró el puesto');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Sueldo de los empleados
Prompt ========================================

declare
  v_puesto_id number := puesto_seq.nextval;
  v_empleado_id number := empleado_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
  v_sueldo_total number(8,2);
begin
  insert into puesto(puesto_id, nombre, descripcion, sueldo_mensual)
    values(v_puesto_id, 'SOBRECARGO', 'Sobrecargo con experiencia de 1 año', 16000);
  insert into empleado(empleado_id, nombre, apellidos, RFC, CURP, puesto_id)
    values(v_empleado_id, 'Flor', 'Amargo', '2791ANCOW03MZ', 'MJDWJA14MX92OSOA03', v_puesto_id);
  v_empleado_id := empleado_seq.nextval;
  insert into empleado(empleado_id, nombre, apellidos, RFC, CURP, puesto_id)
    values(v_empleado_id, 'Lola', 'Cortes', '1234XYZPW45XZ', 'ABCD1234EFGH5678KL', v_puesto_id);
  v_sueldo_total := sueldo_total('SOBRECARGO');
  dbms_output.put_line('SUELDO TOTAL DE LA POSICIÓN ES: '||v_sueldo_total);
  dbms_output.put_line('PRUEBA DOS EXITOSA');
exception
  when others then
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  dbms_output.put_line('Error: excepcion inesperada');
end;
/
show errors

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
