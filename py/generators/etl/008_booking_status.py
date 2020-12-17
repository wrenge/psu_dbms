from transfer_data import transfer

transfer("select * from bookingstatus",
         "booking_status(id_booking_status, booking_status_name)")
