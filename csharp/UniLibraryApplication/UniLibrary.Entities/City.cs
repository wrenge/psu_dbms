namespace UniLibrary.Entities
{
    public class City
    {
        public City()
        {
            Publishers = new HashSet<Publisher>();
        }

        public int CityId { get; set; }
        public string CityName { get; set; } = null!;

        public virtual ICollection<Publisher> Publishers { get; set; }
    }
}
