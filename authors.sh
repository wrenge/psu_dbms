awk -F';' '{ printf "INSERT INTO Author VALUES (N\x27%s\x27,N\x27%s\x27,N\x27%s\x27);",$1,$2,$3;print ""}' ./data/Authors.csv |
     sed ':a;N;$!ba;s/\r//g' |
     sed 's/,,/,NULL,/g' > ./sql/005_add_authors.sql