using Abp.Application.Services.Dto;

namespace PartyService.Host.Models.PageDto
{
    public class PagedAndSortedInputDto : PagedInputDto, ISortedResultRequest
    {
        public string Sorting { get; set; }
    }
}