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
    public class LoginModel
    {
        /// <summary>
        /// the unique user id created by our database.
        /// </summary>
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }

        /// <summary>
        /// Identifies the audience that this ID token is intended for. It must be one of the OAuth 2.0 client IDs of your application.
        /// Not stored in the database.
        /// </summary>
        [NotMapped]
        public string aud { get; set; }

        /// <summary>
        /// An identifier for the user, unique among all Google accounts and never reused. A Google account can have multiple emails at different points in time, but the sub value is never
        /// changed. Use sub within your application as the unique-identifier key for the user.
        /// </summary>
        public string sub { get; set; }

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
        public string name { get; set; }

        /// <summary>
        /// The URL of the user's profile picture. Might be provided when:
        /// The request scope included the string "profile"
        /// The ID token is returned from a token refresh
        /// When picture claims are present, you can use them to update your app's user records. Note that this claim is never guaranteed to be present.
        /// </summary>
        public string picture { get; set; }

        public string given_name { get; set; }

        public string family_name { get; set; }

        /// <summary>
        /// The JWT authorization token. not stored in the database.
        /// </summary>
        [NotMapped]
        public string jwtToken { get; set; }

        /// <summary>
        /// verifies the given idToken with google.
        /// </summary>
        /// <param name="idToken">the google idToken</param>
        /// <param name="clientId">registered client id from google developer's console</param>
        /// <param name="connectionString">connection string for sql server</param>
        /// <returns>A Login Model if the verification is successful. Null otherwise</returns>
        public static async Task<LoginModel> verifyGoogleIdToken(string idToken, string clientId, string connectionString)
        {
            // Create an HttpClientHandler object and set to use default credentials
            HttpClientHandler handler = new HttpClientHandler();
            handler.UseDefaultCredentials = true;

            // Create an HttpClient object
            HttpClient httpClient = new HttpClient(handler);

            var requestUri = new Uri(string.Format(connectionString, idToken));

            HttpResponseMessage httpResponseMessage;
            try
            {
                httpResponseMessage = httpClient.GetAsync(requestUri).Result;
            }
            catch (Exception)
            {
                return null;
            }

            if (httpResponseMessage.StatusCode != HttpStatusCode.OK)
            {
                return null;
            }

            var response = await httpResponseMessage.Content.ReadAsStringAsync();


            LoginModel userInfo = JsonSerializer.Deserialize<LoginModel>(response);

            if (userInfo.aud == clientId)
                return userInfo;
            else return null;
        }
    }

    public class LoginContext : DbContext
    {
        public DbSet<LoginModel> Users { get; set; }

        public LoginContext(DbContextOptions<LoginContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<LoginModel>().HasKey(p => p.id);
            modelBuilder.Entity<LoginModel>().ToTable("Users");
        }
    }
}
