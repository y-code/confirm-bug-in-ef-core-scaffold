#!/bin/bash

SD="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
PATH_TO_PROJECT_DIR=$1
DOCKER_NAME=$2
DB_PORT=$3
POSTGRES_PASSWORD=docker
WAIT_SECONDS_FOR_DB_START_UP=3

echo
echo ==============================
echo " DBContext Scaffold, and"
echo " DB Installation by DBContext"
echo ==============================
echo
echo [INFO] Project where DBContext is generated: $PATH_TO_PROJECT_DIR
echo [INFO] postgres Docker Name: $DOCKER_NAME
echo [INFO] Port to which postgres docker connects: $DB_PORT
echo

cd $SD

echo [INFO] Starting an empty PostgreSQL Server...
echo

docker stop $DOCKER_NAME
docker run --rm --name $DOCKER_NAME -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -p $DB_PORT:5432 -d postgres
sleep $WAIT_SECONDS_FOR_DB_START_UP

echo
echo [INFO] Creating a database and a table with a column of \"serial\" type...
echo
echo [INFO] The password of postgres is \'$POSTGRES_PASSWORD\', by the way.
echo

if ! psql -h localhost -U postgres -p $DB_PORT -f $SD/Database/install.sql -v db=sampledb
then
  echo ERROR: failed to create sample database. 2>&1
  exit 1
fi

echo
echo [INFO] Running DB Context Scaffold...
echo

if ! dotnet ef dbcontext scaffold -p $PATH_TO_PROJECT_DIR -o Model/Sample --schema sample -c SampleDbContext "Server=localhost;Port=$DB_PORT;Database=sampledb;User Id=postgres;Password=$POSTGRES_PASSWORD" "Npgsql.EntityFrameworkCore.PostgreSQL" -f -v
then
  exit 1
fi

echo
echo [INFO] Starting another empty PostgreSQL Server...
echo

docker stop $DOCKER_NAME
docker run --rm --name $DOCKER_NAME -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -p $DB_PORT:5432 -d postgres
sleep $WAIT_SECONDS_FOR_DB_START_UP

echo
echo [INFO] Adding EF Migration for the generated DB Context...
echo

dotnet ef migrations remove -p $PATH_TO_PROJECT_DIR
if ! dotnet ef migrations add -p $PATH_TO_PROJECT_DIR first
then
  exit 1
fi

echo
echo [INFO] Installing the database by DB Context
echo

dotnet ef database update -p $PATH_TO_PROJECT_DIR -c SampleDbContext -v

echo
echo [INFO] Testing the installed database table...
echo
echo [INFO] The password of postgres is \'$POSTGRES_PASSWORD\', by the way.
echo

psql -h localhost -p $DB_PORT -U postgres -c "\d sample.message" sampledb 2>&1 | tee test_result.txt
if [ "$(sed -n 4p test_result.txt)" == " id      | integer |           | not null | nextval('sample.message_id_seq'::regclass)" ]
then
    echo
    echo [INFO] Test passed.

    echo
else
    echo
    echo [ERROR] Test failed!
    echo
fi

rm test_result.txt
