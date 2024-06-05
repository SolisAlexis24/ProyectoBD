--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 02/06/2024
--@Descripción: Script para crear tabla externa del proyecto

Prompt ==============================TABLAS EXTERNAS==============================

connect sys/system as sysdba
/

--Se crea una tabla externa con los pasajeros vetados de la aerolinea
prompt creando directorio proyectobd_dir
create or replace directory proyectobd_dir as '/unam-bd/ProyectoBD/ext';

grant read, write on directory proyectobd_dir to sc_proy_admin;

prompt Conectando con usuario sc_proy_admin para crear la tabla externa
connect sc_proy_admin/admin
/

prompt creando tabla externa
create table pasajero_vetado (
  pasajero_id number(10,0),
  nombre varchar2(40),
  ap_paterno varchar2(40),
  ap_materno varchar2(40),
  fecha_veto date,
  motivo_veto varchar2(100)
)
organization external (
  --En oracle existen varios tipos de drivers para parsear el archivo:
  -- oracle_loader, oracle_datapump, oracle_bigdata, etc.
  type oracle_loader
  default directory proyectobd_dir
  access parameters (
    records delimited by newline
    badfile proyectobd_dir:'pasajero_vetado_bad.log'
    logfile proyectobd_dir:'pasajero_vetado.log'
    fields terminated by ','
    lrtrim
    missing field values are null
    (
      pasajero_id, nombre, ap_paterno, ap_materno,
      fecha_veto date mask "yyyy-mm-dd", motivo_veto
    )
  )
  location ('pasajeros_vetados.csv')
)
reject limit unlimited;

prompt creando el directorio /unam-bd/ProyectoBD/ext en caso de no existir
!mkdir -p /unam-bd/ProyectoBD/ext

prompt creando un archivo csv de prueba
!touch /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "1054,Ana,Rodríguez,Sánchez,2017-07-12,Comportamiento rudo" > /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "2019,Carlos,López,Martínez,2019-11-05,Negativa a obedecer" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "3076,María,García,Pérez,2018-01-23,Incidente de seguridad" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "4012,Juan,Martínez,González,2016-09-30,Altercado en el avión" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "5035,Laura,Fernández,Díaz,2020-08-17,Uso de dispositivos prohibidos" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "6098,Alejandro,Pérez,Rodríguez,2017-03-08,Intoxicación pública" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "7023,Patricia,Sánchez,Ruiz,2018-12-19,Agresión verbal" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "8046,Javier,Díaz,Gutiérrez,2016-06-30,Desacato a instrucciones" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "9015,Andrea,Torres,Flores,2019-02-14,Falta de documentación" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv
!echo "10023,Sergio,Vargas,Castro,2020-04-11,Conducta disruptiva" >> /unam-bd/ProyectoBD/ext/pasajeros_vetados.csv

prompt cambiando permisos
!chmod 755 /unam-bd/ProyectoBD

!chmod 777 /unam-bd/ProyectoBD/ext
prompt mostrando los datos
col nombre format a20
col ap_paterno format a20
col ap_materno format a20
col motivo_veto format a20

select * from pasajero_vetado;