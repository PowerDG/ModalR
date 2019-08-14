using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.Members
{
    public class Gift : Entity<uint>, IAudited, IPassivable
    {
        public new uint Id { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
        public string Hyperlink { get; set; }
        public uint MemberId { get; set; }

        #region Auditing

        public bool IsActive { get; set; }

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }

        #endregion Auditing
    }
}