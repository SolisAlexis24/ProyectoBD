--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 04/05/2024
--@Descripción: Script para crear funcion que sirve para registrar a la tripulacion

Prompt ==============================PROCEDIMIENTO 3==============================


create or replace procedure sp_registrar_tripulacion(
    p_nombre in varchar2, p_apellidos in varchar2 ,p_vuelo_id in number, p_rol_descripcion in varchar2
) as
  
  v_empleado_id empleado.empleado_id%type;
  v_rol_id rol.rol_id%type;

begin
  select empleado_id into v_empleado_id
  from empleado 
  where nombre = p_nombre
  and apellidos = p_apellidos;
  select rol_id into v_rol_id
  from rol
  where descripcion = p_rol_descripcion;

  insert into empleado_vuelo(empleado_id, vuelo_id, rol_id, puntos)
    values(v_empleado_id, p_vuelo_id,v_rol_id, 0);

exception
  when no_data_found then
    dbms_output.put_line('El rol o el empleado especificados no existen');
end;
/
show errors