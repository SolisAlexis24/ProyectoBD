--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para probar procedimiento pase de abordar del proyecto

Prompt =======================Prueba 1: Vuelo no encontrado==========================

set serveroutput on

begin
  pc_pase_abordar(1059,to_date('05-06-2024','dd-mm-yyyy'),'AIFA','LAX');  
  exception
    when no_data_found then 
    dbms_output.put_line('No se encontraron vuelos próximos');
end;
/
