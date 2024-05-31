--@Autor(es): Solis Hernández Ian Alexis
--@Fecha creación: 01/05/2024
--@Descripción: Script para crear usuarios del proyecto

--Concexión como sys
connect sys/system as sysdba


Prompt comenzando creacion de usuarios
--Limpiando a los usuarios
declare
cursor cur_usuarios is
select username from dba_users where username like 'sc_PROY%';
cursor cur_roles is
select role from dba_roles where role like 'ROL_%';
begin
for r in cur_usuarios loop
execute immediate 'drop user '||r.username||' cascade';
end loop;
for r in cur_roles loop
execute immediate 'drop role '||r.role;
end loop;
end;
/

--Creacion de usuarios
create user sc_proy_admin identified by admin quota 500m on users;
create user sc_proy_invitado identified by guest;

--Creacion de roles
create role rol_admin;
grant create session, create table, create sequence to rol_admin;
create role rol_invitado;
grant create session to rol_invitado;

grant rol_admin to sc_proy_admin;
grant rol_invitado to sc_proy_invitado;

Prompt Creacion de usuarios finalizada