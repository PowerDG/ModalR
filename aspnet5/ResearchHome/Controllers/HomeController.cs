using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Models;
using System;
using System.Configuration;
using System.Diagnostics;

namespace ResearchHome.Controllers
{
    public class HomeController : BaseController
    {
        private readonly IConfiguration _configuration;
        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }
        
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        private static string GetConfiguration(string key, string defaultValue)
        {
            string value = defaultValue;
            var configurationValue = ConfigurationManager.AppSettings[key];
            if (!string.IsNullOrEmpty(configurationValue))
            {
                value = configurationValue;
            }
            return value;
        }
    }
}
