#!/usr/bin/python
import random

def q(query):
    return query.strip('\n\r')

o = open ('./sql/009_add_publishers.sql', 'w')
with open ('./data/Publishers.csv', 'r') as f:
    for row in f:
        values = row.split(',')
        query = 'INSERT INTO Publisher VALUES (N\'{0}\', {1})'
        query = query.format(values[0].strip('\r\n'), hash(row) % 36 + 1)
        o.write(q(query) + '\n')