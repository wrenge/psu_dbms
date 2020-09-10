CREATE FUNCTION increase_total_book_count() RETURNS TRIGGER AS
$$
BEGIN
    UPDATE books
    SET count       = count + cnt,
        total_count = total_count + cnt
    FROM (SELECT book_id, COUNT(*) as cnt
          FROM NEW I1
          GROUP BY book_id) t
             INNER JOIN books B ON B.book_id = t.book_id;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increase_total_book_count
    AFTER INSERT OR UPDATE
    ON instance
    FOR EACH ROW
EXECUTE PROCEDURE increase_total_book_count();