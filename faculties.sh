awk -F';' '{ printf "INSERT INTO faculties VALUES (%s,\x27%s\x27,\x27%s\x27);",$1,$2,$3;print ""}' ./data/faculties.csv |
     sed ':a;N;$!ba;s/\r//g' > ./sql/001_add_faculties.sql