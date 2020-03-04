using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using godTierCapstoneASP.Models;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System.Security.Claims;


namespace godTierCapstoneASP.Controllers
{
    public class HomeController : Controller
    {
        private IConfiguration _configuration;

        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public ActionResult Index()
        {
            ViewData["GoogleClientId"] = _configuration.GetConnectionString("GoogleClientId");
            //string userIdString = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            //ViewData["User"] = userIdString;
            return View();
        }

        public ActionResult Models()
        {
            return View();
        }

        public ActionResult ApiCalls()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public ActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
