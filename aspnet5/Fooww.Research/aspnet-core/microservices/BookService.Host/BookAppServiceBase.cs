using Abp.Application.Services;
using Abp.Runtime.Session;
using BookService.Host;
using Microsoft.AspNetCore.Http;
using ResearchService.Host.Web;

namespace BookService.Host
{
    /// <summary>
    /// Derive your application services from this class.
    /// </summary>
    public abstract class BookAppServiceBase : ApplicationService
    {
        protected IHttpContextAccessor m_accessor;

        protected BookAppServiceBase()
        {
            LocalizationSourceName = ResearchServiceConsts.LocalizationSourceName;
        }
    }
}