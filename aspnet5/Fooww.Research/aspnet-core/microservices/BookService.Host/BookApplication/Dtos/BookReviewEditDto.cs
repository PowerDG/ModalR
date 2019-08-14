using System;
using System.ComponentModel.DataAnnotations;
using Abp.AutoMapper;
using Abp.Domain.Entities.Auditing;
using BookService.Host.Domain;
using ResearchService.Host.Web;

namespace BookService.Host.Domain.Dtos
{
    [AutoMap(typeof(BookReview))]
    public class BookReviewEditDto
    {
        /// <summary>
        /// Id
        /// </summary>
        public uint? Id { get; set; }

        /// <summary>
        /// 书号
        /// </summary>
        ///
        [Required(ErrorMessage = " 图书Id不能为空")]
        public uint BookId { get; set; }

        /// <summary>
        /// 评论
        /// </summary>
        ///
        [MaxLength(ResearchServiceConsts.MaxFiledSize)]
        [Required(ErrorMessage = " 评论不能为空")]
        public string Review { get; set; }

        /// <summary>
        /// 评分
        /// </summary>
        ///
        [Required(ErrorMessage = "评分不能为空")]
        public decimal Score { get; set; }

        /// <summary>
        /// 激活状态
        /// </summary>
        //public bool IsActive { get; set; }
    }
}