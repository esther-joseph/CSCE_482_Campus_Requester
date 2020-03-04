using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Net.Http;
using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace godTierCapstoneASP.Models
{
    public class CustomLoginModel
    {
        /// <summary>
        /// the unique user id created by our database.
        /// </summary>
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        /// <summary>
        /// The user's email address. This may not be unique and is not suitable for use as a primary key. Provided only if your scope included the string "email".
        /// </summary>
        public string email { get; set; }

        /// <summary>
        /// The user's full name, in a displayable form. Might be provided when:
        /// The request scope included the string "profile"
        /// The ID token is returned from a token refresh
        /// When name claims are present, you can use them to update your app's user records. Note that this claim is never guaranteed to be present.
        /// </summary>
        public string username { get; set; }

        public string password { get; set; }

        /// <summary>
        /// The JWT authorization token. not stored in the database.
        /// </summary>
        [NotMapped]
        public string jwtToken { get; set; }
    }

    public class CustomLoginContext : DbContext
    {
        public DbSet<CustomLoginModel> Users { get; set; }

        public CustomLoginContext(DbContextOptions<CustomLoginContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CustomLoginModel>().HasKey(p => p.id);
            modelBuilder.Entity<CustomLoginModel>().ToTable("CustomUsers");
        }
    }
}
