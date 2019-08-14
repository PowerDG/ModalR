using System;
using System.ComponentModel.DataAnnotations;
using Abp.AutoMapper;
using Abp.Domain.Entities.Auditing;
using BookService.Host.Domain;
using ResearchService.Host.Web;

namespace BookService.Host.Domain.Dtos
{
    [AutoMap(typeof(Book))]
    public class BookNameEditDto
    {
        public uint? Id { get; set; }

        /// <summary>
        /// 书名
        /// </summary>
        public string Name { get; set; }
    }

    [AutoMap(typeof(Book))]
    public class BookReportLossDto
    {
        public uint? Id { get; set; }

        /// <summary>
        /// 书名
        /// </summary>
        public string Reason { get; set; }
    }

    [AutoMap(typeof(Book))]
    public class BookBriefEditDto
    {
        public uint? Id { get; set; }
    }

    [AutoMap(typeof(Book))]
    public class BookEditDto
    {
        /// <summary>
        /// Id
        /// </summary>
        public uint? Id { get; set; }

        /// <summary>
        /// 书名
        /// </summary>
        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
        public string Name { get; set; }

        /// <summary>
        /// 作者
        /// </summary>
        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
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
        /// 书籍来源
        /// </summary>
        ///
        [MaxLength(ResearchServiceConsts.MaxTitleSize)]
        public string Resource { get; set; }
    }
}