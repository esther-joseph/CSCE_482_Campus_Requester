using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authentication.Google;
using System.Net.Http;
using System.Net;
using System.Text.Json;
using System.Text.Json.Serialization;
using godTierCapstoneASP.Models;
using Microsoft.Extensions.Configuration;

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
        public JsonResult VerifyUser(string idToken)
        {
            
            // Create an HttpClientHandler object and set to use default credentials
            HttpClientHandler handler = new HttpClientHandler();
            handler.UseDefaultCredentials = true;

            // Create an HttpClient object
            HttpClient httpClient = new HttpClient(handler);

            var requestUri = new Uri(string.Format(_configuration.GetConnectionString("GoogleApiToken"), idToken));

            HttpResponseMessage httpResponseMessage;
            try
            {
                httpResponseMessage = httpClient.GetAsync(requestUri).Result;
            }
            catch (Exception ex)
            {
                return null;
            }

            if (httpResponseMessage.StatusCode != HttpStatusCode.OK)
            {
                return null;
            }

            var response = httpResponseMessage.Content.ReadAsStringAsync().Result;
            
            LoginModel userInfo = JsonSerializer.Deserialize<LoginModel>(response);

            if (userInfo.aud == _configuration["Authentication:Google:ClientId"])
                return Json(userInfo);
            else return null;
            /*
            if (!SupportedClientsIds.Contains(googleApiTokenInfo.aud))
            {
                Log.WarnFormat("Google API Token Info aud field ({0}) not containing the required client id", googleApiTokenInfo.aud);
                return null;
            }
            */
        }
    }
}