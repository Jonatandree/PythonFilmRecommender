import psycopg2
from psycopg2 import Error

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