--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear sinonimos


connect sc_proy_admin/admin

--Sinonimos publicos

create or replace public synonym avion for aeronave;
create or replace public synonym equipaje for maleta;
create or replace public synonym trabajador for empleado;
create or replace public synonym web for pag_web_emp;

--Permisos de seleccion

grant select on aeropuerto to sc_proy_invitado;
grant select on tipo_paquete to sc_proy_invitado;
grant select on puesto to sc_proy_invitado;
grant select on aeronave_carga to sc_proy_invitado;

disconnect

connect sc_proy_invitado/guest


--Sinonimos privados

create or replace synonym terminal for sc_proy_admin.aeropuerto;
create or replace synonym paqueteria for sc_proy_admin.tipo_paquete;
create or replace synonym ocupacion for sc_proy_admin.puesto;
create or replace synonym carguero for sc_proy_admin.aeronave_carga;

disconnect

connect sc_proy_admin/admin

--sinonimos para aplicacion

declare
  v_prefijo varchar2(3) := 'sc_';
  cursor cur_tablas is 
  select table_name from user_tables;
begin
  for i in cur_tablas loop
    execute immediate 'create or replace public synonym '|| v_prefijo || i.table_name || ' for ' || i.table_name;
  end loop;
end;
/


