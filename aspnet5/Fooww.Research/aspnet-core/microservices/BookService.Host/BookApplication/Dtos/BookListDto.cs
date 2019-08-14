using System;
using Abp.Application.Services.Dto;
using Abp.Domain.Entities.Auditing;
using System.ComponentModel.DataAnnotations;
using BookService.Host.Domain;
using Abp.AutoMapper;

//using AutoMapper;

namespace BookService.Host.Domain.Dtos
{
    [AutoMap(typeof(Book))]
    public class BookListDto : EntityDto<uint>
    {
        /// <summary>
        /// Id
        /// </summary>
        public uint? Id { get; set; }

        /// <summary>
        /// 书名
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 作者
        /// </summary>
        public string Author { get; set; }

        /// <summary>
        /// 缩略图
        /// </summary>
        public string Photo { get; set; }

        /// <summary>
        /// 高清图
        /// </summary>
        public string PhotoHd { get; set; }

        /// <summary>
        /// 加入时间
        /// </summary>
        public DateTime EntryTime { get; set; }

        /// <summary>
        /// 平均分
        /// </summary>
        public decimal AverageScore { get; set; }

        /// <summary>
        /// 书籍来源
        /// </summary>
        public string Resource { get; set; }

        /// <summary>
        /// 借阅成员
        /// </summary>
        public long? MemberId { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public byte State { get; set; }

        /// <summary>
        /// 最后评论
        /// </summary>
        public string LastBookReview { get; set; }

        /// <summary>
        /// 激活状态
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// CreatorUserId
        /// </summary>
        public long? CreatorUserId { get; set; }

        /// <summary>
        /// CreationTime
        /// </summary>
        public DateTime CreationTime { get; set; }

        /// <summary>
        /// LastModifierUserId
        /// </summary>
        public long? LastModifierUserId { get; set; }

        public string MemberName { get; set; }

        /// <summary>
        /// LastModificationTime
        /// </summary>
        public DateTime? LastModificationTime { get; set; }
    }
}