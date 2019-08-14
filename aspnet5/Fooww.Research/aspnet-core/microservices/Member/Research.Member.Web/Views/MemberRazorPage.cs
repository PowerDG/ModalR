using Abp.AspNetCore.Mvc.Views;

namespace Research.Member.Web.Views
{
    public abstract class MemberRazorPage<TModel> : AbpRazorPage<TModel>
    {
        protected MemberRazorPage()
        {
            LocalizationSourceName = MemberConsts.LocalizationSourceName;
        }
    }
}
