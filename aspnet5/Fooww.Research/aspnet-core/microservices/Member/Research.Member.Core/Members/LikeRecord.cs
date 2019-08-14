using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.Members
{

    public class LikeRecord : Entity<uint>, IAudited 
    {
        public new uint Id { get; set; }
        //public uint MemberId { get; set; }
        public uint LikeMeMemberId { get; set; }
        //public DateTime LastOperateTime { get; set; }
        public uint OperateType { get; set; }
        //public DateTime? CreateTime { get; set; }
        //public DateTime? ModifiedTime { get; set; }
        #region Auditing 
        //public bool IsActive { get; set; }

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }

        #endregion

    }
}
