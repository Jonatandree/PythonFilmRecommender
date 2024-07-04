import psycopg2
from psycopg2 import Error

# Función para conectar a la base de datos
def conectar():
    try:
        # Replace placeholders with your actual credentials
        host = "c5hilnj7pn10vb.cluster-czrs8kj4isg7.us-east-1.rds.amazonaws.com"
        dbname = "d5iadjk8hco3u9"
        user = "uq1n0nfa18qpc"
        password = "p35e6f1144021830e2e3e7253782e776b2359467969040c6288b7cef1718fdb81"

        # Connect to the PostgreSQL database
        conn = psycopg2.connect(
            host=host,
            dbname=dbname,
            user=user,
            password=password
        )
        return conn
    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL:", error)
        return None

# Función para calcular promedios iniciales de calificaciones de las películas desde la base de datos
def calcular_promedios(conn):
    promedios = {}
    try:
        # Create a cursor object
        cur = conn.cursor()

        # Execute query to fetch ratings data from database
        cur.execute("""
            SELECT ID_usuario, ID_película, Calificación
            FROM Calificación
        """)

        # Fetch all rows from the result set
        calificaciones = cur.fetchall()

        # Process fetched data to calculate ratings averages
        for cal in calificaciones:
            usuario_id = cal[0]
            pelicula_id = cal[1]
            calificacion = cal[2]

            if pelicula_id not in promedios:
                # Fetch movie details from Película table
                cur.execute("""
                    SELECT Título, ID_género, ID_director
                    FROM Película
                    WHERE ID_película = %s
                """, (pelicula_id,))
                pelicula_info = cur.fetchone()

                if pelicula_info:
                    titulo = pelicula_info[0]
                    id_genero = pelicula_info[1]
                    id_director = pelicula_info[2]

                    promedios[pelicula_id] = {'Título': titulo, 'ID_género': id_genero, 'ID_director': id_director, 'calificaciones': []}

            promedios[pelicula_id]['calificaciones'].append(calificacion)

        # Calculate averages for each movie
        for pelicula_id in promedios:
            calificaciones = promedios[pelicula_id]['calificaciones']
            promedios[pelicula_id]['promedio'] = sum(calificaciones) / len(calificaciones)

        return promedios

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL:", error)
        return None
    finally:
        # Close the cursor (if it exists) and connection
        if 'cur' in locals() and cur is not None:
            cur.close()

# Función para generar recomendaciones generales para todos los usuarios
def generar_recomendaciones_generales(conn, promedios):
    recomendaciones_generales = []
    try:
        # Create a cursor object
        cur = conn.cursor()

        # Execute query to fetch movies with high ratings
        cur.execute("""
            SELECT p.Título, p.ID_género, p.ID_director, pr.promedio
            FROM Película p
            JOIN (
                SELECT ID_película, AVG(Calificación) AS promedio
                FROM Calificación
                GROUP BY ID_película
                HAVING AVG(Calificación) >= 4.5
            ) pr ON p.ID_película = pr.ID_película
            ORDER BY pr.promedio DESC
        """)

        # Fetch all rows from the result set
        recomendaciones = cur.fetchall()

        # Process fetched data
        for rec in recomendaciones:
            titulo = rec[0]
            id_genero = rec[1]
            id_director = rec[2]
            promedio = rec[3]

            recomendaciones_generales.append({
                'Título': titulo,
                'ID_género': id_genero,
                'ID_director': id_director,
                'promedio': promedio
            })

        return recomendaciones_generales

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL:", error)
        return None
    finally:
        # Close the cursor (if it exists) and connection
        if 'cur' in locals() and cur is not None:
            cur.close()
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