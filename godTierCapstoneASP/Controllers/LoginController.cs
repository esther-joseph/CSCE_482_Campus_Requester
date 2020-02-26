using System;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Net;
using System.Text.Json;
using godTierCapstoneASP.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.Google;
//using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using System.Security.Claims;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;
using System.IdentityModel.Tokens;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace godTierCapstoneASP.Controllers
{
    public class LoginController : Controller
    {
        private IConfiguration _configuration;
        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> VerifyUser(string idToken)
        {

            LoginModel user = LoginModel.verifyGoogleIdToken(idToken, _configuration["Authentication:Google:ClientId"], _configuration.GetConnectionString("GoogleApiToken"));
            if (user != null)
                user.CreateUser(_configuration.GetConnectionString("DefaultConnection"));

            /*
            //Create the identity for the user  

            var identity = new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.Name, user.name),
                    new Claim(ClaimTypes.Email, user.email),
                    new Claim(ClaimTypes.NameIdentifier, user.sub),
                    new Claim("picture", user.picture)
                //   }, CookieAuthenticationDefaults.AuthenticationScheme);
            }, JwtBearerDefaults.AuthenticationScheme);

            var principal = new ClaimsPrincipal(identity);

            //await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
            await HttpContext.SignInAsync(JwtBearerDefaults.AuthenticationScheme, principal);

            //await HttpContext.AuthenticateAsync();

            //HttpContext.User = principal;
            return Json(principal);
            */
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_configuration["Authentication:Google:ClientSecret"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.name),
                    new Claim(ClaimTypes.Email, user.email),
                    new Claim(ClaimTypes.NameIdentifier, user.sub),
                    new Claim("picture", user.picture)
                }),
                Expires = DateTime.UtcNow.AddDays(30),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)

            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.jwtToken = tokenHandler.WriteToken(token);
            return Ok(user);
        }

        public async Task<ActionResult> SignOut()
        {
            await HttpContext.SignOutAsync();
            
           
            return RedirectToAction("Index", "Home");
        }
    }
}
