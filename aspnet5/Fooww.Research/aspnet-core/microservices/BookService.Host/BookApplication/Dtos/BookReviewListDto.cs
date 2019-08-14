using System;
using Abp.Application.Services.Dto;
using Abp.Domain.Entities.Auditing;
using System.ComponentModel.DataAnnotations;
using BookService.Host.Domain;
using Abp.Domain.Entities;
using Abp.AutoMapper;

namespace BookService.Host.Domain.Dtos
{
    [AutoMap(typeof(BookReview))]
    public class BookReviewListDto : EntityDto<uint>, IAudited
    {
        /// <summary>
        /// Id
        /// </summary>
        public uint? Id { get; set; }

        /// <summary>
        /// 书号
        /// </summary>
        public uint BookId { get; set; }

        /// <summary>
        /// 评论
        /// </summary>
        public string Review { get; set; }

        /// <summary>
        /// 评分
        /// </summary>
        public decimal Score { get; set; }

        /// <summary>
        /// 激活状态
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// CreatorUserId
        /// </summary>
        public long? CreatorUserId { get; set; }

        public string MemberName { get; set; }

        /// <summary>
        /// CreationTime
        /// </summary>
        public DateTime CreationTime { get; set; }

        /// <summary>
        /// LastModifierUserId
        /// </summary>
        public long? LastModifierUserId { get; set; }

        /// <summary>
        /// LastModificationTime
        /// </summary>
        public DateTime? LastModificationTime { get; set; }
    }
}