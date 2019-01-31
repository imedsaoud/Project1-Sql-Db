#!/bin/bash

cd $(dirname $0)
dkname=DbFTW

if [ -z $1 ]; then
    max=15
else
    max=$1
fi

if [ ! -d ./.dbs ]; then
    mkdir -p ./.dbs
fi

# if [ ! -d ./dumps ]; then
#     mkdir -p ./dumps
# fi

docker stop DbFTW || true
docker rm DbFTW || true
docker run -d --name "$dkname" -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -v "$PWD"/.dbs:/var/lib/mysql mysql:5.7
dumpdir=./dumps/$(date '+%Y%m%d-%H%M%S')
mkdir -p "$dumpdir"

# EEEEUUUUURRRRRKKK...
echo Waiting "$max" seconds for the container to run \(you can set it by passing it to this program as first argument\)
for i in $(seq 0 $max); do
    echo $i seconds....
    sleep 1
done

docker exec -it "$dkname" /bin/bash -c "mysql -uroot -p"
# docker exec -it "$dkname" sh -c "mysqldump -uroot -proot --all-databases" >> $dumpdir/dump.sql
docker stop "$dkname" || true
docker rm "$dkname" || true
