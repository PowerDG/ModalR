using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.DataBase;
using ResearchHome.Models;
using ResearchHome.Controllers;
using Microsoft.AspNetCore.Hosting;
using ResearchHome.Helper;
using Microsoft.AspNetCore.Http;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public partial class HomeController : BaseController
    {
        private readonly IConfiguration configuration;
        private readonly IDatabase database;
        private IHostingEnvironment environment;

        public HomeController(IConfiguration configuration, IDatabase database, IHostingEnvironment environment)
        {
            this.configuration = configuration;
            this.database = database;
            this.environment = environment;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult Test()
        {
            return View();
        }

        public IActionResult EditIntroduction()
        {
            var urlPath = $"{environment.WebRootPath}{configuration["Paths:ResearchIntroduction"]}";
            var introductionXmlInfo = XmlHelper.ReadXmlData(urlPath);
            return View(new IntroductionsModel()
            {
                Title = introductionXmlInfo.Title,
                Content = introductionXmlInfo.Content
            });
        }
        
        [HttpPost]
        public IActionResult EditIntroduction(IntroductionsModel introductionsModel)
        {
            if (!ModelState.IsValid)
            {
                return View(introductionsModel);
            }
            var urlPath = $"{environment.WebRootPath}{configuration["Paths:ResearchIntroduction"]}";
            string errorMsg;
            var result = XmlHelper.WriteXmlData("Introduction", urlPath, introductionsModel, out errorMsg);
            TempData["Message"] = result ? "parent.layer.msg('操作成功!', { icon: 6,shift: -1, time: 500, shade: 0.3 }, function() { parent.layer.closeAll(); })"
                                        : $@"parent.layer.msg('操作失败【{errorMsg}】,请重试！！'," + "{icon: 5,shift: -1, time: 500, shade: 0.3});";
            return View(introductionsModel);
        }
        
        [HttpPost]
        public JsonResult GetIntroductionData()
        {
            var urlPath = $"{environment.WebRootPath}{configuration["Paths:ResearchIntroduction"]}";
            try
            {
                var introductionXmlInfo = XmlHelper.ReadXmlData(urlPath);
                return Json(new IntroductionsModel()
                {
                    Title = introductionXmlInfo.Title,
                    Content = introductionXmlInfo.Content
                });
            }
            catch (System.Exception e)
            {
                return Json(new IntroductionsModel()
                {
                    Title = "梵讯研究院",
                    Content = e.Message
                });
            }
            
            
        }
    }
}
