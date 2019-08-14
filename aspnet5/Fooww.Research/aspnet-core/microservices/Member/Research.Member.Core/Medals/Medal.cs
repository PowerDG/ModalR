using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member
{ 
        public class Medal : Entity<uint>, IFullAudited, IPassivable
    {
        public new uint Id { get; set; }
        public string Icon { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public uint Count { get; set; }
        public bool? IsDiscard { get; set; }

        public uint Grade { get; set; }

        #region IFullAudited    +   IPassivable


        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }
        public long? DeleterUserId { get; set; }
        public DateTime? DeletionTime { get; set; }
        public bool IsDeleted { get; set; }

        public bool IsActive { get; set; }

        #endregion
    }
}
