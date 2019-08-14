using Abp.Application.Services;

namespace Research.Member
{
    /// <summary>
    /// Derive your application services from this class.
    /// </summary>
    public abstract class MemberAppServiceBase : ApplicationService
    {
        protected MemberAppServiceBase()
        {
            LocalizationSourceName = MemberConsts.LocalizationSourceName;
        }
    }
}