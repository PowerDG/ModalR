using Abp.Runtime.Validation;
using BookService.Host.Dtos;

namespace BookService.Host.Domain.Dtos
{
    public class GetBookReviewsInput : PagedSortedAndFilteredInputDto, IShouldNormalize
    {
        public uint BookId { get; set; }

        /// <summary>
        /// 正常化排序使用
        /// </summary>
        public void Normalize()
        {
            if (string.IsNullOrEmpty(Sorting))
            {
                Sorting = "Id desc";
            }
        }
    }
}