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
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using System.Threading.Tasks;

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
        public async Task<JsonResult> VerifyUser(string idToken)
        {

            LoginModel user = LoginModel.verifyGoogleIdToken(idToken, _configuration["Authentication:Google:ClientId"], _configuration.GetConnectionString("GoogleApiToken"));
            if (user != null)
                user.CreateUser(_configuration.GetConnectionString("DefaultConnection"));

            //Create the identity for the user  
            var identity = new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.Name, user.name),
                    new Claim(ClaimTypes.Email, user.email),
                    new Claim(ClaimTypes.NameIdentifier, user.sub),
                    new Claim("picture", user.picture)
                }, CookieAuthenticationDefaults.AuthenticationScheme);

            var principal = new ClaimsPrincipal(identity);

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);

            //await HttpContext.AuthenticateAsync();

            //HttpContext.User = principal;
            return Json(principal);
            
        }

        public async Task<ActionResult> SignOut()
        {
            await HttpContext.SignOutAsync();
            
           
            return RedirectToAction("Index", "Home");
        }
    }
}
