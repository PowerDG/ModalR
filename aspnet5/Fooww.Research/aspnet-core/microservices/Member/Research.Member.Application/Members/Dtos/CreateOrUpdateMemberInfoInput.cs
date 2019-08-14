

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Research.Member.Members;

namespace Research.Member.Members.Dtos
{
    public class CreateOrUpdateMemberInfoInput
    {
        [Required]
        public MemberInfoEditDto MemberInfo { get; set; }

    }
}