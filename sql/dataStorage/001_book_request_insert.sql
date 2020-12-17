create or replace procedure insert_book_request(in_request_quantity int,
                                                in_request_cost money,
                                                in_request_date timestamp,
                                                in_category_id int,
                                                in_author_id int,
                                                in_subject_id int,
                                                in_publisher_id int,
                                                in_book_name varchar)
as
$$
declare
    datetime_id int;
    book_id     int;
begin
    insert into date_time(date_time_value) values (in_request_date) returning id_date_time into datetime_id;
    book_id := (select id_book_name from book_name b where book_name = in_book_name limit 1);
    insert into book_request_fact(request_count, request_cost, id_date_time, id_category, id_author, id_subject,
                                  id_publisher, id_book_name)
    VALUES (in_request_quantity,
            in_request_cost,
            datetime_id,
            in_category_id,
            in_author_id,
            in_subject_id,
            in_publisher_id,
            book_id);
    return;
end;
$$ language plpgsql
