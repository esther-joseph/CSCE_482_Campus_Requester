using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;


namespace godTierCapstoneASP.Models
{
    public class PostModel
    {
        public PostModel()
        {
            status = PostStatus.Open;
            details = null;
        }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        public string details { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime creationTime { get; set; }

        public int status { get; set; }
    }

    public class PostContext : DbContext
    {
        public DbSet<PostModel> Posts { get; set; }
        public PostContext(DbContextOptions<PostContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PostModel>().HasKey(p => p.id);
            modelBuilder.Entity<PostModel>().ToTable("Posts");
        }
    }

    public class PostStatus
    {
        public static readonly int Open = 0;
        public static readonly int Accepted = 1;
        public static readonly int Completed = 2;
        public static readonly int Expired = 3;
        public static readonly int Deleted = 4;
    }
}
