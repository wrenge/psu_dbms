awk -F';' '{ printf "INSERT INTO City VALUES (N\x27%s\x27);",$1;print ""}' ./data/City.csv |
     sed ':a;N;$!ba;s/\r//g' |
     sed 's/,,/,NULL,/g' > ./sql/006_add_cities.sql