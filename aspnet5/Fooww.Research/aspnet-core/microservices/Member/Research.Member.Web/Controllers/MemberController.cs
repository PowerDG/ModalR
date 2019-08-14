using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Research.Member.Web.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    public class MemberController : MemberControllerBase
    {
        public MemberController()
        {
        } 
        [HttpGet("api/Login")]
        public async Task<JsonResult> Login() 
        {
            var dict = new SortedDictionary<string, object>();
                dict.Add("Well", "");
            return Json(dict);
        }
    }
}