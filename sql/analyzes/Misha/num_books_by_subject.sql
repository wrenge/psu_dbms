SELECT Subject_name, Count(*) as Num_books
FROM Instance
         INNER JOIN Books B on Instance.Book_id = B.Book_id
         INNER JOIN Subject S on B.Subject_id = S.Subject_id
WHERE S.Subject_id IS NOT NULL
GROUP BY S.Subject_name
