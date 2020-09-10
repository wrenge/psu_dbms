CREATE FUNCTION increase_book_count() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE books
    SET count = count + cnt
    FROM (SELECT book_id, COUNT(*) AS cnt
          FROM OLD I1
                   INNER JOIN instance I2 ON I1.instance_id = I2.instance_id
          WHERE I1.receive_date IS NULL
          GROUP BY book_id) t
             INNER JOIN books B ON B.book_id = t.book_id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increase_book_count
    AFTER DELETE OR UPDATE
    ON issues
    FOR EACH ROW
EXECUTE PROCEDURE increase_book_count();