create or replace procedure insert_booking_fact(in_status_id int,
                                              in_publisher_id int,
                                              in_subject_id int,
                                              in_author_id int,
                                              in_book_name varchar,
                                              in_datetime timestamp,
                                              in_category_id int,
                                              group_id int)
as
$$
declare
    datetime_id int;
    book_id     int;
begin
    insert into date_time(date_time_value) values (in_datetime) returning id_date_time into datetime_id;
    book_id := (select id_book_name from book_name b where book_name = in_book_name limit 1);
    insert into booking_fact(id_booking_status, id_publisher, id_subject, id_author, id_book_name,
                             id_date_time, id_category, id_group)
    VALUES (nullif(in_status_id, -1),
            in_publisher_id,
            in_subject_id,
            in_author_id,
            book_id,
            datetime_id,
            in_category_id,
            group_id);
    return;
end;
$$ language plpgsql
