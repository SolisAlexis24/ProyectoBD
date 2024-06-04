--@Autor(es): Alexis S., Jair C.
--@Fecha creación: 01/05/2024
--@Descripción: Script para cargar los datos iniciales

--Estados del vuelo
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(1, 'LISTO', 'El vuelo esta listo para despegar', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(2, 'EN CURSO', 'El vuelo se encuentra en curso', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(3, 'COMPLETADO', 'El vuelo ha terminado su viaje', 1);  
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(4, 'RETRASADO', 'El vuelo aun no puede despegar', 1);
insert into vuelo_estado(vuelo_estado_id, clave, descripcion, activo)
  values(5, 'CANCELADO', 'El vuelo ha sido cancelado', 1);


DECLARE
    v_aeronave_id           NUMBER;
    v_vuelo_id              NUMBER;
    v_vuelo_pasajero_id     NUMBER;
    v_pase_abordar_id       NUMBER;
    v_paquete_id            NUMBER;
BEGIN
    -- Obtener valores de secuencias
    SELECT aeronave_seq.NEXTVAL INTO v_aeronave_id FROM DUAL;
    SELECT vuelo_seq.NEXTVAL INTO v_vuelo_id FROM DUAL;
    SELECT vuelo_pasajero_seq.NEXTVAL INTO v_vuelo_pasajero_id FROM DUAL;
    SELECT pase_abordar_seq.NEXTVAL INTO v_pase_abordar_id FROM DUAL;
    SELECT paquete_seq.NEXTVAL INTO v_paquete_id FROM DUAL;

    -- Insertar valores en la tabla Aeronave
    INSERT INTO aeronave (aeronave_id, es_carga, es_comercial, matricula, modelo, especificaciones_pdf)
    VALUES (v_aeronave_id, 0, 1, 'Matricula1', 'Modelo1', NULL);

    -- Insertar valores en la tabla Vuelo
    INSERT INTO vuelo (vuelo_id, num_vuelo, es_comercial, es_carga, fecha_estado, sala_abordar, fecha_salida, fecha_aprox_llegada, aeropuerto_origen_id, aeropuerto_llegada_id, aeronave_id, vuelo_estado_id)
    VALUES (v_vuelo_id, 1, 1, 0, SYSDATE, NULL, SYSDATE, SYSDATE + 1, 1, 2, v_aeronave_id, 1);

    -- Insertar valores en la tabla Vuelo del pasajero
    INSERT INTO vuelo_pasajero (vuelo_pasajero_id, num_asiento, atencion_especial, pasajero_id, vuelo_id)
    VALUES (v_vuelo_pasajero_id, 10, 'Sin atención especial', 1, v_vuelo_id);

    -- Insertar valores en la tabla Pase de abordar
    INSERT INTO pase_abordar (pase_abordar_id, folio, hora_llegada, vuelo_pasajero_id)
    VALUES (v_pase_abordar_id, 'Folio1', SYSDATE, v_vuelo_pasajero_id);

    -- Insertar valores en la tabla Paquete del vuelo
    INSERT INTO paquete (paquete_id, folio, peso_kg, tipo_paquete_id, vuelo_id)
    VALUES (v_paquete_id, 1, 20, 1, v_vuelo_id);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

    
