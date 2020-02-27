awk -F';' '{ printf "INSERT INTO groups VALUES (%s,\x27%s\x27,%s);",$1,$2,$3;print ""}' ./data/Groups.csv |
     sed ':a;N;$!ba;s/\r//g' > ./sql/002_add_groups.sql