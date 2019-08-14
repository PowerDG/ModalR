using System.ComponentModel.DataAnnotations;
using Abp.Application.Services.Dto;
using ResearchService.Host.Web;

namespace BookService.Host.Dtos
{
    public class PagedInputDto : IPagedResultRequest
    {
        [Range(1, ResearchServiceConsts.MaxPageSize)]
        public int MaxResultCount { get; set; }

        [Range(0, int.MaxValue)]
        public int SkipCount { get; set; }

        public PagedInputDto()
        {
            MaxResultCount = ResearchServiceConsts.DefaultPageSize;
        }
    }
}