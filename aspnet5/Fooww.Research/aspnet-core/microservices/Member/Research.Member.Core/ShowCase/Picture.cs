using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.ShowCase
{
    public class Picture : Entity<uint>, IFullAudited, IPassivable
    { 
        public new uint Id { get; set; }
        public string Url { get; set; }
        public string PartialPictureUrl { get; set; }
        public string Description { get; set; }

        #region IFullAudited    &   IPassivable

        public bool IsActive { get; set; }

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }
        public long? DeleterUserId { get; set; }
        public DateTime? DeletionTime { get; set; }
        public bool IsDeleted { get; set; }


        #endregion
    }
}
