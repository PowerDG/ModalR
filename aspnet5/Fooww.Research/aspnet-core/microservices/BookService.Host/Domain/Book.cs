using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;
using ResearchService.Host.Web;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BookService.Host.Domain
{
    [Table("book")]
    public class Book : Entity<uint>, IHasCreationTime, IPassivable, IHasModificationTime
    {
        public Book()
        {
            CreationTime = DateTime.Now;

            NumberOfBookReview = 0;
            AverageScore = 0.00M;
            EntryTime = DateTime.Now;
            LastModificationTime = DateTime.Now;
            LastModifierUserId = ResearchServiceConsts.DefaultBorrowBookMemberId;
        }

        [Column("id")]
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public new uint? Id { get; set; }

        [DisplayName("书籍名称"), Required]
        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
        [Column("name", TypeName = "VARCHAR(64)")]
        public string Name { get; set; }

        [Column("member_id")]
        public long? MemberId { get; set; }

        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
        [Column("author", TypeName = "VARCHAR(64)")]
        public string Author { get; set; }

        [Column("photo")]
        public string Photo { get; set; }

        [Column("photo_hd")]
        public string PhotoHd { get; set; }

        [Column("entry_time")]
        public DateTime EntryTime { get; set; }

        [Column("average_score")]
        public decimal AverageScore { get; set; }

        [Column("number_of_book_review")]
        public uint NumberOfBookReview { get; set; }

        [DisplayName("书籍来源")]
        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
        [Column("resource", TypeName = "VARCHAR(64)")]
        public string Resource { get; set; }

        [Column("state")]
        public byte State { get; set; }

        [MaxLength(ResearchServiceConsts.MaxFiledSize)]
        [Column("last_book_review", TypeName = "VARCHAR(254)")]
        public string LastBookReview { get; set; }

        public void BorrowBooks()
        {
            State = ResearchServiceConsts.IsBorrowedBook;
            NumberOfBookReview++;
        }

        public void ReturnBooks()
        {
            State = ResearchServiceConsts.IsCanBorrowBook;
            MemberId = ResearchServiceConsts.DefaultBorrowBookMemberId;
        }

        public void RemoveOfReportLoss()
        {
            State = ResearchServiceConsts.IsCanBorrowBook;

            MemberId = ResearchServiceConsts.DefaultBorrowBookMemberId;
        }

        public void ReportLoss()
        {
            State = ResearchServiceConsts.IsLostBook;
            MemberId = ResearchServiceConsts.DefaultBorrowBookMemberId;
        }

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