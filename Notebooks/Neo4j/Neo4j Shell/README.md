## Table of Contents
- [Connecting to Neo4j](#connecting-to-neo4j)
- [Basic Commands](#basic-commands)
  - [Nodes](#nodes)
  - [Relationships](#relationships)
  - [Queries](#queries)
- [Data Import/Export](#data-importexport)
  - [Importing Data (CSV)](#importing-data-csv)
  - [Exporting Data (CSV)](#exporting-data-csv)
- [Database Management](#database-management)
- [Useful Tips](#useful-tips)

## Installation
`cypher-shell` is included with Neo4j when installed via the official package or distribution. If you have Neo4j installed, you already have `cypher-shell`.

```bash
# If you need to install Neo4j (e.g., on Ubuntu):
wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.com stable 4.4' | sudo tee /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
sudo apt-get install neo4j
```

# Connecting to Neo4j
```bash
cypher-shell -u neo4j -p password
# or
cypher-shell -a bolt://localhost:7687 -u neo4j -p password
```


# Basic Commands

## Nodes
```bash
# Create a node
CREATE (n:Label {property1: 'value1', property2: 123});

# Retrieve all nodes with a label
MATCH (n:Label) RETURN n;

# Retrieve a specific node
MATCH (n:Label {property1: 'value1'}) RETURN n;

# Update a node
MATCH (n:Label {property1: 'value1'})
SET n.property2 = 456;

# Delete a node
MATCH (n:Label {property1: 'value1'}) DELETE n;

# Delete all nodes and relationships (DANGEROUS!)
MATCH (n) DETACH DELETE n;
```

## Relationships
```bash
# Create a relationship between two nodes
MATCH (a:Label1 {property1: 'value1'}), (b:Label2 {property2: 123})
CREATE (a)-[r:RELATES_TO]->(b);

# Retrieve all relationships
MATCH ()-[r:RELATES_TO]->() RETURN r;

# Retrieve specific relationships
MATCH (a:Label1)-[r:RELATES_TO]->(b:Label2) RETURN a, r, b;

# Delete a relationship
MATCH (a:Label1)-[r:RELATES_TO]->(b:Label2) DELETE r;
```

## Queries
```bash
# Simple query to return data
MATCH (n:Label) WHERE n.property > 100 RETURN n;

# Aggregate query with COUNT
MATCH (n:Label) RETURN COUNT(n);

# Query with ORDER BY and LIMIT
MATCH (n:Label) RETURN n ORDER BY n.property DESC LIMIT 5;

# Using WITH to chain operations
MATCH (n:Label) WHERE n.property > 100
WITH n, COUNT(n) AS count
RETURN n, count;
```

# Data Import/Export

## Importing Data (CSV)

```bash
LOAD CSV WITH HEADERS FROM 'file:///path/to/file.csv' AS row
CREATE (n:Label {property1: row.column1, property2: toInteger(row.column2)});
```

## Exporting Data (CSV)

```bash
CALL apoc.export.csv.query(
  'MATCH (n:Label) RETURN n.property1, n.property2',
  'output.csv', {}
);
```

# Database Management
```bash
# Start Neo4j
neo4j start

# Stop Neo4j
neo4j stop

# Restart Neo4j
neo4j restart

# Check Neo4j status
neo4j status

# List all databases (Neo4j 4.x+)
SHOW DATABASES;

# Switch database (Neo4j 4.x+)
:use database-name;
```

# Useful Tips

- Autocompletion: Press `TAB` in `cypher-shell` for command completion.
- Multiline Commands: End a line with `\` to continue a command on the next line.
- Help: Type `:help` or `:commands` for help and available commands.
- Comments: Use `//` for single-line comments.