--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para procedimiento pase de abordar del proyecto

Prompt ==============================PROCEDIMIENTO 1==============================

create or replace procedure pc_pase_abordar(
  p_pasajero_id in number,
  p_fecha_salida in date,
  p_nombre_aeropuerto_origen in varchar2,
  p_nombre_aeropuerto_destino in varchar2,
  p_atencion_especial in varchar2 default null) is

  v_vuelo_pasajero_id vuelo_pasajero.vuelo_pasajero_id%type;
  v_pase_abordar_id pase_abordar.pase_abordar_id%type;
  v_num_asiento vuelo_pasajero.num_asiento%type;
  v_folio pase_abordar.folio%type;
  v_fecha_impresion pase_abordar.fecha_impresion%type;
  v_num_vuelo vuelo.num_vuelo%type;
  v_fecha_llegada vuelo.fecha_aprox_llegada%type;
  v_num_sala vuelo.sala_abordar%type;
  v_aeropuerto_origen_id vuelo.aeropuerto_origen_id%type;
  v_aeropuerto_destino_id vuelo.aeropuerto_llegada_id%type;
  v_vuelo_id vuelo.vuelo_id%type;
  v_aeronave_id vuelo.aeronave_id%type;
  v_aeronave_capacidad number(10,0);
  v_aeronave_capacidad_ord number(10,0);
  v_aeronave_capacidad_vip number(10,0);
  v_aeronave_capacidad_disc number(10,0);

begin
  v_fecha_impresion:=sysdate;
  v_folio:= dbms_random.string('A',8);

  select pase_abordar_seq.nextval into v_pase_abordar_id from dual;
  select vuelo_pasajero_seq.nextval into v_vuelo_pasajero_id from dual;
  
  select aeropuerto_id into v_aeropuerto_origen_id
  from aeropuerto where nombre=p_nombre_aeropuerto_origen;

  select aeropuerto_id into v_aeropuerto_destino_id
  from aeropuerto where nombre=p_nombre_aeropuerto_destino;

  select vuelo_id, num_vuelo, sala_abordar, fecha_aprox_llegada, aeronave_id into v_vuelo_id, v_num_vuelo, v_num_sala, v_fecha_llegada, v_aeronave_id
  from vuelo where fecha_salida=p_fecha_salida and aeropuerto_origen_id=v_aeropuerto_origen_id and aeropuerto_llegada_id=v_aeropuerto_destino_id;

  select capacidad_discapacitados into v_aeronave_capacidad_disc
  from aeronave_comercial where aeronave_id=v_aeronave_id;

  select capacidad_ordinarios, capacidad_vip into v_aeronave_capacidad_ord, v_aeronave_capacidad_vip
  from aeronave_comercial where aeronave_id=v_aeronave_id;

  if v_vuelo_id is not null then
    if p_atencion_especial is null then
      select count(*) into v_aeronave_capacidad from vuelo_pasajero where vuelo_id=v_vuelo_id and atencion_especial is null;
      if v_aeronave_capacidad < v_aeronave_capacidad_ord+v_aeronave_capacidad_vip then
        v_num_asiento:=v_aeronave_capacidad_disc+ v_aeronave_capacidad+1;
      end if;
    else
      select count(*) into v_aeronave_capacidad from vuelo_pasajero where vuelo_id=v_vuelo_id and atencion_especial is not null;     
      if v_aeronave_capacidad < v_aeronave_capacidad_disc then
        v_num_asiento:=v_aeronave_capacidad+1;
      end if;
    end if;
    insert into vuelo_pasajero (vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
      values(v_vuelo_pasajero_id, v_num_asiento, p_atencion_especial, p_pasajero_id, v_vuelo_id);

    insert into pase_abordar (pase_abordar_id, folio, fecha_impresion, hora_llegada, vuelo_pasajero_id)
      values(v_pase_abordar_id, v_folio, v_fecha_impresion, v_fecha_llegada, v_vuelo_pasajero_id);
    
    dbms_output.put_line('Se ha registrado su pase de abordar con éxito');
  end if;
  exception
    when no_data_found then 
    dbms_output.put_line('No se encontraron vuelos próximos');
end;
/
show errors
