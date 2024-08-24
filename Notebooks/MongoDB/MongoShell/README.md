## Table of Contents
- [Connecting to MongoDB](#connecting-to-mongodb)
- [Basic Commands](#basic-commands)
  - [Databases](#databases)
  - [Collections](#collections)
  - [Documents](#documents)
- [Queries](#queries)
  - [Filtering](#filtering)
  - [Sorting](#sorting)
  - [Projection](#projection)
- [Updates](#updates)
- [Aggregation](#aggregation)
- [Indexes](#indexes)
- [Backup and Restore](#backup-and-restore)

## Installation
MongoDB can be installed on your system via package managers or downloaded directly from the [MongoDB website](https://www.mongodb.com/try/download/community).

```bash
# Install MongoDB on Ubuntu
sudo apt-get install -y mongodb

# Start MongoDB service
sudo systemctl start mongodb
```

# Connecting to MongoDB
```bash
mongosh
# or connect to a specific database
mongosh "mongodb://localhost:27017/mydatabase"
```

# Basic Commands
## Databases
```bash
# Show all databases
show dbs;

# Create or switch to a database
use mydatabase;

# Drop a database
db.dropDatabase();
```

## Collections
```bash
# Show all collections in the current database
show collections;

# Create a collection
db.createCollection("mycollection");

# Drop a collection
db.mycollection.drop();
```
## Documents
```bash
# Insert a single document
db.mycollection.insertOne({ name: "Alice", age: 25 });

# Insert multiple documents
db.mycollection.insertMany([
  { name: "Bob", age: 30 },
  { name: "Charlie", age: 35 }
]);

# Find a single document
db.mycollection.findOne({ name: "Alice" });

# Find all documents
db.mycollection.find();

# Count documents
db.mycollection.countDocuments();
```
# Queries
## Filtering
```bash
# Basic filtering
db.mycollection.find({ age: 30 });

# Using comparison operators
db.mycollection.find({ age: { $gt: 25 } });  # Greater than
db.mycollection.find({ age: { $gte: 30 } }); # Greater than or equal to
db.mycollection.find({ age: { $lt: 35 } });  # Less than
db.mycollection.find({ age: { $lte: 30 } }); # Less than or equal to
db.mycollection.find({ name: { $ne: "Alice" } }); # Not equal to

# Using logical operators
db.mycollection.find({ $and: [{ age: { $gt: 25 } }, { age: { $lt: 35 } }] });
db.mycollection.find({ $or: [{ name: "Alice" }, { name: "Bob" }] });
```

## Sorting
```bash
# Sort by age in ascending order
db.mycollection.find().sort({ age: 1 });

# Sort by age in descending order
db.mycollection.find().sort({ age: -1 });
```
## Projection
```bash
# Include only specific fields
db.mycollection.find({}, { name: 1, _id: 0 });

# Exclude specific fields
db.mycollection.find({}, { age: 0 });
```

# Updates
```bash
# Update a single document
db.mycollection.updateOne({ name: "Alice" }, { $set: { age: 26 } });

# Update multiple documents
db.mycollection.updateMany({ age: { $lt: 30 } }, { $set: { status: "under 30" } });

# Replace a document
db.mycollection.replaceOne({ name: "Bob" }, { name: "Robert", age: 31 });
```

# Aggregation
```bash
# Basic aggregation pipeline
db.mycollection.aggregate([
  { $match: { age: { $gte: 25 } } },
  { $group: { _id: "$age", count: { $sum: 1 } } },
  { $sort: { count: -1 } }
]);

# More complex example
db.mycollection.aggregate([
  { $match: { status: "under 30" } },
  { $project: { name: 1, age: 1 } },
  { $sort: { age: 1 } }
]);
```

# Indexes
```bash
# Create an index on a field
db.mycollection.createIndex({ name: 1 });

# Create a compound index
db.mycollection.createIndex({ name: 1, age: -1 });

# List all indexes on a collection
db.mycollection.getIndexes();

# Drop an index
db.mycollection.dropIndex("name_1");

```

# Backup and Restore
```bash
# Backup a database
mongodump --db mydatabase --out /path/to/backup

# Restore a database
mongorestore --db mydatabase /path/to/backup/mydatabase

```