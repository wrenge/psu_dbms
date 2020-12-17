import psycopg2
import csv


def quote(string):
    return f"'{string}'"


def insert(cursor, row):
    cursor.execute(
        """call insert_book_request({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7})""".format(
            row[0], quote(row[1]), quote(row[2]), row[3],
            row[4], row[5], row[6], quote(row[7].replace("\'", "\'\'"))))


def generate():
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
    cur_ds = con_ds.cursor()
    con_ds.autocommit = True

    with con_db.cursor() as cur_db:
        cur_db.execute(f"""
        copy (select request_quantity,
                 request_cost,
                 request_date,
                 category_id,
                 author_id,
                 b.subject_id,
                 publisher_id,
                 book_name
          from request r
                   inner join books b on b.book_id = r.book_id
                   inner join subject s on s.subject_id = b.subject_id) to '/usr/import/data/etl/export.csv'
                   """)
    con_db.close()
    with open('../../../data/etl/export.csv', newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile, delimiter='	')
        for row in reader:
            insert(cur_ds, row)
    cur_ds.close()
    con_ds.close()


generate()
