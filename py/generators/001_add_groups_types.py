import psycopg2


def generate():
    con = psycopg2.connect(
        database="postgres",
        dbname="uni_library",
        user="postgres",
        password="1111",
        host="127.0.0.1",
        port="5432"
    )
    cur = con.cursor()
    cur.execute("""INSERT INTO grouptype(type_name)
    VALUES (N'Группа'),
           (N'Кафедра');""")
    cur.commit()
