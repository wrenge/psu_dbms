SELECT Book_name, Books.Count * 100 / Books.Total_count AS percentage
FROM Books
ORDER BY percentage