using System;
using System.ComponentModel.DataAnnotations;
using Abp.Domain.Entities.Auditing;
using Research.Member.Members;

namespace Research.Member.Members.Dtos
{
    public class MemberInfoEditDto
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
        /// Surname
        /// </summary>
        [Required(ErrorMessage = "Surname不能为空")]
        public string Surname { get; set; }

        /// <summary>
        /// Motto
        /// </summary>
        public string Motto { get; set; }
    }

    public class MemberInfoCreateDto
    {
        public string Password { get; set; }

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
        /// Surname
        /// </summary>
        [Required(ErrorMessage = "Surname不能为空")]
        public string Surname { get; set; }

        /// <summary>
        /// Motto
        /// </summary>
        public string Motto { get; set; }
    }
}