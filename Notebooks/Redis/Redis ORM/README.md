## Table of Contents
- [Basic Operations](#basic-operations)
  - [Strings](#strings)
  - [Hashes](#hashes)
  - [Lists](#lists)
  - [Sets](#sets)
  - [Sorted Sets (ZSets)](#sorted-sets-zsets)
- [Transactions](#transactions)
- [Pub/Sub](#pubsub)
- [Pipelines](#pipelines)
- [Connection Management](#connection-management)

## Installation
```bash
pip install redis
```

## Connecting to Redis
```python
import redis

# Default connection
r = redis.Redis(host='localhost', port=6379, db=0)

# Connection with URL
r = redis.from_url('redis://localhost:6379/0')

# Test connection
r.ping()  # Returns True if connected
```
# Basic Operations

## Strings
```python
r.set('key', 'value')          # Set a key with a string value
r.get('key')                   # Get the value of a key
r.incr('counter')              # Increment the integer value of a key
r.decr('counter')              # Decrement the integer value of a key
r.append('key', 'more')        # Append a string to the key's value
r.mget(['key1', 'key2'])       # Get values of multiple keys
r.setex('key', 60, 'value')    # Set key with expiration in seconds
```

## Hashes
```python
r.hset('hash_name', 'field', 'value')         # Set the value of a hash field
r.hget('hash_name', 'field')                  # Get the value of a hash field
r.hgetall('hash_name')                        # Get all fields and values of a hash
r.hmset('hash_name', {'field1': 'value1', 'field2': 'value2'})  # Set multiple fields
r.hmget('hash_name', 'field1', 'field2')      # Get values of multiple fields
r.hdel('hash_name', 'field')                  # Delete a field from a hash
r.hlen('hash_name')                           # Get the number of fields in a hash
r.hexists('hash_name', 'field')               # Check if a field exists in a hash
```

## Lists
```python
r.lpush('list', 'value')        # Prepend a value to a list
r.rpush('list', 'value')        # Append a value to a list
r.lpop('list')                  # Remove and get the first element in a list
r.rpop('list')                  # Remove and get the last element in a list
r.lrange('list', 0, -1)         # Get all elements in a list
r.llen('list')                  # Get the length of a list
r.lrem('list', 0, 'value')      # Remove all occurrences of a value from a list
r.lindex('list', 0)             # Get an element by index
r.ltrim('list', 1, -1)          # Trim a list to a specified range
```

## Sets
```python
r.sadd('set_name', 'member')    # Add a member to a set
r.srem('set_name', 'member')    # Remove a member from a set
r.smembers('set_name')          # Get all members in a set
r.sismember('set_name', 'member')  # Check if a value is in a set
r.scard('set_name')             # Get the number of members in a set
r.sinter('set1', 'set2')        # Intersect multiple sets
r.sunion('set1', 'set2')        # Union multiple sets
r.sdiff('set1', 'set2')         # Get the difference between sets
```

## Sorted Sets (ZSets)
```python
r.zadd('zset_name', {'member': 1.0})     # Add a member with a score to a sorted set
r.zrange('zset_name', 0, -1)             # Get members in a range by rank
r.zrem('zset_name', 'member')            # Remove a member from a sorted set
r.zrangebyscore('zset_name', 1, 10)      # Get members in a range by score
r.zscore('zset_name', 'member')          # Get the score of a member
r.zcard('zset_name')                     # Get the number of members in a sorted set
r.zcount('zset_name', 1, 10)             # Count members within a score range
```

# Transactions
```python
with r.pipeline() as pipe:
    pipe.multi()                     # Start a transaction
    pipe.set('key', 'value')
    pipe.incr('counter')
    pipe.execute()                   # Execute the transaction
```

# Pub/Sub
```python
# Publisher
r.publish('channel', 'message')

# Subscriber
pubsub = r.pubsub()
pubsub.subscribe('channel')

for message in pubsub.listen():
    print(message)
```

# Pipelines
```python
pipe = r.pipeline()
pipe.set('key1', 'value1')
pipe.set('key2', 'value2')
pipe.execute()                      # Execute all commands in the pipeline
```

# Connection Management
```python
r.connection_pool.disconnect()      # Disconnect from the Redis server
r.close()                           # Close the connection (same as disconnect)
```