--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para cargar los datos iniciales

Prompt ==============================CARGA INICIAL==============================

connect sc_proy_admin/admin
set serveroutput on


--Estados del vuelo
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(1, 'PROGRAMADO', 'El vuelo está esperando autorización', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(2, 'ABORDANDO', 'El vuelo esta listo para despegar', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(3, 'EN CURSO', 'El vuelo se encuentra en curso', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(4, 'COMPLETADO', 'El vuelo ha terminado su viaje', 1);  
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(5, 'RETRASADO', 'El vuelo aun no puede despegar', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(6, 'CANCELADO', 'El vuelo ha sido cancelado', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(7, 'DESVIADO', 'El vuelo ha sido desviado a otro aeropuerto', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(8, 'APLAZADO', 'El vuelo ha sido aplazado', 1); 


declare
  v_empleado_id number := empleado_seq.nextval;
  v_rol_id number := rol_seq.nextval;
  v_puesto_id number := puesto_seq.nextval;
  v_pasajero_id number := pasajero_seq.nextval;
  v_vuelo_pasajero_id number := vuelo_pasajero_seq.nextval;
  v_pase_abordar_id number := pase_abordar_seq.nextval;
  v_tipo_paquete_id number := tipo_paquete_seq.nextval;
  v_paquete_id number := paquete_seq.nextval;
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
begin
  insert into puesto(puesto_id, nombre, descripcion, sueldo_mensual) 
    values(v_puesto_id, 'Piloto senior', 'Piloto con 10 años de experiencia', 150000.00);
  insert into rol(rol_id, descripcion, nombre)
    values(v_rol_id, 'Piloto principal', 'Encargado de la aeronave');
  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values(v_empleado_id, 'JUAN', 'PEREZ HARRIS', 'JPH09005JOFT5', 'JPH2666291DHBDLAKO', v_puesto_id);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'Aeropuero internacional CDMX', -45.32043, 18.29088, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'Aeropuerto nacional Acapulco', -64.03294, -50.34019,1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
    values(v_aeronave_id, 1, 1, 'QWER-87381', 'Airbus A380');
  insert into aeronave_comercial(aeronave_id, capacidad_ordinarios, capacidad_discapacitados, capacidad_vip)
    values(v_aeronave_id, 1000, 500, 100);
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
    values(v_aeronave_id, 10000, 30, 5, 20, 10, v_aeropuerto1_id);
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
    values(v_vuelo_id, 142, 1, 1, sysdate, 'Ala oeste', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  insert into empleado_vuelo(empleado_id, vuelo_id, puntos, rol_id)
    values(v_empleado_id, v_vuelo_id, 100, v_rol_id);
  insert into pasajero (pasajero_id, curp, nombre, apellido_paterno, apellido_materno, email, fecha_nacimiento) 
    values (v_pasajero_id, 'RCRMSQJ67191FHDSCF', 'Rodigro', 'Catalán', 'Romero', 'rod@live.com', to_date('10-06-1976','dd-mm-yyyy'));
  insert into vuelo_pasajero(vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
    values(v_vuelo_pasajero_id, 130, 'Hipertensión', v_pasajero_id, v_vuelo_id);
  insert into pase_abordar (pase_abordar_id, folio, hora_llegada, vuelo_pasajero_id) 
    values (v_pase_abordar_id, 'F01MN683', to_date('2024-08-03 05:30', 'yyyy-mm-dd HH:MI'), v_vuelo_pasajero_id);
  insert into maleta(num_maleta, pase_abordar_id, peso_kg)
    values(1, v_pase_abordar_id, 4);
  insert into tipo_paquete(tipo_paquete_id, descripcion, instrucciones)
    values(v_tipo_paquete_id, 'Toallas de baño', 'No dejar en lugar húmedo');
end;
/
show errors

declare
  v_empleado_id number := empleado_seq.nextval;
  v_rol_id number := rol_seq.nextval;
  v_puesto_id number := puesto_seq.nextval;
  v_pasajero_id number := pasajero_seq.nextval;
  v_vuelo_pasajero_id number := vuelo_pasajero_seq.nextval;
  v_pase_abordar_id number := pase_abordar_seq.nextval;
  v_tipo_paquete_id number := tipo_paquete_seq.nextval;
  v_paquete_id number := paquete_seq.nextval;
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
begin
  insert into puesto(puesto_id, nombre, descripcion, sueldo_mensual) 
    values(v_puesto_id, 'Copiloto junior', 'Copiloto con 3 años de experiencia', 80000.00);
  insert into rol(rol_id, descripcion, nombre)
    values(v_rol_id, 'Asistente de vuelo', 'Encargado de la seguridad');
  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values(v_empleado_id, 'ANA', 'GARCIA LOPEZ', 'AGL750912HKLN', 'AGL750912MDFRPN04', v_puesto_id);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'Aeropuerto Internacional de Guadalajara', 20.5218, -10.33106, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'Aeropuerto Internacional de Monterrey', 25.7785, -10.01075, 1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
    values(v_aeronave_id, 0, 1, 'ZGHV-12345', 'Boeing 737');
  insert into aeronave_comercial(aeronave_id, capacidad_ordinarios, capacidad_discapacitados, capacidad_vip)
    values(v_aeronave_id, 150, 10, 20);
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
    values(v_aeronave_id, 5000, 10, 4, 15, 8, v_aeropuerto1_id);
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
    values(v_vuelo_id, 275, 1, 0, sysdate, 'Sala norte', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 6);
  insert into empleado_vuelo(empleado_id, vuelo_id, puntos, rol_id)
    values(v_empleado_id, v_vuelo_id, 10, v_rol_id);
  insert into pasajero(pasajero_id, curp, nombre, apellido_paterno, apellido_materno, email, fecha_nacimiento) 
    values(v_pasajero_id, 'ABCDFG789456MNQRS1', 'Luis', 'Martinez', 'Hernandez', 'luis.mh@example.com', to_date('15-04-1985', 'dd-mm-yyyy'));
  insert into vuelo_pasajero(vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
    values(v_vuelo_pasajero_id, 25, 'Silla de ruedas', v_pasajero_id, v_vuelo_id);
  insert into pase_abordar(pase_abordar_id, folio, hora_llegada, vuelo_pasajero_id) 
    values(v_pase_abordar_id, 'B02XY789', to_date('2024-09-15 06:45', 'yyyy-mm-dd HH24:MI'), v_vuelo_pasajero_id);
  insert into maleta(num_maleta, pase_abordar_id, peso_kg)
    values(1, v_pase_abordar_id, 5);
  insert into tipo_paquete(tipo_paquete_id, descripcion, instrucciones)
    values(v_tipo_paquete_id, 'Juguetes', 'Manejar con cuidado, frágil');
end;
/
show errors;

declare
  v_empleado_id number := empleado_seq.nextval;
  v_rol_id number := rol_seq.nextval;
  v_puesto_id number := puesto_seq.nextval;
  v_pasajero_id number := pasajero_seq.nextval;
  v_vuelo_pasajero_id number := vuelo_pasajero_seq.nextval;
  v_pase_abordar_id number := pase_abordar_seq.nextval;
  v_tipo_paquete_id number := tipo_paquete_seq.nextval;
  v_paquete_id number := paquete_seq.nextval;
  v_vuelo_id number := vuelo_seq.nextval;
  v_aeronave_id number := aeronave_seq.nextval;
  v_aeropuerto1_id number := aeropuerto_seq.nextval;
  v_aeropuerto2_id number := aeropuerto_seq.nextval;
begin
  insert into puesto(puesto_id, nombre, descripcion, sueldo_mensual) 
    values(v_puesto_id, 'Ingeniero de vuelo', 'Responsable de monitorear los sistemas', 120000.00);
  insert into rol(rol_id, descripcion, nombre)
    values(v_rol_id, 'Mecánico de aeronaves', 'Encargado del mantenimiento técnico');
  insert into empleado(empleado_id, nombre, apellidos, rfc, curp, puesto_id)
    values(v_empleado_id, 'MARIA', 'LOPEZ MARTINEZ', 'MLM800725HTZR', 'MLM800725MDFRPD096', v_puesto_id);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto1_id, 'Aeropuerto Internacional de Cancún', 21.0365, -86.8771, 1);
  insert into aeropuerto(aeropuerto_id, nombre, latitud, longitud, activo)
    values(v_aeropuerto2_id, 'Aeropuerto Internacional de Tijuana', 32.5411, -11.69706, 1);
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
    values(v_aeronave_id, 1, 0, 'HJUI-56789', 'Boeing 747');
  insert into aeronave_comercial(aeronave_id, capacidad_ordinarios, capacidad_discapacitados, capacidad_vip)
    values(v_aeronave_id, 300, 15, 25);
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
    values(v_aeronave_id, 20000, 40, 6, 25, 12, v_aeropuerto1_id);
  insert into vuelo(vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
    values(v_vuelo_id, 378, 0, 1, sysdate, 'Terminal 3', sysdate, sysdate+1, v_aeropuerto1_id, v_aeropuerto2_id, v_aeronave_id, 1);
  insert into empleado_vuelo(empleado_id, vuelo_id, puntos, rol_id)
    values(v_empleado_id, v_vuelo_id, 40, v_rol_id);
  insert into pasajero(pasajero_id, curp, nombre, apellido_paterno, apellido_materno, email, fecha_nacimiento) 
    values(v_pasajero_id, 'FGHIJK123456MNOPQ2', 'Carlos', 'Gonzalez', 'Diaz', 'carlos.gd@example.com', to_date('22-12-1990', 'dd-mm-yyyy'));
  insert into vuelo_pasajero(vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
    values(v_vuelo_pasajero_id, 45, 'Dieta especial', v_pasajero_id, v_vuelo_id);
  insert into pase_abordar(pase_abordar_id, folio, hora_llegada, vuelo_pasajero_id) 
    values(v_pase_abordar_id, 'C03YZ123', to_date('2024-10-20 07:15', 'yyyy-mm-dd HH24:MI'), v_vuelo_pasajero_id);
  insert into maleta(num_maleta, pase_abordar_id, peso_kg)
    values(1, v_pase_abordar_id, 7);
  insert into tipo_paquete(tipo_paquete_id, descripcion, instrucciones)
    values(v_tipo_paquete_id, 'Electrodomésticos', 'Manejar con cuidado, evitar golpes');

  v_aeronave_id := aeronave_seq.nextval;
    -- Primer par
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 0, 'ZXCV-12345', 'Airbus A330');
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
      values(v_aeronave_id, 15000, 25, 5, 22, 11, v_aeropuerto1_id);
  v_aeronave_id := aeronave_seq.nextval;
  -- Segundo par
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 0, 'SDCV-67440', 'Lockheed C-130');
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
      values(v_aeronave_id, 18000, 30, 6, 20, 10, v_aeropuerto1_id);
  v_aeronave_id := aeronave_seq.nextval;
  -- Tercer par
  insert into aeronave(aeronave_id, es_carga, es_comercial, matricula, modelo)
      values(v_aeronave_id, 1, 0, 'TYUI-11223', 'Antonov An-225');
  insert into aeronave_carga(aeronave_id, capacidad_carga, numero_bodegas, bodegas_alto, bodegas_ancho, bodegas_profundidad, aeropuerto_resguardo_id)
      values(v_aeronave_id, 25000, 50, 7, 30, 15, v_aeropuerto1_id);

end;
/
show errors;




commit;
    
