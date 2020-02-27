#!/usr/bin/python
import random
import datetime
import time


def q(query):
    query = query.strip('\n\r')
    query = query.replace('\'', '\'\'')
    query = query.replace('\"', '\\\"')
    return query


def r(row, min, max):
    return hash(row) % (max - min + 1) + min


def rh(a, b=0):
    return (((a + 1298074214633706835075030044377087) * 16769023) ** 3) + (
            (((b + 1298074214633706835075030044377087) * 16769023) ** 3) % (60 * 60 * 24 * 30 * 12 * 6))


o = open('./sql/016_add_requests.sql', 'w')
count_rows = 0
first = True
books = list(range(1, 43))
random.seed(1337)
random.shuffle(books)
books = books[:len(books) - int(len(books) / 2)]
for i in books:
    book_id = i
    if count_rows % 1000 == 0:
        o.write("\nINSERT INTO Request\n\tVALUES")
        first = True
    count_rows += 1
    if not first:
        query = ',\n\t'
    else:
        query = '\n\t'
        first = False

    query += '({0},{1},{2},{3})'
    row_hash = rh(book_id)

    cost_min = 300
    cost_max = 1500
    request_cost = r(row_hash, cost_min, cost_max)

    quantity_min = 1
    quantity_max = 20
    request_quantity = r(row_hash, quantity_min, quantity_max)

    min_date = datetime.date(2000, 1, 1)
    max_date = datetime.date(2020, 1, 1)
    timestamp_min = int(time.mktime(min_date.timetuple()))
    timestamp_max = int(time.mktime(max_date.timetuple()))
    request_timestamp = r(row_hash, timestamp_min, timestamp_max)
    request_date = '\'' + datetime.datetime.fromtimestamp(request_timestamp).strftime('%Y%m%d') + '\''

    query = query.format(book_id, request_cost, request_quantity, request_date)
    o.write(query)
o.close()
