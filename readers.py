#!/usr/bin/python
import datetime
from dateutil.parser import parse
import codecs


def q(tquery):
    tquery = tquery.strip('\n')
    tquery = tquery.strip('\r')
    tquery = tquery.replace('\'', '\'\'')
    tquery = tquery.replace('\"', '\\\"')
    return tquery


def r(row, min, max):
    return hash(row) % (max - min + 1) + min


def d(datestr):
    return parse(datestr).strftime("%Y%m%d")


o = codecs.open('./sql/004_add_readers.sql', 'w', "utf_8_sig")
o.write("INSERT INTO Issues\n\tVALUES")
first = True
names = []
f = codecs.open("./data/Readers.csv", "r", "utf_8_sig")
for row in f:
    values = row.split(';')
    if not first:
        query = ',\n\t'
    else:
        query = '\n\t'
    query += '(N\'{0}\',N\'{1}\',{2},{3},{4},\'{5}\',\'{6}\')'
    val3 = values[3] if len(values[3]) > 0 else 'NULL'
    val2 = 'N\'' + q(values[2]) + '\'' if len(values[3]) > 0 else 'NULL'
    query = query.format(q(values[0]), q(values[1]), val2, val3, q(values[4]), d(values[5]),
                         d(values[6]))
    o.write(query)
    first = False
f.close()
o.close()
