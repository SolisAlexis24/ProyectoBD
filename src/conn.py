import cx_Oracle

def conectar():
    try:
        conn = cx_Oracle.connect(
            user = 'sc_proy_admin',
            password = 'admin',
            dsn = 'pc-iash:1521/cursobd.fi.unam',
            encoding = 'UTF-8'
        )
        return conn
    except Exception as ex:
        print(ex)
    

def insertar_maleta(connection, pase_id, peso):
    cur = connection.cursor()
    cur.callproc('sp_registra_maletas', [pase_id, peso])

def conseguir_maletas(connection, pase_id):
    cur = connection.cursor()
    instruction = "select * from maleta where pase_abordar_id = " + pase_id
    cur.execute(instruction)
    return cur.fetchall()

conectar()