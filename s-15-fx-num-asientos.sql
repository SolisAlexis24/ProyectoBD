--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para funcion sueldo por departamento del proyecto

create or replace function num_asientos(
  v_vuelo_id number
) return number is

  v_aeronave_id aeronave.aeronave_id%type;
  v_asinetos_ordinarios aeronave_comercial.capacidad_ordinarios%type;
  v_asientos_disc aeronave_comercial.capacidad_discapacitados%type;
  v_asientos_vip aeronave_comercial.capacidad_vip%type;
  v_num_asientos number(10,0);

  begin
    select v.aeronave_id, ac.capacidad_ordinarios, ac.capacidad_vip, ac.capacidad_discapacitados into v_aeronave_id, v_asinetos_ordinarios, v_asientos_vip, v_asientos_disc 
    from vuelo v, aeronave a, aeronave_comercial ac 
    where v.aeronave_id=a.aeronave_id and a.aeronave_id=ac.aeronave_id and a.es_comercial=1 and vuelo_id=v_vuelo_id;
    
    v_num_asientos:=v_asientos_disc+v_asinetos_ordinarios+v_asientos_vip;
    return v_num_asientos;
  end;
/
show errors