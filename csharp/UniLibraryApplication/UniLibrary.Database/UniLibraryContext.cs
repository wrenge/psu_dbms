using Microsoft.EntityFrameworkCore;
using UniLibrary.Entities;

namespace EntityFrameworkTest
{
    public class UniLibraryContext : DbContext
    {
        public UniLibraryContext()
        {
        }

        public UniLibraryContext(DbContextOptions<UniLibraryContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Author> Authors { get; set; } = null!;
        public virtual DbSet<Book> Books { get; set; } = null!;
        public virtual DbSet<Booking> Bookings { get; set; } = null!;
        public virtual DbSet<BookingStatus> BookingStatuses { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<City> Cities { get; set; } = null!;
        public virtual DbSet<Class> Classes { get; set; } = null!;
        public virtual DbSet<Faculty> Faculties { get; set; } = null!;
        public virtual DbSet<Group> Groups { get; set; } = null!;
        public virtual DbSet<GroupType> GroupTypes { get; set; } = null!;
        public virtual DbSet<Instance> Instances { get; set; } = null!;
        public virtual DbSet<Issue> Issues { get; set; } = null!;
        public virtual DbSet<Publisher> Publishers { get; set; } = null!;
        public virtual DbSet<Reader> Readers { get; set; } = null!;
        public virtual DbSet<Request> Requests { get; set; } = null!;
        public virtual DbSet<Subject> Subjects { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=host.docker.internal,1433;Database=uni_library;User ID=sa;Password=Strong@password123");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Author>(entity =>
            {
                entity.ToTable("Author");

                entity.Property(e => e.AuthorId).HasColumnName("Author_id");

                entity.Property(e => e.AuthorName)
                    .HasMaxLength(20)
                    .HasColumnName("Author_name");

                entity.Property(e => e.AuthorPatronymic)
                    .HasMaxLength(20)
                    .HasColumnName("Author_patronymic");

                entity.Property(e => e.AuthorSurname)
                    .HasMaxLength(20)
                    .HasColumnName("Author_surname");
            });

            modelBuilder.Entity<Book>(entity =>
            {
                entity.Property(e => e.BookId).HasColumnName("Book_id");

                entity.Property(e => e.AuthorId).HasColumnName("Author_id");

                entity.Property(e => e.BookName)
                    .HasMaxLength(128)
                    .HasColumnName("Book_name");

                entity.Property(e => e.CategoryId).HasColumnName("Category_id");

                entity.Property(e => e.PublisherId).HasColumnName("Publisher_id");

                entity.Property(e => e.SubjectId).HasColumnName("Subject_id");

                entity.Property(e => e.TotalCount).HasColumnName("Total_count");

                entity.HasOne(d => d.Author)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.AuthorId)
                    .HasConstraintName("R_3");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_7");

                entity.HasOne(d => d.Publisher)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.PublisherId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_4");

                entity.HasOne(d => d.Subject)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.SubjectId)
                    .HasConstraintName("R_6");
            });

            modelBuilder.Entity<Booking>(entity =>
            {
                entity.HasKey(e => new { e.BookingId, e.BookId, e.ReaderId })
                    .HasName("XPKBooking");

                entity.ToTable("Booking");

                entity.Property(e => e.BookingId)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("Booking_id");

                entity.Property(e => e.BookId).HasColumnName("Book_id");

                entity.Property(e => e.ReaderId).HasColumnName("Reader_id");

                entity.Property(e => e.CloseDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Close_date");

                entity.Property(e => e.EndDate)
                    .HasColumnType("datetime")
                    .HasColumnName("End_date");

                entity.Property(e => e.StatusId).HasColumnName("Status_id");

                entity.HasOne(d => d.Book)
                    .WithMany(p => p.Bookings)
                    .HasForeignKey(d => d.BookId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_10");

                entity.HasOne(d => d.Reader)
                    .WithMany(p => p.Bookings)
                    .HasForeignKey(d => d.ReaderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_16");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.Bookings)
                    .HasForeignKey(d => d.StatusId)
                    .HasConstraintName("Booking_BookingStatus_Status_id_fk");
            });

            modelBuilder.Entity<BookingStatus>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("BookingStatus_pk")
                    .IsClustered(false);

                entity.ToTable("BookingStatus");

                entity.Property(e => e.StatusId).HasColumnName("Status_id");

                entity.Property(e => e.StatusName)
                    .HasMaxLength(32)
                    .HasColumnName("Status_name");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");

                entity.Property(e => e.CategoryId).HasColumnName("Category_id");

                entity.Property(e => e.CategoryName)
                    .HasMaxLength(64)
                    .HasColumnName("Category_name");
            });

            modelBuilder.Entity<City>(entity =>
            {
                entity.ToTable("City");

                entity.Property(e => e.CityId).HasColumnName("City_id");

                entity.Property(e => e.CityName)
                    .HasMaxLength(32)
                    .HasColumnName("City_name");
            });

            modelBuilder.Entity<Class>(entity =>
            {
                entity.Property(e => e.ClassId).HasColumnName("Class_id");

                entity.Property(e => e.ClassName)
                    .HasMaxLength(64)
                    .HasColumnName("Class_name");
            });

            modelBuilder.Entity<Faculty>(entity =>
            {
                entity.Property(e => e.FacultyId).HasColumnName("Faculty_id");

                entity.Property(e => e.FacultyAcronym)
                    .HasMaxLength(10)
                    .HasColumnName("Faculty_acronym");

                entity.Property(e => e.FacultyName)
                    .HasMaxLength(128)
                    .HasColumnName("Faculty_name");
            });

            modelBuilder.Entity<Group>(entity =>
            {
                entity.Property(e => e.GroupId).HasColumnName("Group_id");

                entity.Property(e => e.FacultyId).HasColumnName("Faculty_id");

                entity.Property(e => e.GroupName)
                    .HasMaxLength(32)
                    .HasColumnName("Group_name");

                entity.Property(e => e.TypeId).HasColumnName("Type_id");

                entity.HasOne(d => d.Faculty)
                    .WithMany(p => p.Groups)
                    .HasForeignKey(d => d.FacultyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_14");

                entity.HasOne(d => d.Type)
                    .WithMany(p => p.Groups)
                    .HasForeignKey(d => d.TypeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("Groups_GroupType_Type_id_fk");
            });

            modelBuilder.Entity<GroupType>(entity =>
            {
                entity.HasKey(e => e.TypeId)
                    .HasName("GroupType_pk")
                    .IsClustered(false);

                entity.ToTable("GroupType");

                entity.Property(e => e.TypeId).HasColumnName("Type_id");

                entity.Property(e => e.TypeName)
                    .HasMaxLength(64)
                    .HasColumnName("Type_name");
            });

            modelBuilder.Entity<Instance>(entity =>
            {
                entity.ToTable("Instance");

                entity.Property(e => e.InstanceId).HasColumnName("Instance_id");

                entity.Property(e => e.BookId).HasColumnName("Book_id");

                entity.Property(e => e.CopyCondition).HasColumnName("Copy_condition");

                entity.Property(e => e.CopyYear).HasColumnName("Copy_year");

                entity.HasOne(d => d.Book)
                    .WithMany(p => p.Instances)
                    .HasForeignKey(d => d.BookId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_8");
            });

            modelBuilder.Entity<Issue>(entity =>
            {
                entity.HasKey(e => new { e.IssueId, e.ReaderId })
                    .HasName("XPKIssues");

                entity.Property(e => e.IssueId)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("Issue_id");

                entity.Property(e => e.ReaderId).HasColumnName("Reader_id");

                entity.Property(e => e.InstanceId).HasColumnName("Instance_id");

                entity.Property(e => e.IssueDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Issue_date");

                entity.Property(e => e.ReceiveDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Receive_date");

                entity.Property(e => e.ReturnDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Return_date");

                entity.HasOne(d => d.Instance)
                    .WithMany(p => p.Issues)
                    .HasForeignKey(d => d.InstanceId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_17");

                entity.HasOne(d => d.Reader)
                    .WithMany(p => p.Issues)
                    .HasForeignKey(d => d.ReaderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_18");
            });

            modelBuilder.Entity<Publisher>(entity =>
            {
                entity.ToTable("Publisher");

                entity.Property(e => e.PublisherId).HasColumnName("Publisher_id");

                entity.Property(e => e.CityId).HasColumnName("City_id");

                entity.Property(e => e.PublisherName)
                    .HasMaxLength(64)
                    .HasColumnName("Publisher_name");

                entity.HasOne(d => d.City)
                    .WithMany(p => p.Publishers)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_5");
            });

            modelBuilder.Entity<Reader>(entity =>
            {
                entity.Property(e => e.ReaderId).HasColumnName("Reader_id");

                entity.Property(e => e.ClassId).HasColumnName("Class_id");

                entity.Property(e => e.ExclusionDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Exclusion_date");

                entity.Property(e => e.GroupId).HasColumnName("Group_id");

                entity.Property(e => e.ReaderName)
                    .HasMaxLength(20)
                    .HasColumnName("Reader_name");

                entity.Property(e => e.ReaderPatronymic)
                    .HasMaxLength(20)
                    .HasColumnName("Reader_patronymic");

                entity.Property(e => e.ReaderSurname)
                    .HasMaxLength(20)
                    .HasColumnName("Reader_surname");

                entity.Property(e => e.RegistrationDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Registration_date");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.Readers)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_12");

                entity.HasOne(d => d.Group)
                    .WithMany(p => p.Readers)
                    .HasForeignKey(d => d.GroupId)
                    .HasConstraintName("R_13");
            });

            modelBuilder.Entity<Request>(entity =>
            {
                entity.ToTable("Request");

                entity.Property(e => e.RequestId).HasColumnName("Request_id");

                entity.Property(e => e.BookId).HasColumnName("Book_id");

                entity.Property(e => e.RequestCost)
                    .HasColumnType("money")
                    .HasColumnName("Request_cost");

                entity.Property(e => e.RequestDate)
                    .HasColumnType("datetime")
                    .HasColumnName("Request_date");

                entity.Property(e => e.RequestQuantity).HasColumnName("Request_Quantity");

                entity.HasOne(d => d.Book)
                    .WithMany(p => p.Requests)
                    .HasForeignKey(d => d.BookId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("R_9");
            });

            modelBuilder.Entity<Subject>(entity =>
            {
                entity.ToTable("Subject");

                entity.Property(e => e.SubjectId).HasColumnName("Subject_id");

                entity.Property(e => e.SubjectName)
                    .HasMaxLength(32)
                    .HasColumnName("Subject_name");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        private void OnModelCreatingPartial(ModelBuilder modelBuilder)
        {
            throw new NotImplementedException();
        }
    }
}
