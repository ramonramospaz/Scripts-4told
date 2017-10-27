#!/bin/bash
# ------------------------------------------------------------------
# [Ramon Ramos] run_mariadb 
#         create de database 4told-fin and populate it.   
#         
# ------------------------------------------------------------------
# Search the main folder.
cd
cd DockerImage/mariadb/
echo "Removing mariadb Image....."
docker stop mariadb
docker rm mariadb
echo "Running image mariadb...."
docker run --name mariadb -e MYSQL_ROOT_PASSWORD='0pt!musP' -p 3306:3306 -d mariadb:latest
echo "Load Database 4told-fin"
docker cp Db/4told-fin-backup.sql  mariadb:/tmp
sleep 20; 
docker exec mariadb /bin/bash -c "mysqladmin -uroot -p0pt!musP CREATE '4told-fin'"
while [ $? -ne 0 ]; do
	sleep 20 
	docker exec mariadb /bin/bash -c "mysqladmin -uroot -p0pt!musP CREATE '4told-fin'"
done
cd ~/Repositorios/finapp-backend/
mvn -f finapp-liquibase/pom.xml \
-Dliquibase.password=0pt\!musP \
-Dliquibase.username=root \
-Dliquibase.url=jdbc:mysql://localhost:3306/4told-fin \
-Dliquibase.driver=com.mysql.jdbc.Driver \
-Dliquibase.changeLogFile=db.changelog-1.0.0.xml \
-Dliquibase.rollbackTag= \
-Dliquibase.promptOnNonLocalDatabase=false \
-Dliquibase.tag= \
-Pupdate \
install
#sleep 20
docker exec mariadb /bin/bash -c 'mysql -u root -p0pt!musP </tmp/4told-fin-backup.sql'
#while [ $? -ne 0 ]; do
#	sleep 20 
#	docker exec mariadb /bin/bash -c 'mysql -u root -p0pt!musP </tmp/Dump20170608-4told-fin-backup.sql'
#done
echo "User:root"
echo "Password:0pt!musP"
echo "................"
