--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 04/05/2024
--@Descripción: Script para crear funcion que sirve para insertar maletas de un pasajero

Prompt ==============================PROCEDIMIENTO 2=============================

create or replace procedure sp_registra_maletas(
    p_pase_abordar_id in number, p_peso_kg in number) as

v_num_maletas maleta.num_maleta%type;

begin
  begin
    select count(*) into v_num_maletas
    from maleta
    where pase_abordar_id = p_pase_abordar_id
    group by pase_abordar_id;
    exception
      when no_data_found then
        v_num_maletas := 0;
  end;
  v_num_maletas := v_num_maletas + 1;

  insert into maleta(pase_abordar_id, num_maleta, peso_kg)
    values(p_pase_abordar_id, v_num_maletas, p_peso_kg);
end;
/
show errors


