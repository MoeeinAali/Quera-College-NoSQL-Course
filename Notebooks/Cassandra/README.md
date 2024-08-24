## Table of Contents
- [Start Cassandra](#start-cassandra)
- [Using Docker](#using-docker)
- [Connecting to Cassandra](#connecting-to-cassandra)
- [CQL Basics](#cql-basics)
  - [Keyspaces](#keyspaces)
  - [Tables](#tables)
  - [Inserts](#inserts)
  - [Queries](#queries)
  - [Updates](#updates)
  - [Deletes](#deletes)
- [Advanced CQL](#advanced-cql)
  - [Indexes](#indexes)
  - [User-Defined Types (UDTs)](#user-defined-types-udts)
  - [Batch Operations](#batch-operations)
- [Backup and Restore](#backup-and-restore)
  - [Backing Up Data](#backing-up-data)
  - [Restoring Data](#restoring-data)

## Installation

### Using Package Manager
```bash
# Add the DataStax repository (Ubuntu/Debian)
echo "deb https://debian.datastax.com/enterprise stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.sources.list
curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
sudo apt-get update
sudo apt-get install cassandra
```

# Start Cassandra
```bash
sudo service cassandra start
```

# Using Docker
```bash
docker run --name cassandra -d cassandra:latest
```

# Connecting to Cassandra
```bash
# Start the Cassandra shell (cqlsh)
cqlsh

# Connect to a specific node
cqlsh <hostname> 9042

# Exit cqlsh
exit
```
# CQL Basics
## Keyspaces
```bash
# Create a keyspace
CREATE KEYSPACE mykeyspace
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

# Use a keyspace
USE mykeyspace;

# List all keyspaces
DESCRIBE keyspaces;

# Drop a keyspace
DROP KEYSPACE mykeyspace;
```
## Tables
```bash
# Create a table
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    name TEXT,
    age INT,
    email TEXT
);

# List all tables
DESCRIBE tables;

# Describe a table
DESCRIBE TABLE users;

# Drop a table
DROP TABLE users;
```

## Inserts
```bash
# Insert a single row
INSERT INTO users (user_id, name, age, email)
VALUES (uuid(), 'Alice', 30, 'alice@example.com');

# Insert multiple rows (requires BATCH)
BEGIN BATCH
  INSERT INTO users (user_id, name, age, email) VALUES (uuid(), 'Bob', 25, 'bob@example.com');
  INSERT INTO users (user_id, name, age, email) VALUES (uuid(), 'Charlie', 35, 'charlie@example.com');
APPLY BATCH;
```

## Queries
```bash
# Select all rows from a table
SELECT * FROM users;

# Select specific columns
SELECT name, age FROM users;

# Filtering with WHERE clause (on indexed or primary key columns)
SELECT * FROM users WHERE user_id = <UUID>;

# Limit the number of results
SELECT * FROM users LIMIT 10;

# Order results by a clustering column
SELECT * FROM users WHERE name = 'Alice' ORDER BY age DESC;
```


## Updates
```bash
# Update a row
UPDATE users SET age = 31 WHERE user_id = <UUID>;

# Update multiple columns
UPDATE users SET age = 32, email = 'newalice@example.com' WHERE user_id = <UUID>;
```

## Deletes
```bash
# Delete a row
DELETE FROM users WHERE user_id = <UUID>;

# Delete specific columns from a row
DELETE email FROM users WHERE user_id = <UUID>;
```

# Advanced CQL
## Indexes
```bash
# Create an index on a column
CREATE INDEX ON users (email);

# Drop an index
DROP INDEX users_email_idx;
```

## User-Defined Types (UDTs)
```bash
# Create a UDT
CREATE TYPE address (
    street TEXT,
    city TEXT,
    zip_code INT
);

# Use a UDT in a table
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    name TEXT,
    address FROZEN<address>
);

# Insert data into a UDT field
INSERT INTO users (user_id, name, address)
VALUES (uuid(), 'Alice', {street: '123 Main St', city: 'Wonderland', zip_code: 12345});
```

## Batch Operations

```bash
# Perform multiple operations as a batch
BEGIN BATCH
  INSERT INTO users (user_id, name, age) VALUES (uuid(), 'Dan', 28);
  UPDATE users SET email = 'dan@example.com' WHERE user_id = <UUID>;
  DELETE FROM users WHERE user_id = <UUID>;
APPLY BATCH;
```

# Backup and Restore
## Backing Up Data
```bash
# Take a snapshot of a keyspace
nodetool snapshot mykeyspace
```

## Restoring Data
```bash
# Restore from a snapshot (manual copy needed)
sudo cp /var/lib/cassandra/data/mykeyspace/snapshots/* /var/lib/cassandra/data/mykeyspace/
```