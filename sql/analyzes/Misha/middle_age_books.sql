SELECT Book_name, AVG(Copy_year) as average_year, AVG(Copy_condition) as average_condition
FROM Instance INNER JOIN Books B2 on Instance.Book_id = B2.Book_id
GROUP BY Book_name
ORDER BY average_condition DESC, average_year DESC