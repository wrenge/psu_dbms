namespace UniLibrary.Entities
{
    public class Group
    {
        public Group()
        {
            Readers = new HashSet<Reader>();
        }

        public int GroupId { get; set; }
        public string GroupName { get; set; } = null!;
        public int TypeId { get; set; }
        public int FacultyId { get; set; }

        public virtual Faculty Faculty { get; set; } = null!;
        public virtual GroupType Type { get; set; } = null!;
        public virtual ICollection<Reader> Readers { get; set; }
    }
}
