namespace UniLibrary.Entities
{
    public class Book
    {
        public Book()
        {
            Bookings = new HashSet<Booking>();
            Instances = new HashSet<Instance>();
            Requests = new HashSet<Request>();
        }

        public int BookId { get; set; }
        public string BookName { get; set; } = null!;
        public int? AuthorId { get; set; }
        public int PublisherId { get; set; }
        public int? SubjectId { get; set; }
        public int CategoryId { get; set; }
        public int Count { get; set; }
        public int TotalCount { get; set; }

        public virtual Author? Author { get; set; }
        public virtual Category Category { get; set; } = null!;
        public virtual Publisher Publisher { get; set; } = null!;
        public virtual Subject? Subject { get; set; }
        public virtual ICollection<Booking> Bookings { get; set; }
        public virtual ICollection<Instance> Instances { get; set; }
        public virtual ICollection<Request> Requests { get; set; }
    }
}
