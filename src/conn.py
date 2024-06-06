import cx_Oracle

try:
    conn = cx_Oracle.connect(
        user = 'sc_proy_admin',
        password = 'admin',
        dsn = 'pc-iash:1521/cursobd.fi.unam',
        encoding = 'UTF-8'
    )
    print(conn.version)
    cursor = conn.cursor()
    cursor.execute("select * from vuelo")
    rows = cursor.fetchall()
    for row in rows:
       print(row)
except Exception as ex:
  print(ex)