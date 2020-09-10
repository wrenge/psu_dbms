UPDATE books
SET total_count = cnt
FROM (SELECT book_id, COUNT(*) as cnt
      FROM instance
      GROUP BY book_id) t
         INNER JOIN books B ON B.book_id = t.book_id;

UPDATE books
SET count = B.total_count - cnt
FROM (SELECT book_id, COUNT(*) as cnt
      FROM issues Issues
               INNER JOIN Instance I on Issues.instance_id = I.instance_id
      WHERE Issues.return_date < NOW()
      GROUP BY book_id) t
         INNER JOIN books B ON B.book_id = t.book_id;