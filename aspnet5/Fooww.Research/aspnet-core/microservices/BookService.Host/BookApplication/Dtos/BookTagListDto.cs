

using System;
using Abp.Application.Services.Dto;
using Abp.Domain.Entities.Auditing;
using System.ComponentModel.DataAnnotations;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class BookTagListDto : EntityDto<uint>,ICreationAudited,IDeletionAudited  
    {

        
		/// <summary>
		/// Id
		/// </summary>
		public uint? Id { get; set; }



		/// <summary>
		/// BookId
		/// </summary>
		public uint BookId { get; set; }



		/// <summary>
		/// TagId
		/// </summary>
		public uint TagId { get; set; }



		/// <summary>
		/// Tag名
		/// </summary>
		public string TagName { get; set; }



		/// <summary>
		/// 简介
		/// </summary>
		public string Description { get; set; }



		/// <summary>
		/// ReviewId
		/// </summary>
		public uint ReviewId { get; set; }



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
		/// IsDeleted
		/// </summary>
		public bool IsDeleted { get; set; }



		/// <summary>
		/// DeleterUserId
		/// </summary>
		public long? DeleterUserId { get; set; }



		/// <summary>
		/// DeletionTime
		/// </summary>
		public DateTime? DeletionTime { get; set; }




    }
}