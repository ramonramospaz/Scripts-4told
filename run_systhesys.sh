#!/bin/bash
# ------------------------------------------------------------------
# [Ramon Ramos] run_synthesys 
#          Create and run the docker image synthesys
# ------------------------------------------------------------------

#Check is the command docker exist.
command -v docker >/dev/null 2>&1 || {
	echo >&2 "I require docker but it's not installed. Abortig."; 
	exit 1;
}

cd ~/Repositorios/finapp-backend/oracle-synthesys
#Do the script job.
echo "Creating Synthesys Image..."
docker build -t 4ft .
echo "Removing 4ft image"
docker stop 4ft
docker rm 4ft
echo "Running image 4ft"
docker run --name 4ft -d -p 8888:8888 -p 8081:8080 -p 1521:1521 4ft
sleep 20
echo "Synthesys is running..."
echo "Url=http://localhost:8081/ords/f?p=1300:LOGIN_DESKTOP"
echo "user:view100"
echo "password:100tester"
