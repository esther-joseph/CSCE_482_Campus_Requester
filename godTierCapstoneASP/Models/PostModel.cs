using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace godTierCapstoneASP.Models
{
    public class Post
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        public string details { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public DateTime creationTime { get; set; }

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public bool isOpen { get; set; }
    }

    public class PostContext : DbContext
    {
        public DbSet<Post> Posts { get; set; }
        public PostContext(DbContextOptions<PostContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>().HasKey(p => p.id);
            modelBuilder.Entity<Post>().ToTable("Posts");
        }
    }
}
