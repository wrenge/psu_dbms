-- ~77 ms
CREATE OR REPLACE VIEW GroupsCategoriesIssuedBooks
AS
SELECT Group_name, Category_name, Issue_date
FROM Issues
         INNER JOIN Readers R2 on Issues.Reader_id = R2.Reader_id
         INNER JOIN Instance I on Issues.Instance_id = I.Instance_id
         INNER JOIN Books B on I.Book_id = B.Book_id
         INNER JOIN Groups G on R2.Group_id = G.Group_id
         INNER JOIN subject S on B.subject_id = S.subject_id
         INNER JOIN category C ON S.category_id = C.category_id