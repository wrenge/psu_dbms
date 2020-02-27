#!/usr/bin/python
li = []
with open ('./data/Books.csv', 'r') as f:
    for row in f:
        if(not (row in li)):
            li.append(row)
f.close()
o = open('./data/Publishers.csv', 'w')
for row in li:
    o.write(row.strip('\r\n') + '\n')