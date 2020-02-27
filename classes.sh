awk -F';' '{ printf "INSERT INTO classes VALUES (%s,\x27%s\x27);",$1,$2;print ""}' ./data/Classes.csv |
     sed ':a;N;$!ba;s/\r//g' > ./sql/003_add_classes.sql