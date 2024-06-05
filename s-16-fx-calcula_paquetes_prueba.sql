--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 05/06/2024
--@Descripción: Script para validar funcionamiento de funcion fx_calcula_precio_paquetes

Prompt =======================================
Prompt Prueba 1.
prompt Calculando el precio de los pquetes de un viaje
Prompt ========================================

declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_paquete_id number := paquete_seq.nextval;
  v_costo_vuelo number;
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
  insert into paquete(paquete_id, folio, peso_kg, tipo_paquete_id, vuelo_id)
    values(v_paquete_id, 111111111111111111, 10, tipo_paquete_seq.currval, v_vuelo_id);
  v_paquete_id := paquete_seq.nextval;
  insert into paquete(paquete_id, folio, peso_kg, tipo_paquete_id, vuelo_id)
    values(v_paquete_id, 111111111111111112, 10, tipo_paquete_seq.currval, v_vuelo_id);
  v_paquete_id := paquete_seq.nextval;
  insert into paquete(paquete_id, folio, peso_kg, tipo_paquete_id, vuelo_id)
    values(v_paquete_id, 111111111111111113, 10, tipo_paquete_seq.currval, v_vuelo_id);
  v_paquete_id := paquete_seq.nextval;
  insert into paquete(paquete_id, folio, peso_kg, tipo_paquete_id, vuelo_id)
    values(v_paquete_id, 111111111111111114, 10, tipo_paquete_seq.currval, v_vuelo_id);
  v_costo_vuelo := fx_calcula_precio_paquetes(v_vuelo_id, 100);
  dbms_output.put_line('El costo del viaje será ' || v_costo_vuelo);
  dbms_output.put_line('Prueba 1 exitosa');
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