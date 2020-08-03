Please run the following script to configure environment variables we'll use throughout the workshop. You'll be prompted for a password, which will be provided by the workshop instructor.
```
source .get_envvars.sh
```{{execute}}

# Database
The following environment variables provide information required to connect to the PostgreSQL database we'll be working with.
- `PGHOST`: The host address of the database
- `PGPORT`: The port on which the database is serving connections
- `PGDATABASE`: The name of the database we'll be connecting to
- `PGUSER`: The database user we will be connecting as
- `PASSWORD`: The password associated with the database user

Run the following command to connect to the database through the CLI.
```
PGPASSWORD=$PASSWORD psql
```{{execute}}

Query the table and you'll see that it has a single row.
```
SELECT * FROM users;
```{{execute}}

Now, get back to the shell by running `\q`{{execute}}.
