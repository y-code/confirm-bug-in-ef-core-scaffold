# Code to confirm a bug in DB Context Scaffold of Entity Framework Core

When I generated my DB Context from an existing PostgreSQL database by Entity Framework Core's scaffold and tried initializing the database in another PostgreSQL server, it failed. Errors happened for table creations which contains columns of serial type. The small code here is for testing such table creation by Entity Framework.

## Test Steps
1. Start an empty PostgreSQL Server in docker
1. Create a database and a table with a column of "serial" type
1. Run DB Context Scaffold
1. Start another empty PostgreSQL Server in docker
1. Add a migration for the generated DB Context
1. Install the database by the DB Context
1. Test the installed database table
