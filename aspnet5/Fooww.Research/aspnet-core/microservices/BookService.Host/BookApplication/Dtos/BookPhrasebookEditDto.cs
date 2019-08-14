using System;
using System.ComponentModel.DataAnnotations;
using Abp.Domain.Entities.Auditing;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class BookPhrasebookEditDto
    {
        /// <summary>
        /// Id
        /// </summary>
        public uint? Id { get; set; }

        /// <summary>
        /// BookId
        /// </summary>
        public uint? BookId { get; set; }

        /// <summary>
        /// TagId
        /// </summary>
        public uint? TagId { get; set; }

        /// <summary>
        /// Tag名
        /// </summary>
        public string TagName { get; set; }

        /// <summary>
        /// 常用语
        /// </summary>
        public string Phrase { get; set; }

        /// <summary>
        /// 简介
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 激活状态
        /// </summary>
        public bool IsActive { get; set; }
    }
}