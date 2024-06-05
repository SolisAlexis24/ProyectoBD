--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear probar el trigger tr_valida_estado_vuelo

Prompt ==============================PRUEBAS TRIGGER 2==============================

Prompt =======================================
Prompt Prueba 1.
prompt Insertando un vuelo con un estado válido
Prompt ========================================


declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto1_id, 'Aeropuerto Naucalpan', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto2_id, 'Aeropuerto Mazatlan', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 1, 'HCRT-92464', 'Airbus A77');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 8, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
exception
  when others then
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  dbms_output.put_line('Error: excepcion inesperada');
end;
/

Prompt Prueba 1, OK

Prompt =======================================
Prompt Prueba 2.
prompt Insertando un vuelo con un estado inválido
Prompt ========================================


declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto1_id, 'Aeropuerto C.U.', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto2_id, 'Aeropuerto Oaxaca', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 1, 'GSCP-48034', 'Airbus A34');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 9, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 4);
exception
  when others then
  
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  if v_codigo = -20004 then
    dbms_output.put_line('OK, prueba 2 Exitosa.');
  else
    dbms_output.put_line('Error: excepcion inesperada');
  raise;
  end if;
end;
/

Prompt =======================================
Prompt Prueba 3.
prompt Actualizando estado del registro sin que las ubicaciones sean las mismas
Prompt ========================================

declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto1_id, 'Aeropuerto Juarez', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto2_id, 'Aeropuerto Rumbo Alegre', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 1, 'CRTP-29724', 'Airbus B69');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 11, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  insert into vuelo_ubicacion(num_medicion, vuelo_id, latitud, longitud, fecha)
      values(1, v_vuelo_id, -33.37404, 19.39567, sysdate);
  update vuelo 
  set vuelo_estado_id = 4
  where vuelo_id = v_vuelo_id; 
exception
  when others then
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  if v_codigo = -20005 then
    dbms_output.put_line('OK, prueba 3 Exitosa.');
  else
    dbms_output.put_line('Error: excepcion inesperada');
  raise;
  end if;
end;
/

Prompt =======================================
Prompt Prueba 4.
prompt Actualizando estado del registro con las ubicaciones iguales 
Prompt ========================================

declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto1_id, 'Aeropuerto Rodriguez', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto2_id, 'Aeropuerto Ciudad Peluche', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 1, 'KCNE-72031', 'Airbus Ludo');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 104, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  insert into vuelo_ubicacion(num_medicion, vuelo_id, latitud, longitud, fecha)
      values(1, v_vuelo_id, -33.37404, 19.39567, sysdate);
  insert into vuelo_ubicacion(num_medicion, vuelo_id, latitud, longitud, fecha)
      values(2, v_vuelo_id, -64.03294, -50.34019, sysdate);
  update vuelo 
  set vuelo_estado_id = 4
  where vuelo_id = v_vuelo_id; 
exception
  when others then
  v_codigo := sqlcode;
  v_mensaje := sqlerrm;
  dbms_output.put_line('Codigo:  ' || v_codigo);
  dbms_output.put_line('Mensaje: ' || v_mensaje);
  dbms_output.put_line('Error: excepcion inesperada');
  raise;
end;
/

Prompt Prueba 4 exitosa

Prompt Prueba concluida, Haciendo Rollback para limpiar la BD.
rollback;
