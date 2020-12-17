import psycopg2


def import_names():
    con_db = psycopg2.connect(
        database="uni_library",
        user="postgres",
        password="1002",
        host="127.0.0.1",
        port="5432"
    )
    with con_db.cursor() as cur_db:
        cur_db.execute("""select distinct book_name from books""")
        names = cur_db.fetchall()

    con_db.close()
    return list(next(zip(*names)))


def generate():
    imported_names = import_names()
    all_names = ','.join("(\'{0}\')".format(name.replace("\'", "\'\'")) for name in imported_names)

    con_ds = psycopg2.connect(
        database="uni_storage",
        user="postgres",
        password="1002",
        host="127.0.0.1",
        port="5432"
    )
    con_ds.autocommit = True
    with con_ds.cursor() as cur_ds:
        cur_ds.execute(f"""insert into book_name (book_name) values {all_names}""")
    cur_ds.close()
    con_ds.close()


generate()
