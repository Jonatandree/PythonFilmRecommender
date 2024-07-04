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

# Función para generar recomendaciones personalizadas para un usuario específico
def generar_recomendaciones_personalizadas(conn, usuario_id):
    recomendaciones_personalizadas = []
    try:
        # Create a cursor object
        cur = conn.cursor()

        # Fetch movies rated 4 or higher by the user
        cur.execute("""
            SELECT p.ID_género, p.ID_director
            FROM Calificación c
            JOIN Película p ON c.ID_película = p.ID_película
            WHERE c.ID_usuario = %s AND c.Calificación >= 4
        """, (usuario_id,))
        preferencias_usuario = cur.fetchall()

        if preferencias_usuario:
            generos = set()
            directores = set()

            for pref in preferencias_usuario:
                generos.add(pref[0])
                directores.add(pref[1])

            # Execute query to fetch movies based on user preferences and high ratings
            cur.execute("""
                SELECT p.Título, p.ID_género, p.ID_director, AVG(c.Calificación) AS promedio
                FROM Película p
                JOIN Calificación c ON p.ID_película = c.ID_película
                WHERE p.ID_género = ANY(%s) OR p.ID_director = ANY(%s)
                GROUP BY p.Título, p.ID_género, p.ID_director
                HAVING COALESCE(AVG(c.Calificación), 0) >= 0
                ORDER BY promedio DESC
            """, (list(generos), list(directores)))

            # Fetch all rows from the result set
            recomendaciones = cur.fetchall()

            # Process fetched data
            for rec in recomendaciones:
                titulo = rec[0]
                id_genero = rec[1]
                id_director = rec[2]
                promedio = rec[3]

                recomendaciones_personalizadas.append({
                    'Título': titulo,
                    'ID_género': id_genero,
                    'ID_director': id_director,
                    'promedio': promedio
                })

        return recomendaciones_personalizadas

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

        # Generar recomendaciones personalizadas para cada usuario
        for usuario_id in usuarios:
            print(f"\nRecomendaciones para Usuario {usuario_id}:")
            recomendaciones_personalizadas = generar_recomendaciones_personalizadas(conn, usuario_id)
            if recomendaciones_personalizadas:
                for rec in recomendaciones_personalizadas:
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
