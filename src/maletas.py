import tkinter as tk
from conn import conectar, insertar_maleta, conseguir_maletas

def limpiar_ventana():
    for widget in ventana.winfo_children():
        widget.destroy()

def mostrar_vista_original():
    limpiar_ventana()
    # Crear una etiqueta con el texto "acción a realizar" y aplicar la fuente
    etiqueta = tk.Label(ventana, text="Acción a realizar", font=fuente_grande)
    etiqueta.pack(pady=10)

    # Crear el botón "registrar maleta" y alinear a la izquierda
    boton_registrar = tk.Button(ventana, text="Registrar maleta", font=fuente_grande, command=mostrar_vista_registro)
    boton_registrar.pack(side="left", padx=10, pady=5)

    # Crear el botón "consultar maletas" y alinear a la derecha
    boton_consultar = tk.Button(ventana, text="Consultar maletas", font=fuente_grande, command=mostrar_vista_consulta)
    boton_consultar.pack(side="right", padx=10, pady=5)

def mostrar_vista_registro():
    # Eliminar widgets de la vista actual
    limpiar_ventana()

    # Crear widgets para la vista de registro
    etiqueta_registro = tk.Label(ventana, text="Registro de Maleta", font=fuente_grande)
    etiqueta_registro.pack(pady=10)

    # Crear caja de texto para introducir el pase de abordar ID
    etiqueta_pase_abordar = tk.Label(ventana, text="Pase de Abordar ID:", font=fuente_grande)
    etiqueta_pase_abordar.pack()
    entrada_pase_abordar = tk.Entry(ventana, font=fuente_grande)
    entrada_pase_abordar.pack(pady=5)

    # Crear caja de texto para introducir el peso de la maleta en kg
    etiqueta_peso_maleta = tk.Label(ventana, text="Peso de la Maleta (kg):", font=fuente_grande)
    etiqueta_peso_maleta.pack()
    entrada_peso_maleta = tk.Entry(ventana, font=fuente_grande)
    entrada_peso_maleta.pack(pady=5)

    # Crear botón "Confirmar" en el centro
    boton_confirmar = tk.Button(ventana, text="Confirmar", font=fuente_grande, 
                                command= lambda : insertar_limpiar(connection, int(entrada_pase_abordar.get()), int(entrada_peso_maleta.get())))
    boton_confirmar.pack(pady=10)

    etiqueta_estado = tk.Label(ventana, text="", font=fuente_grande)
    etiqueta_estado.pack(pady=10)

    # Crear botón "Regresar" en la esquina superior izquierda
    boton_regresar = tk.Button(ventana, text="Regresar", font=fuente_grande, command=mostrar_vista_original)
    boton_regresar.pack(side="top", anchor="nw", padx=10, pady=10)

    def insertar_limpiar(connection, pase_id, peso):
        insertar_maleta(connection, pase_id, peso)
        entrada_pase_abordar.delete(0, tk.END)
        entrada_peso_maleta.delete(0, tk.END)
        etiqueta_estado.config(text = "LISTO, registro insertado")

def mostrar_vista_consulta():
    # Eliminar widgets de la vista actual
    limpiar_ventana()

    # Crear widgets para la vista de consulta
    etiqueta_consulta = tk.Label(ventana, text="Vista de consulta de maletas", font=fuente_grande)
    etiqueta_consulta.pack(pady=10)

    etiqueta_pase_abordar = tk.Label(ventana, text="Pase de Abordar ID:", font=fuente_grande)
    etiqueta_pase_abordar.pack()
    entrada_pase_abordar = tk.Entry(ventana, font=fuente_grande)
    entrada_pase_abordar.pack(pady=5)

    # Crear botón "Confirmar" en el centro
    boton_confirmar = tk.Button(ventana, text="Confirmar", font=fuente_grande,
                                command= lambda : imprimir_maletas(connection, entrada_pase_abordar.get(), etiqueta_resultado))
    boton_confirmar.pack(pady=10)

    etiqueta_orden = tk.Label(ventana, text="numero maleta |  peso kg", font=fuente_grande)
    etiqueta_orden.pack(pady=10)

    etiqueta_resultado = tk.Label(ventana, text="", font=fuente_grande)
    etiqueta_resultado.pack(pady=10)

    # Crear botón "Regresar" en la esquina superior izquierda
    boton_regresar = tk.Button(ventana, text="Regresar", font=fuente_grande, command=mostrar_vista_original)
    boton_regresar.pack(side="top", anchor="nw", padx=10, pady=10)

    def imprimir_maletas(connection, pase_id, etiqueta):
        resultado = conseguir_maletas(connection, pase_id)
        for i in resultado:
            etiqueta.config(text=etiqueta.cget("text") + str(i[0]) +"\t\t"+ str(i[2]) +  "\n")



#conectar a la base
connection = conectar()

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Gestión de Maletas")

# Crear una fuente personalizada con un tamaño grande
fuente_grande = ("Helvetica", 16)

# Cambiar el tamaño de la ventana
ventana.geometry("500x350")  # Anchura x Altura

mostrar_vista_original()

# Iniciar el bucle principal de la aplicación
ventana.mainloop()
