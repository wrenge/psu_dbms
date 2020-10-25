from root import root
import psycopg2

# def generate():
con = psycopg2.connect(
    dbname="uni_library",
    user="postgres",
    password="1111",
    host="127.0.0.1",
    port="5432"
)
cur = con.cursor()
with open(str(root) + '/data/Faculties.csv', 'r') as f:
    next(f)
    cur.copy_from(f, 'faculties', sep=';', columns=('faculty_name', 'faculty_acronym'))
