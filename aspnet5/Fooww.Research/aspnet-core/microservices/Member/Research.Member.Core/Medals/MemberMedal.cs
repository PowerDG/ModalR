using Abp.Domain.Entities.Auditing;
using Abp.Domain.Values;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.Medals
{
    public  class MemberMedal : ValueObject<MemberMedal>, ICreationAudited , IDeletionAudited

    {
        public uint Id { get; set; }

        public long  MemberId { get; set; }
        public uint MedalId { get; set; }
        public string Reason { get; set; }
        public DateTime GainDate { get; set; }
        public uint? TaskId { get; set; }
        public uint? GainType { get; set; }


        #region IFullAudited    
         
        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }

        public long? DeleterUserId { get; set; }
        public DateTime? DeletionTime { get; set; }
        public bool IsDeleted { get; set; }

        #endregion
    }
}
