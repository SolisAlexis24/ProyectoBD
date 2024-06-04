create or replace trigger tr_valida_num_web
  before insert on pag_web_emp
  for each row
declare
  v_empleado_id pag_web_emp.empleado_id%type;
  v_num_paginas number;
begin
    select empleado_id, count(*) into v_empleado_id, v_num_paginas
    from pag_web_emp
    where empleado_id = :new.empleado_id
    group by empleado_id;
    if v_num_paginas = 5 then
      raise_application_error(-20001, 'El empleado con id :'
      || :new.empleado_id
      || ' ya tiene asociadas cinco páginas web.');
    end if;
end;
/
show errors
