--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear trigger que sirve para verificar el numero de paginas web del empleado

Prompt ==============================TRIGGER 1==============================

create or replace trigger tr_valida_num_web
  before insert on pag_web_emp
  for each row
declare
  v_empleado_id pag_web_emp.empleado_id%type;
  v_num_paginas number := 0;
begin
    --Contar cuantos registros hay asociados al id
    select count(*) into v_num_paginas
    from pag_web_emp
    where empleado_id = :new.empleado_id
    group by empleado_id;
    dbms_output.put_line('Numero de registros antes de insertar: ' || v_num_paginas);
    --Si antes de insertar ya tiene cinco registros
    if v_num_paginas = 5 then
      raise_application_error(-20001, 'El empleado con id : '
      || :new.empleado_id
      || ' ya tiene asociadas cinco páginas web.');
    end if;
  exception
    --Cuando es la primera insercion no hay registros asociados (excepcion)
    when no_data_found then
    dbms_output.put_line('Numero de registros antes de insertar: ' || v_num_paginas);
end;
/
show errors

