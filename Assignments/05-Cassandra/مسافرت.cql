-- query one
SELECT * FROM trips;
-- query two
SELECT * FROM trips WHERE destination = 'Paris';
-- query three
SELECT id FROM trips WHERE destination = 'London' AND trip_date > '2020-01-01';
-- query four
SELECT destination, trip_date, id, name 
FROM trips 
WHERE destination = 'Aligoodarz' 
AND trip_date >= '2022-11-01' 
AND trip_date <= '2023-11-30' 
ORDER BY trip_date DESC, id ASC;