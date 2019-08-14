using Microsoft.AspNetCore.Mvc;

namespace OcelotGateway.Host.Controllers
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