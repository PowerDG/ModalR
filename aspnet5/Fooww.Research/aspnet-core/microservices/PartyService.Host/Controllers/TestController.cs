using Abp.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc;
using System;

namespace PartyService.Host.Controllers
{
    [Route("api/[Controller]")]
    public class TestController : AbpController
    {
        [HttpGet]
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
    }
}