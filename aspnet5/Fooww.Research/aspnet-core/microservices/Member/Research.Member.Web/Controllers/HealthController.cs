using Microsoft.AspNetCore.Mvc;

namespace Research.Member.Web.Controllers
{
    public class HealthController : MemberControllerBase
    {
        [HttpGet("api/health")]
        public string Get()
        {
            return "200";
        }
    }
}