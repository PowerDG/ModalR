using Abp.AspNetCore.Mvc.Controllers;
using Abp.Runtime.Session;
using Abp.Web.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using ResearchService.Host.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

using ResearchService.Host.Web;

using Microsoft.AspNetCore.Http;

namespace BookService.Host.Controllers
{
    [Route("api/[Controller]")]

    //[Authorize]
    public class TestController : AbpController

    {
        private readonly IAbpSession _session;

        private IHttpContextAccessor _accessor;

        public TestController(
            IHttpContextAccessor accessor)
        {
            _accessor = accessor;
            _session = NullAbpSession.Instance;
        }

        [HttpGet]
        //[AuthAttributeFilter]
        public IActionResult Get()
        {
            string name = this.User.Identity.Name;//读取的就是"Name"这个特殊的 Claims 的值
            string userId = this.User.FindFirst("UserId").Value;
            string realName = this.User.FindFirst("RealName").Value;
            string email = this.User.FindFirst("Email").Value;
            var result = $"name={name},userId={userId},realName={realName},email={email}";
            Console.WriteLine(result);

            return Ok("ok" + result);
        }

        [HttpGet("Check")]
        //[HttpPost("api/")]
        public string Checker()
        {
            var response = HttpHelper.Get("Fooww.Research.Web.Host", "api/services/app/Permission/GetGrantedAllPermissionsAsync?userId=1");
            var ajaxResponse = JsonConvert.DeserializeObject<AjaxResponse>(response.Result);
            var permissionDtos =
                JsonConvert.DeserializeObject<List<PermissionDto>>(ajaxResponse.Result.ToString());

            return permissionDtos[0].DisplayName;
        }

        [HttpPost("test2")]
        [AuthAttributeFilter(permissionName = PermissionNames.Pages_BookInfo)]
        public object PostP2()
        {
            var ov = "asd ";
            var c = HttpContext.Request.Headers;
            return ov + GetCurrentUserId();
        }

        [HttpPost("test22")]
        //[HttpPost("api/")]
        [AuthAttributeFilter(permissionName = "errorName")]
        public object Post22()
        {
            var ov = "asd ";
            var c = HttpContext.Request.Headers;
            return ov + GetCurrentUserId();
        }

        [HttpPost("test2c")]
        //[HttpPost("api/")]
        [AuthAttributeFilter(permissionName = PermissionNames.Green_Channel)]
        public object PostPCC()
        {
            var c = HttpContext.Request.Headers;
            return "You Have Green_Channel" + GetCurrentUserId();
        }

        [HttpGet("userId")]
        [Authorize]
        [AuthAttributeFilter(permissionName = PermissionNames.Green_Channel)]
        public string GetCurrentUserId()
        {
            string auth = _accessor.HttpContext.Request.Headers["Authorization"];
            var token = JwtDecodeHelper.JWTDecoder(auth);
            var userToekn = JsonConvert.DeserializeObject<dynamic>(token);
            return userToekn.sub;
            //string userId = this.User?.FindFirst("sub").Value ?? "0";
        }

        [HttpPost("Authenticate1")]
        [AuthAttributeFilter(permissionName = PermissionNames.Green_Channel)]
        public string Post()
        {
            var ov = "asd ";
            return ov;
        }

        [HttpPost("Authenticate2")]
        //[HttpPost("api/")]
        [AuthAttributeFilter(permissionName = "CA")]
        public string Post2()
        {
            var ov = "asd ";
            return ov;
        }
    }
}