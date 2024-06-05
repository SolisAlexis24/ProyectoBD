--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 05/06/2024
--@Descripción: Script para crear probar la funcion

Prompt ==============================PRUEBA FUNCION 2==============================

Prompt =======================================
Prompt Prueba 1.
prompt Insertando una maleta
Prompt ========================================


declare
  v_empleado_id number := empleado_seq.nextval;
  v_rol_id number := rol_seq.nextval;
  v_puesto_id number := puesto_seq.nextval;
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_nombre varchar2(5) := 'Maria';
  v_apellidos varchar2(14) := 'Gonzales Lopez';
  v_rol_desc varchar2(18) := 'Asistente de vuelo';
  v_codigo number;
  v_mensaje varchar2(1000);

  cursor cur_tripulacion is
  select empleado_id, vuelo_id, rol_id, puntos
  from empleado_vuelo
  where vuelo_id = v_vuelo_id;

begin
  insert into puesto(puesto_id, nombre, descripcion, sueldo_mensual)
    values (v_puesto_id, 'Copiloto junior', 'copiloto con 2 años de experiencia', 80000.00);

  insert into rol(rol_id, descripcion, nombre)
    values (v_rol_id, v_rol_desc, 'Asistente de piloto');

  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values (v_empleado_id, v_nombre, v_apellidos, 'SGDK28XJSLA91', 'MAGDR104MF7XSALOPS', v_puesto_id);

  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'Aeropuerto Naucalpan', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'Aeropuerto Mazatlan', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
    values(v_aeronave_id, 1, 1, 'HCRT-92464', 'Airbus A77');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 8, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);

  sp_registrar_tripulacion(v_nombre, v_apellidos, v_vuelo_id, v_rol_desc);

  dbms_output.put_line('empleado_id'||'--'||'vuelo_id'||'--'||'rol_id'||'--'||'puntos');
  for i in cur_tripulacion loop
    dbms_output.put_line('-------'||i.empleado_id || '--------' || i.vuelo_id || '-----' || i.rol_id || '-----' || i.puntos);
  end loop;

exception
  when others then
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  dbms_output.put_line('Error: excepcion inesperada');
end;
/

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;