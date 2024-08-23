-- query one
SELECT title, genre, sale_price
FROM books_by_genre
GROUP BY genre;
-- query two
SELECT author
FROM books_by_author
GROUP BY author;