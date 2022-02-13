namespace UniLibrary.Entities
{
    public class BookingStatus
    {
        public BookingStatus()
        {
            Bookings = new HashSet<Booking>();
        }

        public int StatusId { get; set; }
        public string StatusName { get; set; } = null!;

        public virtual ICollection<Booking> Bookings { get; set; }
    }
}
