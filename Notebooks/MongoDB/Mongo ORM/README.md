## Table of Contents
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
- [Connecting to MongoDB](#connecting-to-mongodb)
- [Basic Operations](#basic-operations)
- [Queries](#queries)
- [Updates](#updates)
- [Indexes](#indexes)

## Installation

```bash
pip install pymongo
```

## Connecting to MongoDB

```python
from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://localhost:27017/")

# Access a database
db = client.mydatabase

# Access a collection
collection = db.mycollection
```


## Basic Operations
```python
# Insert a single document
collection.insert_one({"name": "Alice", "age": 25})

# Insert multiple documents
collection.insert_many([
    {"name": "Bob", "age": 30},
    {"name": "Charlie", "age": 35}
])

# Find a single document
doc = collection.find_one({"name": "Alice"})

# Find all documents
docs = collection.find()
for doc in docs:
    print(doc)

# Count documents
count = collection.count_documents({})
```
## Queries
```python
# Find with filters
docs = collection.find({"age": {"$gte": 30}})

# Find with logical operators
docs = collection.find({"$or": [{"name": "Alice"}, {"name": "Bob"}]})
```

## Updates
```python
# Update a single document
collection.update_one({"name": "Alice"}, {"$set": {"age": 26}})

# Update multiple documents
collection.update_many({"age": {"$lt": 30}}, {"$set": {"status": "young"}})

# Replace a document
collection.replace_one({"name": "Bob"}, {"name": "Robert", "age": 31})
```

## Indexes
```python 
# Create an index
collection.create_index([("name", 1)])

# Create a compound index
collection.create_index([("name", 1), ("age", -1)])

# List all indexes
indexes = collection.index_information()

# Drop an index
collection.drop_index("name_1")
```
