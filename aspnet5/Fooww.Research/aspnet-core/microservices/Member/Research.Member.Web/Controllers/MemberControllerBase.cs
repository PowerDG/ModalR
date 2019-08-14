using Abp.AspNetCore.Mvc.Controllers;

namespace Research.Member.Web.Controllers
{
    public abstract class MemberControllerBase: AbpController
    {
        protected MemberControllerBase()
        {
            LocalizationSourceName = MemberConsts.LocalizationSourceName;
        }
    }
}