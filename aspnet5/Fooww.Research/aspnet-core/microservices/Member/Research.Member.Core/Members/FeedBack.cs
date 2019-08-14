using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.Members
{
    public class FeedBack : Entity<uint>, IAudited
    {
        public new uint Id { get; set; }
        public string Content { get; set; }
        public uint? MemberId { get; set; }
        public uint? ProviderId { get; set; }
        public DateTime CreatedTime { get; set; }
        public string ProviderName { get; set; }

        #region Auditing 
        public bool IsActive { get; set; } 
        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }

        #endregion
    }
}
