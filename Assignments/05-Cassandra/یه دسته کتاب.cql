BEGIN BATCH
    INSERT INTO book (book_id, title, author, pub_year) VALUES (1f6aeb16-4e05-4c1a-9a4c-3d13ebcc1a0a, 'Just for fun', 'younesious', 2001)
    UPDATE book SET pub_year = 2001 WHERE book_id = 1f6aeb16-4e05-4c1a-9a4c-3d13ebcc1a0b
    DELETE FROM book WHERE book_id = 1f6aeb16-4e05-4c1a-9a4c-3d13ebcc1a0c
APPLY BATCH;