--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear probar el trigger tr_valida_num_web

set serveroutput on


Prompt =======================================
Prompt Prueba 1.
prompt Insertando un numero de registros válido para el nuevo empleado
Prompt ========================================


declare
  v_empleado_id number := empleado_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values(v_empleado_id, 'JUAN', 'HERNANDEZ RODRIGUEZ', 'AAAAAAAAAAAAA', 'BBBBBBBBBBBBBBBBBB', puesto_seq.currval);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(1, 'www.facebook.com/JUANHDZ', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(2, 'www.instagram.com/JUAN', v_empleado_id);  
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(3, 'www.x.com/ROD', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(4, 'www.linkedin.com/LIC.JUAN', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(5, 'www.tiktok.com/alvuelo', v_empleado_id);
exception
    when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    return;
end;
/
show errors

Prompt Prueba 1 exitosa

Prompt =======================================
Prompt Prueba 2.
prompt Insertando un registro más para invocar al trigger
Prompt ========================================


declare
  v_empleado_id number := empleado_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values(v_empleado_id, 'ROBERTO', 'ROMAN ROMERO', 'BBBBBBBBBBBBB', 'TTTTTTTTTTTTT', puesto_seq.currval);
    
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(11, 'www.facebook.com/ROBE', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(12, 'www.instagram.com/ROBROMAN', v_empleado_id);  
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(13, 'www.x.com/ROMERO', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(14, 'www.linkedin.com/LIC.BOBROMAN', v_empleado_id);
    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(15, 'www.tiktok.com/vuelaconmigo', v_empleado_id);

    insert into pag_web_emp(pag_web_emp_id, direccion, empleado_id)
      values(16, 'www.tiktok.com/freefire', v_empleado_id);
    raise_application_error(-20010,
		' ERROR: WEB numero seis insertada.'||
		' El trigger no está funcionando correctamente');
exception
	when others then
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
    if v_codigo = -20001 then
    	dbms_output.put_line('OK, prueba 2 Exitosa.');
    else
    	dbms_output.put_line('ERROR, se obtuvo excepción no esperada');
    	raise;
    end if;
end;
/



Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;