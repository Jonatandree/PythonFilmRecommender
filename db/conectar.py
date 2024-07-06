import psycopg2 # pip install psycopg2-binary
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