--@Autor(es): 
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear secuencias

connect sc_proy_admin/admin

--Secuencia para empleados

create sequence empleado_seq
start with 0
increment by 1
minvalue 0
nocycle;

--Secuencia para rol

create sequence rol_seq
start with 1000
increment by 1
nocycle;

--Secuencia para puesto

create sequence puesto_seq
start with 1001
increment by 5
nocycle;

--Secuencia para pasajero

create sequence pasajero_seq
start with 0
increment by 2
minvalue 0
nocycle
cache 10;

--Secuencia para vuelo_pasajero

create sequence vuelo_pasajero_seq
start with 100
increment by 5
nocycle
cache 100;

--Secuencia para el pase de abordar 

create sequence pase_abordar_seq
start with 0
increment by 2
minvalue 0
nocycle
cache 100;

--Secuencia para el tipo de paquete

create sequence tipo_paquete_seq
start with 1000
increment by 3
nocycle;

--Secuencia para paquete
create sequence paquete_seq
start with 0
increment by 3
minvalue 0
nocycle
cache 100;

----Secuencia para vuelo

create sequence vuelo_seq
start with 0
increment by 10
minvalue 0
nocycle
cache 10;

--Secuencia para las aeronaves
create sequence aeronave_seq
start with 0
increment by 5
minvalue 0
nocycle;

--Secuencia para los aeropuertos
create sequence aeropuerto_seq
start with 0
increment by 1
minvalue 0
nocycle;



