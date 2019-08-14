using Abp.Runtime.Validation;
using BookService.Host.Dtos;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class GetBooksInput : PagedSortedAndFilteredInputDto, IShouldNormalize
    {
        /// <summary>
        /// 正常化排序使用
        /// </summary>
        ///
        public string QueryType { get; set; }

        public void Normalize()
        {
            if (string.IsNullOrEmpty(Sorting))
            {
                Sorting = "Id";
            }
        }
    }
}