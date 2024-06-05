--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script prueba funcion número asientos del proyecto

Prompt =======================PRUEBA FUNCIÓN 2==========================

set serveroutput on

Prompt =======================================
Prompt Prueba 1.
prompt Asientos de un viaje que no existe
Prompt ========================================

declare

v_num_asientos number(10,0);

begin
  select num_asientos(10025) as "numero_asientos" into v_num_asientos from dual;
  if v_num_asientos is null then
    dbms_output.put_line('No se encontró el vuelo');
  end if;
end;
/

Prompt =======================================
Prompt Prueba 2.
prompt Asientos de un viaje que si existe
Prompt ========================================

declare
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
  v_total_asientos number;
  v_codigo number;
  v_mensaje varchar2(1000);
begin
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'Aeropuero Ecatepec', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'Aeropuerto Guatemala', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
    values(v_aeronave_id, 0, 1, 'JDSQ-72033', 'Airbus A380');
  insert into aeronave_comercial(aeronave_id, capacidad_ordinarios, capacidad_discapacitados, capacidad_vip)
    values(v_aeronave_id, 1000, 500, 100);
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
    values(v_vuelo_id, 1, 1, 0, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  v_total_asientos := num_asientos(v_vuelo_id);
  dbms_output.put_line('NUMERO TOTAL DE ASIENTOS: ' || v_total_asientos);
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
