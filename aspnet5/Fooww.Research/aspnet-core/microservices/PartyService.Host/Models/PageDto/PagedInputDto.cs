using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace PartyService.Host.Models.PageDto
{
    public class PagedInputDto : IPagedResultRequest
    {
        [Range(1, PartyServiceHostConsts.MaxPageSize)]
        public int MaxResultCount { get; set; }

        [Range(0, int.MaxValue)]
        public int SkipCount { get; set; }

        public PagedInputDto()
        {
            MaxResultCount = PartyServiceHostConsts.DefaultPageSize;
        }
    }
}