using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;

namespace Research.Member.Members
{
    public class TitleChange : Entity<uint>, ICreationAudited, IPassivable
    {
        public new uint Id { get; set; }
        public uint MemberId { get; set; }
        public string OldTitle { get; set; }
        public string NewTitle { get; set; }

        #region Auditing

        public bool IsActive { get; set; }

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }

        #endregion Auditing
    }
}