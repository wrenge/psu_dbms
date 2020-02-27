awk -F';' '{ printf "INSERT INTO Category VALUES (N\x27%s\x27);",$1;print ""}' ./data/Genres.csv |
     sed ':a;N;$!ba;s/\r//g' |
     sed 's/,,/,NULL,/g' > ./sql/007_add_genres.sql