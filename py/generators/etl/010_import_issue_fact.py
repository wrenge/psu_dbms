import psycopg2
import csv


def quote(string):
    return f"'{string}'"


def insert(cursor, row):
    cursor.execute(
        """call insert_issue_fact({0}, {1}, {2}, {3}, {4}, {5}, {6})""".format(
            quote(row[0].replace("\'", "\'\'")), row[1], row[2], row[3],
            row[4], quote(row[5]), row[6]))


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
        cur_db.execute("""
        copy (select book_name,
            author_id,
            publisher_id,
            category_id,
            b.subject_id,
            r.issue_date,
            group_id
        from issues r
            inner join instance i on i.instance_id = r.instance_id
            inner join books b on b.book_id = i.book_id
            inner join subject s on s.subject_id = b.subject_id
            inner join readers r2 on r.reader_id = r2.reader_id
        ) to '/usr/import/data/etl/export.csv'
                   """)
    con_db.close()
    with open('../../../data/etl/export.csv', newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile, delimiter='	')
        for row in reader:
            insert(cur_ds, row)
    cur_ds.close()
    con_ds.close()


generate()
