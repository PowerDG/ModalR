using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;

namespace Research.Member.Members
{
    public class Memberlabel : Entity<uint>, IAudited
    {
        public new uint Id { get; set; }
        public uint MemberId { get; set; }
        public string Label { get; set; }
        public uint Count { get; set; }

        #region Auditing

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }

        #endregion Auditing
    }
}