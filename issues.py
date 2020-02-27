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

def rh(a, b = 0):
    return (((a + 1298074214633706835075030044377087) * 16769023) ** 3) + (
                (((b + 1298074214633706835075030044377087) * 16769023) ** 3) % (60 * 60 * 24 * 30 * 12 * 6))


o = open('./sql/014_add_issues.sql', 'w')
count_rows = 0
first = True
for i in range(674):
    reader_id = i + 1
    num_books = r(reader_id, 0, 13)
    for j in range(num_books):
        if count_rows % 1000 == 0:
            o.write("\nINSERT INTO Issues\n\tVALUES")
            first = True
        count_rows += 1
        if not first:
            query = ',\n\t'
        else:
            query = '\n\t'
            first = False
        query += '({0},{1},{2},{3},{4})'
        instance_id = r(rh(reader_id + count_rows), 1, 4299)
        row_hash = rh(reader_id, instance_id)
        min_date = datetime.date(2000, 1, 1)
        max_date = datetime.date(2020, 1, 1)
        timestamp_min = int(time.mktime(min_date.timetuple()))
        timestamp_max = int(time.mktime(max_date.timetuple()))
        issue_timestamp = r(row_hash, timestamp_min, timestamp_max)
        issue_date = '\'' + datetime.datetime.fromtimestamp(issue_timestamp).strftime('%Y%m%d') + '\''
        if r(row_hash, 0, 100) < 90:
            receive_date = '\'' + datetime.datetime.fromtimestamp(issue_timestamp + r(row_hash, 604800, 2592000)).strftime('%Y%m%d') + '\''
        else:
            receive_date = 'NULL'
        return_date = '\'' + datetime.datetime.fromtimestamp(issue_timestamp + 2592000).strftime('%Y%m%d') + '\''
        query = query.format(reader_id, instance_id, issue_date, receive_date, return_date)
        o.write(query)
o.close()
