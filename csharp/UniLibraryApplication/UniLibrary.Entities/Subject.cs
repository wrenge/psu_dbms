namespace UniLibrary.Entities
{
    public class Subject
    {
        public Subject()
        {
            Books = new HashSet<Book>();
        }

        public int SubjectId { get; set; }
        public string SubjectName { get; set; } = null!;

        public virtual ICollection<Book> Books { get; set; }
    }
}
