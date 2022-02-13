namespace UniLibrary.Entities
{
    public class Request
    {
        public int RequestId { get; set; }
        public int BookId { get; set; }
        public decimal RequestCost { get; set; }
        public int RequestQuantity { get; set; }
        public DateTime RequestDate { get; set; }

        public virtual Book Book { get; set; } = null!;
    }
}
