select category_name, faculty_acronym, extract(years from issue_date) as issue_year, count(*) as issue_count
from issues i
         inner join readers r on r.reader_id = i.reader_id
         inner join groups g on g.group_id = r.group_id
         inner join faculties f on f.faculty_id = g.faculty_id
         inner join instance i2 on i2.instance_id = i.instance_id
         inner join books b on b.book_id = i2.book_id
         inner join subject s on b.subject_id = s.subject_id
         inner join category c on s.category_id = c.category_id
group by cube (category_name, faculty_acronym, issue_year)
order by issue_year, faculty_acronym, category_name