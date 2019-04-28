# Code to confirm a bug in DB Context Scaffold of Entity Framework Core

When I generated my DB Context from an existing PostgreSQL database by Entity Framework Core's scaffold and tried initializing the database in another PostgreSQL server, it failed. Errors happened for table creations which contains columns of serial type. The small code here is for testing such table creation by Entity Framework.

## Dependencies
* 
* Microsoft.EntityFrameworkCore 2.2.4
* Microsoft.EntityFrameworkCore.Design 2.2.4
* Npgsql 4.0.6
* Npgsql.EntityFrameworkCore.PostgreSQL 2.2.0
* bash
* psql
* tee
* Docker
* [Docker Image postgres](https://hub.docker.com/_/postgres)

## Test Steps
1. Start an empty PostgreSQL Server in docker
1. Create a database and a table with a column of "serial" type
1. Run DB Context Scaffold
1. Start another empty PostgreSQL Server in docker
1. Add a migration for the generated DB Context
1. Install the database by the DB Context
1. Test the installed database table
