using Abp.Domain.Services;
using ResearchService.Host.Web;

namespace BookService.Host
{
    public abstract class BookDomainServiceBase : DomainService
    {
        protected BookDomainServiceBase()
        {
            LocalizationSourceName = ResearchServiceConsts.LocalizationSourceName;
        }
    }
}