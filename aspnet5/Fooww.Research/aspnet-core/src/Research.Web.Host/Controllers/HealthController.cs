using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Research.Controllers;
using Microsoft.AspNetCore.Mvc;

namespace Research.Web.Host.Controllers
{
    [Route("api/[Controller]")]
    public class HealthController : ResearchControllerBase
    {
        [HttpGet]
        public string Get()
        {
            return "200";
        }
    }
}
