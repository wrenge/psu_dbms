namespace UniLibrary.Entities
{
    public class Booking
    {
        public int BookingId { get; set; }
        public int BookId { get; set; }
        public DateTime EndDate { get; set; }
        public int ReaderId { get; set; }
        public DateTime? CloseDate { get; set; }
        public int? StatusId { get; set; }

        public virtual Book Book { get; set; } = null!;
        public virtual Reader Reader { get; set; } = null!;
        public virtual BookingStatus? Status { get; set; }
    }
}
