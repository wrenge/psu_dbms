namespace UniLibrary.Entities
{
    public class Category
    {
        public Category()
        {
            Books = new HashSet<Book>();
        }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; } = null!;

        public virtual ICollection<Book> Books { get; set; }
    }
}
