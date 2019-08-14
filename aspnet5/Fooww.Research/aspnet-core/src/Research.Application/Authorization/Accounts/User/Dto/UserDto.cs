using System;
using System.ComponentModel.DataAnnotations;
using Abp.Application.Services.Dto;
using Abp.Authorization.Users;
using Abp.AutoMapper;
using Research.Authorization.Users;

namespace Research.Users.Dto
{
    [AutoMap(typeof(User))]
    public class UserBriefDto : UserNameDto
    {
        public string Surname { get; set; }
        public string EmailAddress { get; set; }
        public string NormalizedUserName { get; set; }
    }

    [AutoMap(typeof(User))]
    public class UserNameDto
    {
        public long Id { get; set; }

        public string Name { get; set; }
    }

    [AutoMap(typeof(User))]
    public class UserWithoutRoleDto : EntityDto<long>
    {
        [Required(ErrorMessage = "用户名[登录名]不能为空")]
        [StringLength(AbpUserBase.MaxUserNameLength)]
        public string UserName { get; set; }

        [Required(ErrorMessage = "姓名不能为空")]
        [StringLength(AbpUserBase.MaxNameLength)]
        public string Name { get; set; }

        [Required(ErrorMessage = "别名不能为空")]
        [StringLength(AbpUserBase.MaxSurnameLength)]
        public string Surname { get; set; }

        [Required(ErrorMessage = "邮箱地址为空")]
        [EmailAddress]
        [StringLength(AbpUserBase.MaxEmailAddressLength)]
        public string EmailAddress { get; set; }

        public bool IsActive { get; set; }
    }

    [AutoMapFrom(typeof(User))]
    public class UserDto : EntityDto<long>
    {
        [Required(ErrorMessage = "用户名[登录名]不能为空")]
        [StringLength(AbpUserBase.MaxUserNameLength)]
        public string UserName { get; set; }

        [Required(ErrorMessage = "姓名不能为空")]
        [StringLength(AbpUserBase.MaxNameLength)]
        public string Name { get; set; }

        [Required(ErrorMessage = "别名不能为空")]
        [StringLength(AbpUserBase.MaxSurnameLength)]
        public string Surname { get; set; }

        [Required(ErrorMessage = "邮箱地址为空")]
        [EmailAddress]
        [StringLength(AbpUserBase.MaxEmailAddressLength)]
        public string EmailAddress { get; set; }

        public bool IsActive { get; set; }

        public string FullName { get; set; }

        public DateTime? LastLoginTime { get; set; }

        public DateTime CreationTime { get; set; }

        public string[] RoleNames { get; set; }
    }
}