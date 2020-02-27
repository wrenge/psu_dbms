echo "INSERT INTO readers
     VALUES" > ./sql/004_add_readers_bak.sql
awk -F';' '{ printf "\t(N\x27%s\x27,N\x27%s\x27,N\x27%s\x27,%s,%s,\x27%s\x27,\x27%s\x27)",$1,$2,$3,$4,$5,$6,$7;print ""}' ./data/Readers.csv |
     sed ':a;N;$!ba;s/\r//g' |
     sed ':a;N;$!ba;s/\n/,\n/g' |
     sed 's/'
     sed 's/,,/,NULL,/g' >> ./sql/004_add_readers_bak.sql