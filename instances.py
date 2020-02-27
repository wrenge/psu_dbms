#!/usr/bin/python
import random

def q(query):
    query = query.strip('\n\r')
    query = query.replace('\'', '\'\'')
    query = query.replace('\"', '\\\"')
    return query

def r(row, min, max):
    return hash(row) % (max - min + 1) + min

o = open('./sql/012_add_instances.sql', 'w')

def rh(a, b = 0):
    return (((a + 1298074214633706835075030044377087) * 16769023) ** 3) + (
                (((b + 1298074214633706835075030044377087) * 16769023) ** 3) % (60 * 60 * 24 * 30 * 12 * 6))

count_rows = 0
first = True
for i in range(43):
    for j in range(100):
        if count_rows % 1000 == 0:
            o.write("\nINSERT INTO Instance\n\tVALUES")
            first = True
        count_rows += 1
        if not first:
            query = ',\n\t'
        else:
            query = '\n\t'
            first = False
        query += '({0}, {1}, {2})'
        book_id = i + 1
        book_hash = rh(rh(book_id), rh(j))
        if(book_hash % 2 == 0):
            book_hash = ~book_hash
        query = query.format(book_id, r(book_hash, 50, 100), r(book_hash, 1980, 2019))
        o.write(query)
o.close()