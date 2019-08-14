namespace PartyService.Host.Models.PageDto
{
    public class PagedSortedAndFilteredInputDto : PagedAndSortedInputDto
    {
        public string FilterText { get; set; }
    }
}