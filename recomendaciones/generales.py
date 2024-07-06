import psycopg2 # pip install psycopg2-binary
from psycopg2 import Error

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