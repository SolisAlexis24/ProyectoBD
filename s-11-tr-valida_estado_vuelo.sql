--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 04/05/2024
--@Descripción: Script para crear trigger que sirve para verificar que el estado de vuelo no sea completado a 
--menos que su ubicacion sea la del aeropuerto de destino

create or replace trigger tr_valida_estado_vuelo
  before insert or update of vuelo_estado_id on vuelo
  for each row
declare
  v_estado_id vuelo.vuelo_estado_id%type;
  v_num_mediciones number;
  v_vuelo_latitud vuelo_ubicacion.latitud%type;
  v_vuelo_longitud vuelo_ubicacion.longitud%type;
  v_aerop_latitud aeropuerto.latitud%type;
  v_aerop_longitud aeropuerto.longitud%type;
begin
  case
    when inserting then
      if :new.vuelo_estado_id = 4 then
        raise_application_error(-20004, 'El vuelo con id: '
        || :new.vuelo_id
        || ' no puede ser insertado directamente como COMPLETADO');
      end if;
    when updating then
      if :new.vuelo_estado_id = 4 then
      --Se cuentan cuantas mediciones hay para saber cual es el tope
        select count(*) into v_num_mediciones
        from vuelo_ubicacion
        where vuelo_id = :new.vuelo_id
        group by vuelo_id;
      --Se seleccionan los datos de la ultima medicion 
        select latitud, longitud into v_vuelo_latitud, v_vuelo_longitud
        from vuelo_ubicacion
        where num_medicion = v_num_mediciones;
      --Se seleccionan los datos del aeropuerto de llegada del vuelo
        select latitud, longitud into v_aerop_latitud, v_aerop_longitud
        from aeropuerto
        where aeropuerto_id = :new.aeropuerto_llegada_id;
        if v_vuelo_latitud = v_aerop_latitud and v_vuelo_longitud = v_aerop_longitud then
          dbms_output.put_line('Vuelo actualizado correctamente');
        else
          raise_application_error(-20005, 'El vuelo con id: '
          || :new.vuelo_id
          || ' no puede ser registrado como COMPLETADO si aún no está en el aeropuerto de destino.');
        end if;
      end if;
    end case;
end;
/
show errors

