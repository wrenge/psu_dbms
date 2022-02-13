namespace UniLibrary.Entities
{
    public class Instance
    {
        public Instance()
        {
            Issues = new HashSet<Issue>();
        }

        public int InstanceId { get; set; }
        public int BookId { get; set; }
        public int CopyCondition { get; set; }
        public int CopyYear { get; set; }

        public virtual Book Book { get; set; } = null!;
        public virtual ICollection<Issue> Issues { get; set; }
    }
}
