using Microsoft.AspNetCore.Mvc;

namespace ID4Service.Host.Controllers
{
    [Route("api/[Controller]")]
    public class HealthController : Controller
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok("ok");
        }
    }
}