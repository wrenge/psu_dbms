CREATE FUNCTION decrease_total_book_count() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE books
    SET count       = count - cnt,
        total_count = total_count - cnt
    FROM (SELECT book_id, COUNT(*) as cnt
          FROM OLD I1
          GROUP BY book_id) t
             INNER JOIN books B ON B.book_id = t.book_id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER decrease_total_book_count
    AFTER DELETE OR UPDATE
    ON instance
    FOR EACH ROW
EXECUTE PROCEDURE decrease_total_book_count();