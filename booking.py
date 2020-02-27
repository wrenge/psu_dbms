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


def rh(a, b):
    return (((a + 1298074214633706835075030044377087) * 16769023) ** 3) + (
                (((b + 1298074214633706835075030044377087) * 16769023) ** 3) % (60 * 60 * 24 * 30 * 12 * 6))


o = open('./sql/015_add_booking.sql', 'w')
count_rows = 0
first = True

for i in range(674):
    reader_id = i + 1
    num_books = r(reader_id, 0, 3)
    books = list(range(1, 43))
    for j in range(num_books):
        if count_rows % 1000 == 0:
            o.write("\nINSERT INTO Booking\n\tVALUES")
            first = True
        count_rows += 1
        if not first:
            query = ',\n\t'
        else:
            query = '\n\t'
            first = False

        query += '({0},{1},{2})'
        row_hash = rh(reader_id, j)
        book_id = books[r(row_hash, 0, len(books) - 1)]
        books.remove(book_id)
        min_date = datetime.date(2000, 1, 1)
        max_date = datetime.date(2020, 1, 1)
        timestamp_min = int(time.mktime(min_date.timetuple()))
        timestamp_max = int(time.mktime(max_date.timetuple()))
        booking_timestamp = r(row_hash, timestamp_min, timestamp_max)
        print(booking_timestamp)
        booking_date = '\'' + datetime.datetime.fromtimestamp(booking_timestamp).strftime('%Y%m%d') + '\''
        end_date = '\'' + datetime.datetime.fromtimestamp(booking_timestamp + 2592000).strftime('%Y%m%d') + '\''
        query = query.format(book_id, end_date, reader_id)
        o.write(query)
o.close()
