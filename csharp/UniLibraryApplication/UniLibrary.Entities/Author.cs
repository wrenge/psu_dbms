namespace UniLibrary.Entities
{
    public class Author
    {
        public Author()
        {
            Books = new HashSet<Book>();
        }

        public int AuthorId { get; set; }
        public string AuthorSurname { get; set; } = null!;
        public string AuthorName { get; set; } = null!;
        public string? AuthorPatronymic { get; set; }

        public virtual ICollection<Book> Books { get; set; }
    }
}
