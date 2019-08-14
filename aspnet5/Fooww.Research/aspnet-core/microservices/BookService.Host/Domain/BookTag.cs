using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace BookService.Host.Domain
{
    public class BookTag : Entity<uint>, ICreationAudited, IDeletionAudited, IPassivable
    {
        [Column("id")]
        public new uint Id { get; set; }

        [Column("book_id")]
        public uint BookId { get; set; }

        [Column("tag_id")]
        public uint TagId { get; set; }

        [Column("tag_name")]
        public string TagName { get; set; }

        [Column("description")]
        public string Description { get; set; }

        [Column("review_id")]
        public uint ReviewId { get; set; }

        #region Auditing

        [Column("is_active")]
        public bool IsActive { get; set; }

        [Column("creator_user_id")]
        public long? CreatorUserId { get; set; }

        [Column("create_time")]
        public DateTime CreationTime { get; set; }

        [Column("is_deleted")]
        public bool IsDeleted { get; set; }

        [Column("deleter_user_id")]
        public long? DeleterUserId { get; set; }

        [Column("deleted_time")]
        public DateTime? DeletionTime { get; set; }

        #endregion Auditing
    }
}