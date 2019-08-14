using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BookService.Host.Domain
{
    [Table("book_review")]
    public class BookReview : Entity<uint>, IHasCreationTime, IPassivable, IHasModificationTime
    {
        public BookReview()
        {
            CreationTime = DateTime.Now;
            LastModificationTime = DateTime.Now;
        }

        [Column("id")]
        public new uint Id { get; set; }

        [Column("book_id")]
        public uint BookId { get; set; }

        [MaxLength(ResearchServiceConsts.MaxFiledSize)]
        [Column("review", TypeName = "VARCHAR(254)")]
        public string Review { get; set; }

        [Column("score")]
        public uint Score { get; set; }

        #region Auditing

        [Column("is_active")]
        public bool IsActive { get; set; }

        [Column("creator_user_id")]
        public long? CreatorUserId { get; set; }

        [Column("create_time")]
        public DateTime CreationTime { get; set; }

        [Column("last_modifier_user_id")]
        public long? LastModifierUserId { get; set; }

        [Column("modified_time")]
        public DateTime? LastModificationTime { get; set; }

        #endregion Auditing
    }
}