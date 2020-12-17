from transfer_data import transfer

transfer("select publisher_id, publisher_name from publisher",
         "publisher(id_publisher, publisher_name) ")
