namespace UniLibrary.Entities
{
    public class Faculty
    {
        public Faculty()
        {
            Groups = new HashSet<Group>();
        }

        public int FacultyId { get; set; }
        public string FacultyName { get; set; } = null!;
        public string FacultyAcronym { get; set; } = null!;

        public virtual ICollection<Group> Groups { get; set; }
    }
}
