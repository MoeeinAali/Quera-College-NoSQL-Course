-- create address UDT here
CREATE TYPE address (
    street text,
    city text,
    state text,
    zip int
);

-- create customers table here
CREATE TABLE customers (
   customer_id UUID,  
   name text,
   email text,
   addresses list<frozen<address>>, 
   contact tuple<text, text>,
   order_ids set<UUID>,
   last_order_date timestamp,
   PRIMARY KEY ((customer_id), last_order_date)
) WITH CLUSTERING ORDER BY (last_order_date DESC);