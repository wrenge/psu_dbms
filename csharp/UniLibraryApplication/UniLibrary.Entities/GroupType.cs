namespace UniLibrary.Entities
{
    public class GroupType
    {
        public GroupType()
        {
            Groups = new HashSet<Group>();
        }

        public int TypeId { get; set; }
        public string TypeName { get; set; } = null!;

        public virtual ICollection<Group> Groups { get; set; }
    }
}
