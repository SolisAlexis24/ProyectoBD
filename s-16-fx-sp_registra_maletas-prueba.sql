--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 04/05/2024
--@Descripción: Script para probar la funcion registra_maletas


Prompt ==============================PRUEBA FUNCION 1==============================

Prompt =======================================
Prompt Prueba 1.
prompt Insertando una maleta
Prompt ========================================


declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_pasajero_id number := pasajero_seq.nextval;
  v_vuelo_pasajero_id number := vuelo_pasajero_seq.nextval;
  v_pase_abordar_id number := pase_abordar_seq.nextval;
  v_codigo number;
  v_mensaje varchar2(1000);
  cursor cur_maleta is
  select pase_abordar_id, num_maleta, peso_kg
  from maleta
  where pase_abordar_id = v_pase_abordar_id;
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto1_id, 'Aeropuerto Naucalpan', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
      values(v_aeropuerto2_id, 'Aeropuerto Mazatlan', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 1, 'DPAE-10345', 'Airbus A77');
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
      values(v_vuelo_id, 18, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  insert into pasajero (pasajero_id, curp, nombre, apellido_paterno, apellido_materno, email, fecha_nacimiento) 
    values (v_pasajero_id, 'DJAPE401KDPSPXOQ1P', 'Rodigro', 'Catalán', 'Romero', 'rod@live.com', to_date('10-06-1976','dd-mm-yyyy'));
  insert into vuelo_pasajero(vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
    values(v_vuelo_pasajero_id, 13, 'Hipertensión', v_pasajero_id, v_vuelo_id);
  insert into pase_abordar (pase_abordar_id, folio, hora_llegada, vuelo_pasajero_id) 
    values (v_pase_abordar_id, 'F01MN684', to_date('2024-08-03 05:30', 'yyyy-mm-dd HH:MI'), v_vuelo_pasajero_id);

  sp_registra_maletas(v_pase_abordar_id, 10);
  sp_registra_maletas(v_pase_abordar_id, 1);
  sp_registra_maletas(v_pase_abordar_id, 5);
  sp_registra_maletas(v_pase_abordar_id, 1);
    dbms_output.put_line('pase_abordar_id--num_maleta--peso_kg');
  for i in cur_maleta loop
    dbms_output.put_line('--------'||i.pase_abordar_id ||'------------' ||i.num_maleta ||'---------'||i.peso_kg);
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