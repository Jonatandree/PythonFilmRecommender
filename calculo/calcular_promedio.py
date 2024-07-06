import psycopg2
from psycopg2 import Error


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