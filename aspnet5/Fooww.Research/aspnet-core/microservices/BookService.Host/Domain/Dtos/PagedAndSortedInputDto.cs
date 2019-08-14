using Abp.Application.Services.Dto;
using ResearchService.Host.Web;

namespace BookService.Host.Dtos
{
    public class PagedAndSortedInputDto : PagedInputDto, ISortedResultRequest
    {
        public string Sorting { get; set; }

        public PagedAndSortedInputDto()
        {
            MaxResultCount = ResearchServiceConsts.DefaultPageSize;
        }
    }
}