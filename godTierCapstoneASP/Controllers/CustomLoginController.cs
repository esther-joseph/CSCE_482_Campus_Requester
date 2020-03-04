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
    public class CustomLoginController : Controller
    {
        //private LoginContext _context;
        private readonly CustomLoginContext _context;

        public static IConfiguration _configuration;

        public CustomLoginController(CustomLoginContext context)
        {
            _context = context;
        }

        [HttpPost]
        public async Task<IActionResult> SignIn(string username, string password)
        {
            if (String.IsNullOrWhiteSpace(username) || String.IsNullOrWhiteSpace(password))
                return BadRequest();

            CustomLoginModel user = await _context.Users.FirstOrDefaultAsync(x => x.username == username && x.password == password);

            if (user != null)
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(_configuration.GetConnectionString("GoogleClientSecret"));

                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[]
                    {
                    new Claim(ClaimTypes.Name, user.username),
                    new Claim(ClaimTypes.Email, user.email),
                    new Claim(ClaimTypes.NameIdentifier, user.id.ToString()),
                }),
                    Expires = DateTime.UtcNow.AddDays(30),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)

                };
                var token = tokenHandler.CreateToken(tokenDescriptor);
                user.jwtToken = tokenHandler.WriteToken(token);
                return Ok(user);
            }
            else
            {
                return BadRequest("Invalid Username or password");
            }
        }

        [Authorize]
        public async Task<IActionResult> SignOut()
        {
            await HttpContext.SignOutAsync();
            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> Register([Bind("username, password, email")] CustomLoginModel user)
        {
            if (ModelState.IsValid)
            {
                bool exists = await _context.Users.AnyAsync(x => x.username == user.username || x.email == user.email);
                if (exists)
                    return BadRequest("duplicate username or email");
                _context.Add(user);
                await _context.SaveChangesAsync();
                return Ok(user.id);
            }
            else
                return BadRequest();
        }
    }
}