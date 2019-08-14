using Abp.AspNetCore.Mvc.Controllers;
using Abp.UI;
using Microsoft.AspNetCore.Mvc;

namespace BookService.Host.Controllers
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