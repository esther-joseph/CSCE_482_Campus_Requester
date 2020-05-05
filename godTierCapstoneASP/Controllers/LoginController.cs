using System;
using Microsoft.AspNetCore.Mvc;
using godTierCapstoneASP.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authorization;

namespace godTierCapstoneASP.Controllers
{
    public class LoginController : Controller
    {
        //private LoginContext _context;
        private readonly LoginContext _context;

        public static IConfiguration _configuration;

        public LoginController(LoginContext context)
        {
            _context = context;
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(string idToken)
        {
            if (String.IsNullOrWhiteSpace(idToken))
                return BadRequest("id token is null or empty");

            LoginModel user = await LoginModel.verifyGoogleIdToken(idToken, _configuration.GetConnectionString("GoogleClientId"), _configuration.GetConnectionString("GoogleApiToken"));

            if (user != null)
            {
                LoginModel newUser = await _context.Users.FirstOrDefaultAsync(m => m.sub == user.sub);
                if(newUser == null)
                {
                    _context.Users.Add(user);
                    await _context.SaveChangesAsync();
                    newUser = await _context.Users.FirstOrDefaultAsync(m => m.sub == user.sub);
                }

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(_configuration.GetConnectionString("GoogleClientSecret"));

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                    new Claim(ClaimTypes.Name, newUser.name),
                    new Claim(ClaimTypes.Email, newUser.email),
                    new Claim(ClaimTypes.NameIdentifier, newUser.id.ToString()),
                    new Claim("picture", newUser.picture)
                }),
                    Expires = DateTime.UtcNow.AddDays(30),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)

                };
                var token = tokenHandler.CreateToken(tokenDescriptor);
                newUser.jwtToken = tokenHandler.WriteToken(token);
                return Ok(newUser);
            }
            else
            {
                return BadRequest("Google returned null. IdToken recieved: " + idToken);
            }
        }

        [Authorize]
        public async Task<IActionResult> SignOut()
        {
            await HttpContext.SignOutAsync();
            return Ok();
        }
    }
}
