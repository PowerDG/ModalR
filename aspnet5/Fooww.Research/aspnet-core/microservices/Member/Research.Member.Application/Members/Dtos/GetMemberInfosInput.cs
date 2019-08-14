using Abp.Runtime.Validation;
using Research.Member.Dtos;
using Research.Member.Members;

namespace Research.Member.Members.Dtos
{
    public class GetMemberInfosInput : PagedSortedAndFilteredInputDto, IShouldNormalize
    {
        /// <summary>
        /// 正常化排序使用
        /// </summary>
        public void Normalize()
        {
            if (string.IsNullOrEmpty(Sorting))
            {
                Sorting = "Id";
            }
        }
    }
}