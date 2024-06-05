--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 05/06/2024
--@Descripción: Script para crear funcion que calcule el precio que costará
--transportar los paquetes dependiendo del precio del combustible y el peso total de los paquetes.

Prompt ==============================FUNCION 1==============================

create or replace function fx_calcula_precio_paquetes(
    p_vuelo_id vuelo.vuelo_id%type,
    p_precio_combustible number
) return number is
  
  v_num_paquetes number(10,0);
  v_peso_paquetes  number(10,0);
  v_costo_total number(10,0);

  begin
    begin
      select count(*) into v_num_paquetes
      from paquete
      where vuelo_id = p_vuelo_id
      group by vuelo_id;
    exception
      when no_data_found then
        v_num_paquetes := 0;
    end;

    if v_num_paquetes != 0 then
      select sum(peso_kg) into v_peso_paquetes
      from paquete
      where vuelo_id = p_vuelo_id
      group by vuelo_id;
      
      v_costo_total := p_precio_combustible * v_peso_paquetes;

      return v_costo_total;
    else
      return 0;    
    end if;
  end;
/
show errors