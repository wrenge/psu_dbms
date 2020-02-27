#!/usr/bin/python
import random

def q(query):
    query = query.strip('\n\r')
    query = query.replace('\'', '\'\'')
    query = query.replace('\"', '\\\"')
    return query

def r(row, min, max):
    return hash(row) % (max - min + 1) + min

o = open('./sql/010_add_books.sql', 'w')
o.write("INSERT INTO Books(Book_name, Author_id, Publisher_id, Subject_id, Category_id)\n\tVALUES")
first = True
names = []
with open ('./data/Books.csv', 'r') as f:
    for row in f:
        values = row.split(',')
        if values[0] in names:
            continue
        names.append(values[0])
        if(not first): 
            query = ',\n\t'
        else:
            query = '\n\t'
        query += '(N\'{0}\', {1}, {2}, {3}, {4})'
        category = r(row, 1, 2)
        subject = r(row, 1, 6) if category == 1 else 'NULL'
        query = query.format(q(values[0]), r(row, 1, 10), r(row, 1, 17), subject, category)
        o.write(query)
        first = False