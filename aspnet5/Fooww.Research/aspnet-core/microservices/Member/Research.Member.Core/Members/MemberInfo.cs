using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Research.Member.Members
{
    public class MemberInfo : Entity<long>, IFullAudited, IPassivable
    {
        [Column("id")]
        public new long Id { get; set; }

        [Column("user_name")]
        public string UserName { get; set; }

        [Column("name")]
        public string Name { get; set; }

        [Column("photo")]
        public string Photo { get; set; }

        [Column("photo_hd")]
        public string PhotoHd { get; set; }

        [Column("art_photo")]
        public string ArtPhoto { get; set; }

        [Column("gender")]
        public bool Gender { get; set; }

        [Column("phone")]
        public string Phone { get; set; }

        [Column("qq")]
        public string Qq { get; set; }

        [Column("we_chat")]
        public string WeChat { get; set; }

        [Column("entry_time")]
        public DateTime EntryTime { get; set; }

        [Column("title")]
        public string Title { get; set; }

        [Column("birth_day")]
        public DateTime? BirthDay { get; set; }

        [Column("remarks")]
        public string Remarks { get; set; }

        [Column("total_integral")]
        public uint TotalIntegral { get; set; }

        [Column("leave_time")]
        public DateTime? LeaveTime { get; set; }

        [Column("alias_name")]
        public string Surname { get; set; }

        [Column("motto")]
        public string Motto { get; set; }

        [Column("like_count")]
        public uint LikeCount { get; set; }

        [Column("dislike_count")]
        public uint DislikeCount { get; set; }

        #region IFullAudited    +   IPassivable

        [Column("creator_user_id")]
        public long? CreatorUserId { get; set; }

        [Column("create_time")]
        public DateTime CreationTime { get; set; }

        [Column("last_modifier_user_id")]
        public long? LastModifierUserId { get; set; }

        [Column("modified_time")]
        public DateTime? LastModificationTime { get; set; }

        [Column("deleter_user_id")]
        public long? DeleterUserId { get; set; }

        [Column("deleted_time")]
        public DateTime? DeletionTime { get; set; }

        [Column("is_deleted")]
        public bool IsDeleted { get; set; }

        [Column("is_active")]
        public bool IsActive { get; set; }

        #endregion IFullAudited    +   IPassivable
    }
}