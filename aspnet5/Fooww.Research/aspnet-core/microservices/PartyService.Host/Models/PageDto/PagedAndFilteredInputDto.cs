using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace PartyService.Host.Models.PageDto
{
    public class PagedAndFilteredInputDto : IPagedResultRequest
    {
        [Range(1, PartyServiceHostConsts.MaxPageSize)]
        public int MaxResultCount { get; set; }

        [Range(0, int.MaxValue)]
        public int SkipCount { get; set; }

        public string FilterText { get; set; }

        public PagedAndFilteredInputDto()
        {
            MaxResultCount = PartyServiceHostConsts.DefaultPageSize;
        }
    }
}