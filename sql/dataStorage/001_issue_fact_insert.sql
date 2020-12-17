create or replace procedure insert_issue_fact(in_book_name varchar,
                                              in_author_id int,
                                              in_publisher_id int,
                                              in_category_id int,
                                              in_subject_id int,
                                              in_datetime timestamp,
                                              in_group_id int)
as
$$
declare
    datetime_id int;
    book_id     int;
begin
    insert into date_time(date_time_value) values (in_datetime) returning id_date_time into datetime_id;
    book_id := (select id_book_name from book_name b where book_name = in_book_name limit 1);
    insert into issue_facts(id_book_name, id_author, id_publisher, id_category, id_subject, id_date_time, id_group)
    VALUES (book_id,
            in_author_id,
            in_publisher_id,
            in_category_id,
            in_subject_id,
            datetime_id,
            in_group_id);
    return;
end;
$$ language plpgsql
