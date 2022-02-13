namespace UniLibrary.Entities
{
    public class Issue
    {
        public int IssueId { get; set; }
        public int ReaderId { get; set; }
        public int InstanceId { get; set; }
        public DateTime IssueDate { get; set; }
        public DateTime? ReceiveDate { get; set; }
        public DateTime ReturnDate { get; set; }

        public virtual Instance Instance { get; set; } = null!;
        public virtual Reader Reader { get; set; } = null!;
    }
}
