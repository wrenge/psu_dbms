import psycopg2


def transfer(src_query, dest_query):
    export_csv_path = "/usr/import/data/etl/export.csv"
    con_db = psycopg2.connect(
        database="uni_library",
        user="postgres",
        password="1002",
        host="127.0.0.1",
        port="5432"
    )

    con_ds = psycopg2.connect(
        database="uni_storage",
        user="postgres",
        password="1002",
        host="127.0.0.1",
        port="5432"
    )

    with con_db.cursor() as cur_db:
        cur_db.execute(f"""COPY ({src_query})
                        TO '{export_csv_path}'""")

    con_ds.autocommit = True
    with con_ds.cursor() as cur_ds:
        cur_ds.execute(f"""copy {dest_query}
                        FROM '/usr/import/data/etl/export.csv'""")
    con_db.close()
    con_ds.close()

