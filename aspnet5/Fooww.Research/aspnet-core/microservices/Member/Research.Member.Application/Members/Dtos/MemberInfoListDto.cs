using System;
using Abp.Application.Services.Dto;
using Abp.Domain.Entities.Auditing;
using System.ComponentModel.DataAnnotations;
using Research.Member.Members;

namespace Research.Member.Members.Dtos
{
    public class MemberInfoListDto : EntityDto<long>, IFullAudited
    {
        /// <summary>
        /// Id
        /// </summary>
        public long? Id { get; set; }

        /// <summary>
        /// UserName
        /// </summary>
        [MaxLength(50, ErrorMessage = "UserName超出最大长度")]
        [MinLength(8, ErrorMessage = "UserName小于最小长度")]
        public string UserName { get; set; }

        /// <summary>
        /// Name
        /// </summary>
        [MaxLength(50, ErrorMessage = "Name超出最大长度")]
        [MinLength(8, ErrorMessage = "Name小于最小长度")]
        [Required(ErrorMessage = "Name不能为空")]
        public string Name { get; set; }

        /// <summary>
        /// Photo
        /// </summary>
        public string Photo { get; set; }

        /// <summary>
        /// PhotoHd
        /// </summary>
        public string PhotoHd { get; set; }

        /// <summary>
        /// ArtPhoto
        /// </summary>
        public string ArtPhoto { get; set; }

        /// <summary>
        /// Gender
        /// </summary>
        public bool Gender { get; set; }

        /// <summary>
        /// Phone
        /// </summary>
        public string Phone { get; set; }

        /// <summary>
        /// Qq
        /// </summary>
        public string Qq { get; set; }

        /// <summary>
        /// WeChat
        /// </summary>
        public string WeChat { get; set; }

        /// <summary>
        /// EntryTime
        /// </summary>
        [Required(ErrorMessage = "EntryTime不能为空")]
        public DateTime EntryTime { get; set; }

        /// <summary>
        /// Title
        /// </summary>
        [Required(ErrorMessage = "Title不能为空")]
        public string Title { get; set; }

        /// <summary>
        /// BirthDay
        /// </summary>
        [Required(ErrorMessage = "BirthDay不能为空")]
        public DateTime? BirthDay { get; set; }

        /// <summary>
        /// Remarks
        /// </summary>
        public string Remarks { get; set; }

        /// <summary>
        /// TotalIntegral
        /// </summary>
        public uint TotalIntegral { get; set; }

        /// <summary>
        /// LeaveTime
        /// </summary>
        public DateTime? LeaveTime { get; set; }

        /// <summary>
        /// Surname
        /// </summary>
        [Required(ErrorMessage = "Surname不能为空")]
        public string Surname { get; set; }

        /// <summary>
        /// Motto
        /// </summary>
        public string Motto { get; set; }

        /// <summary>
        /// LikeCount
        /// </summary>
        public uint LikeCount { get; set; }

        /// <summary>
        /// DislikeCount
        /// </summary>
        public uint DislikeCount { get; set; }

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

        /// <summary>
        /// LastModificationTime
        /// </summary>
        public DateTime? LastModificationTime { get; set; }

        /// <summary>
        /// DeleterUserId
        /// </summary>
        public long? DeleterUserId { get; set; }

        /// <summary>
        /// DeletionTime
        /// </summary>
        public DateTime? DeletionTime { get; set; }

        /// <summary>
        /// IsDeleted
        /// </summary>
        public bool IsDeleted { get; set; }

        /// <summary>
        /// IsActive
        /// </summary>
        public bool IsActive { get; set; }
    }
}