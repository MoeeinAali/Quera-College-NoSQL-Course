# Elasticsearch Cheat Sheet

This cheat sheet provides a quick reference for working with Elasticsearch, covering basic commands, queries, and common operations.

## Table of Contents
- [Elasticsearch Cheat Sheet](#elasticsearch-cheat-sheet)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [Using Docker](#using-docker)
    - [Manual Installation (Linux)](#manual-installation-linux)
- [Connecting to Elasticsearch](#connecting-to-elasticsearch)
    - [Via cURL](#via-curl)
- [Basic Operations](#basic-operations)
  - [Indices](#indices)
  - [Documents](#documents)
- [Queries](#queries)
  - [Match Queries](#match-queries)
  - [Boolean Queries](#boolean-queries)
  - [Range Queries](#range-queries)
- [Aggregations](#aggregations)
- [Index Management](#index-management)
  - [Aliases](#aliases)
  - [Mappings](#mappings)

## Installation

### Using Docker
```bash
docker run -d --name elasticsearch -p 9200:9200 -e "discovery.type=single-node" elasticsearch:8.9.0
```
### Manual Installation (Linux)
```bash
# Download and install Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.0-linux-x86_64.tar.gz
tar -xzf elasticsearch-8.9.0-linux-x86_64.tar.gz
cd elasticsearch-8.9.0/

# Start Elasticsearch
./bin/elasticsearch
```

# Connecting to Elasticsearch

### Via cURL

```bash
curl -X GET "localhost:9200"
```

# Basic Operations

## Indices
```bash
# Create an index
curl -X PUT "localhost:9200/my_index"

# List all indices
curl -X GET "localhost:9200/_cat/indices?v"

# Get index details
curl -X GET "localhost:9200/my_index"

# Delete an index
curl -X DELETE "localhost:9200/my_index"
```

## Documents
```bash
# Index a document (automatically assigns an ID)
curl -X POST "localhost:9200/my_index/_doc/" -H 'Content-Type: application/json' -d'
{
  "name": "Alice",
  "age": 25,
  "occupation": "Engineer"
}'

# Index a document with a specific ID
curl -X PUT "localhost:9200/my_index/_doc/1" -H 'Content-Type: application/json' -d'
{
  "name": "Bob",
  "age": 30,
  "occupation": "Designer"
}'

# Retrieve a document by ID
curl -X GET "localhost:9200/my_index/_doc/1"

# Update a document by ID
curl -X POST "localhost:9200/my_index/_update/1" -H 'Content-Type: application/json' -d'
{
  "doc": {
    "age": 31
  }
}'

# Delete a document by ID
curl -X DELETE "localhost:9200/my_index/_doc/1"
```

# Queries

## Match Queries
```bash
# Match all documents
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}'

# Match documents by field
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "occupation": "Engineer"
    }
  }
}'
```

## Boolean Queries
```bash
# Combine multiple queries with boolean operators
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "bool": {
      "must": [
        { "match": { "occupation": "Engineer" } },
        { "range": { "age": { "gte": 25 } } }
      ]
    }
  }
}'
```



## Range Queries
```bash
# Query with range conditions
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "query": {
    "range": {
      "age": {
        "gte": 25,
        "lte": 35
      }
    }
  }
}'
```



# Aggregations
```bash
# Perform aggregation to get average age
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "size": 0,
  "aggs": {
    "average_age": {
      "avg": {
        "field": "age"
      }
    }
  }
}'

# Perform terms aggregation
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "size": 0,
  "aggs": {
    "by_occupation": {
      "terms": {
        "field": "occupation.keyword"
      }
    }
  }
}'
```


# Index Management

## Aliases
```bash
# Create an alias for an index
curl -X POST "localhost:9200/_aliases" -H 'Content-Type: application/json' -d'
{
  "actions": [
    { "add": { "index": "my_index", "alias": "my_alias" } }
  ]
}'

# List aliases
curl -X GET "localhost:9200/_cat/aliases?v"

# Delete an alias
curl -X POST "localhost:9200/_aliases" -H 'Content-Type: application/json' -d'
{
  "actions": [
    { "remove": { "index": "my_index", "alias": "my_alias" } }
  ]
}'
```



## Mappings
```bash
# Define mappings for a new index
curl -X PUT "localhost:9200/my_index" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "name": { "type": "text" },
      "age": { "type": "integer" },
      "occupation": { "type": "keyword" }
    }
  }
}'
```