using Microsoft.AspNetCore.Mvc;

namespace ImageService.Host.Controllers
{
    [Route("api/[Controller]")]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public string Get()
        {
            return "200";
        }
    }
}