namespace UniLibrary.Entities
{
    public class Class
    {
        public Class()
        {
            Readers = new HashSet<Reader>();
        }

        public int ClassId { get; set; }
        public string ClassName { get; set; } = null!;

        public virtual ICollection<Reader> Readers { get; set; }
    }
}
