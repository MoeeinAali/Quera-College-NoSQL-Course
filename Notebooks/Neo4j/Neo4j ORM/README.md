
## Table of Contents
- [Connecting to Neo4j](#connecting-to-neo4j)
- [Basic Operations](#basic-operations)
  - [Nodes](#nodes)
  - [Relationships](#relationships)
  - [Queries](#queries)
- [Transactions](#transactions)
- [Error Handling](#error-handling)
- [Connection Management](#connection-management)

## Installation
```bash
pip install neo4j
```

# Connecting to Neo4j
```python
from neo4j import GraphDatabase

# Create a driver instance
uri = "bolt://localhost:7687"
driver = GraphDatabase.driver(uri, auth=("neo4j", "password"))

# Open a session
with driver.session() as session:
    result = session.run("RETURN 'Hello, Neo4j!' AS message")
    print(result.single()["message"])
```

# Basic Operations
## Nodes

```python
# Create a node
def create_node(tx, label, properties):
    query = f"CREATE (n:{label} $properties) RETURN n"
    return tx.run(query, properties=properties)

# Example usage
with driver.session() as session:
    session.write_transaction(create_node, "Person", {"name": "Alice", "age": 30})

# Retrieve a node
def get_node(tx, label, key, value):
    query = f"MATCH (n:{label} {{{key}: $value}}) RETURN n"
    return tx.run(query, value=value).single()

# Example usage
with driver.session() as session:
    node = session.read_transaction(get_node, "Person", "name", "Alice")
    print(node["n"])
```
## Relationships
```python
# Create a relationship
def create_relationship(tx, label1, key1, value1, label2, key2, value2, rel_type):
    query = f"""
    MATCH (a:{label1} {{{key1}: $value1}}), (b:{label2} {{{key2}: $value2}})
    CREATE (a)-[r:{rel_type}]->(b)
    RETURN r
    """
    return tx.run(query, value1=value1, value2=value2)

# Example usage
with driver.session() as session:
    session.write_transaction(create_relationship, "Person", "name", "Alice", "Person", "name", "Bob", "KNOWS")

# Retrieve a relationship
def get_relationship(tx, label1, key1, value1, label2, key2, value2, rel_type):
    query = f"""
    MATCH (a:{label1} {{{key1}: $value1}})-[r:{rel_type}]-(b:{label2} {{{key2}: $value2}})
    RETURN r
    """
    return tx.run(query, value1=value1, value2=value2).single()

# Example usage
with driver.session() as session:
    relationship = session.read_transaction(get_relationship, "Person", "name", "Alice", "Person", "name", "Bob", "KNOWS")
    print(relationship["r"])
```

## Queries
```python
# Run an arbitrary Cypher query
def run_query(tx, query, parameters=None):
    return tx.run(query, parameters)

# Example usage: Retrieving all nodes of a label
with driver.session() as session:
    query = "MATCH (n:Person) RETURN n.name, n.age"
    results = session.read_transaction(run_query, query)
    for record in results:
        print(record["n.name"], record["n.age"])
```
# Transactions
```python
# Handling transactions
with driver.session() as session:
    try:
        with session.begin_transaction() as tx:
            tx.run("CREATE (a:Person {name: 'John', age: 25})")
            tx.run("CREATE (b:Person {name: 'Doe', age: 24})")
            tx.commit()  # Commit transaction
    except Exception as e:
        tx.rollback()  # Rollback transaction if there is an error
        print(f"Transaction failed: {e}")
```
# Error Handling
```python
from neo4j.exceptions import ServiceUnavailable, CypherSyntaxError

try:
    with driver.session() as session:
        session.run("INVALID CYPHER QUERY")
except ServiceUnavailable as e:
    print(f"Service is unavailable: {e}")
except CypherSyntaxError as e:
    print(f"Syntax error in Cypher query: {e}")
```

# Connection Management
```python
# Close the driver connection
driver.close()

# Use connection pooling
driver = GraphDatabase.driver(uri, auth=("neo4j", "password"), max_connection_pool_size=50)
```