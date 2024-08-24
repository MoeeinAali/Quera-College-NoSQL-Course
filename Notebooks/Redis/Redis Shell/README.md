## Table of Contents
- [Table of Contents](#table-of-contents)
- [Connection](#connection)
- [Keys](#keys)
- [Strings](#strings)
- [Hashes](#hashes)
- [Lists](#lists)
- [Sets](#sets)
- [Sorted Sets (ZSets)](#sorted-sets-zsets)
- [Transactions](#transactions)
- [Pub/Sub](#pubsub)
- [Server](#server)
- [Other Commands](#other-commands)

## Connection
```bash
redis-server          # Start Redis server
redis-cli             # Start Redis CLI
redis-cli -h <host> -p <port>  # Connect to a remote Redis server
```
## Keys
```bash
SET key value         # Set key to hold the string value
GET key               # Get the value of key
DEL key               # Delete a key
EXISTS key            # Check if a key exists
EXPIRE key seconds    # Set a timeout on key
TTL key               # Get the time to live for a key
KEYS pattern          # Find all keys matching the given pattern
RENAME oldkey newkey  # Rename a key
TYPE key              # Determine the type of the value stored at key
```
## Strings
```bash
SET key value            # Set key to hold the string value
GET key                  # Get the value of key
INCR key                 # Increment the integer value of key by one
DECR key                 # Decrement the integer value of key by one
APPEND key value         # Append a value to a key
MGET key1 key2           # Get the values of all the given keys
SETEX key seconds value  # Set the value and expiration of a key
```

## Hashes
```bash
HSET key field value                   # Set the value of a hash field
HGET key field                         # Get the value of a hash field
HGETALL key                            # Get all the fields and values in a hash
HMSET key field1 value1 field2 value2  # Set multiple fields at once
HMGET key field1 field2                # Get the values of multiple hash fields
HDEL key field                         # Delete a hash field
HLEN key                               # Get the number of fields in a hash
HEXISTS key field                      # Determine if a hash field exists
```

## Lists
```bash
LPUSH key value       # Prepend a value to a list
RPUSH key value       # Append a value to a list
LPOP key              # Remove and get the first element in a list
RPOP key              # Remove and get the last element in a list
LRANGE key start stop # Get a range of elements from a list
LLEN key              # Get the length of a list
LREM key count value  # Remove elements from a list
LINDEX key index      # Get an element from a list by its index
LTRIM key start stop  # Trim a list to the specified range
```

## Sets
```bash
SADD key member       # Add a member to a set
SREM key member       # Remove a member from a set
SMEMBERS key          # Get all the members in a set
SISMEMBER key member  # Determine if a given value is a member of a set
SCARD key             # Get the number of members in a set
SINTER key1 key2      # Intersect multiple sets
SUNION key1 key2      # Add multiple sets
SDIFF key1 key2       # Subtract multiple sets
```

## Sorted Sets (ZSets)
```bash
ZADD key score member      # Add a member to a sorted set with a score
ZRANGE key start stop      # Return a range of members in a sorted set by index
ZREM key member            # Remove a member from a sorted set
ZRANGEBYSCORE key min max  # Return a range of members in a sorted set by score
ZSCORE key member          # Get the score associated with the given member
ZCARD key                  # Get the number of members in a sorted set
ZCOUNT key min max         # Count the members in a sorted set with scores within the given values

```

## Transactions
```bash
MULTI                  # Start a transaction
EXEC                   # Execute all commands issued after MULTI
DISCARD                # Discard all commands issued after MULTI
WATCH key              # Watch a key for changes before executing a transaction
UNWATCH                # Forget about all watched keys
```

## Pub/Sub
```bash
PUBLISH channel message  # Post a message to a channel
SUBSCRIBE channel        # Subscribe to a channel
UNSUBSCRIBE channel      # Unsubscribe from a channel
PSUBSCRIBE pattern       # Subscribe to channels matching a pattern
PUNSUBSCRIBE pattern     # Unsubscribe from channels matching a pattern
```

## Server
```bash
INFO                        # Get information and statistics about the server
CONFIG GET parameter        # Get the value of a configuration parameter
CONFIG SET parameter value  # Set a configuration parameter
MONITOR                     # Listen for all requests received by the server in real-time
SLOWLOG GET                 # Get the Redis slow queries log
FLUSHDB                     # Remove all keys from the current database
FLUSHALL                    # Remove all keys from all databases
SAVE                        # Synchronously save the dataset to disk
BGSAVE                      # Asynchronously save the dataset to disk
SHUTDOWN                    # Synchronously save the dataset to disk and then shut down the server
```

## Other Commands
```bash
PING                    # Test connection to the server
ECHO message            # Echo the given message
SELECT index            # Change the selected database for the current connection
DBSIZE                  # Return the number of keys in the selected database
RANDOMKEY               # Return a random key from the currently selected database
LASTSAVE                # Get the UNIX timestamp of the last successful save to disk
```