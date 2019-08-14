using Abp.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc;

namespace PartyService.Host.Controllers
{
    [Route("api/[Controller]")]
    public class HealthController : AbpController
    {
        [HttpGet]
        public string Get()
        {
            return "200";
        }
    }
}