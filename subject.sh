awk -F';' '{ printf "INSERT INTO Subject VALUES (N\x27%s\x27);",$1;print ""}' ./data/subjects.csv |
     sed ':a;N;$!ba;s/\r//g' |
     sed 's/,,/,NULL,/g' > ./sql/008_add_subjects.sql