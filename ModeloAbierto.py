import psycopg2 # pip install psycopg2-binary
from psycopg2 import Error
from db.conectar import conectar
from calculo.calcular_promedio import calcular_promedios
from recomendaciones.generales import generar_recomendaciones_generales

conn = conectar()

# Función para calcular promedios iniciales de calificaciones de las películas desde la base de datos
calcular_promedios(conn)

# Conectar a la base de datos
conn = conectar()
if conn:
    try:
        # Consultar los IDs de usuario desde la base de datos
        cur = conn.cursor()
        cur.execute("SELECT ID_usuario FROM Usuario")
        usuarios = [usuario[0] for usuario in cur.fetchall()]  # Obtener todos los IDs de usuario

        # Calcular promedios iniciales
        promedios_iniciales = calcular_promedios(conn)

        for usuario_id in usuarios:
            print(f"\nRecomendaciones para Usuario {usuario_id}:")
            recomendaciones_generales = generar_recomendaciones_generales(conn, promedios_iniciales)
            if recomendaciones_generales:
                for rec in recomendaciones_generales:
                    print(f"{rec['Título']} (Género: {rec['ID_género']}, Director: {rec['ID_director']}) - Promedio: {rec['promedio']:.2f}")

    finally:
        # Cerrar cursor y conexión
        if cur:
            cur.close()
        if conn:
            conn.close()
            print("Conexión PostgreSQL cerrada")
else:
    print("No se pudo conectar a la base de datos.")