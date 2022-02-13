namespace UniLibrary.Entities
{
    public class Reader
    {
        public Reader()
        {
            Bookings = new HashSet<Booking>();
            Issues = new HashSet<Issue>();
        }

        public int ReaderId { get; set; }
        public string ReaderSurname { get; set; } = null!;
        public string ReaderName { get; set; } = null!;
        public string? ReaderPatronymic { get; set; }
        public int? GroupId { get; set; }
        public int ClassId { get; set; }
        public DateTime RegistrationDate { get; set; }
        public DateTime? ExclusionDate { get; set; }

        public virtual Class Class { get; set; } = null!;
        public virtual Group? Group { get; set; }
        public virtual ICollection<Booking> Bookings { get; set; }
        public virtual ICollection<Issue> Issues { get; set; }
    }
}
