using Microsoft.AspNetCore.Mvc;

namespace Research.Member.Web.Controllers
{
    public class HomeController : MemberControllerBase
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}