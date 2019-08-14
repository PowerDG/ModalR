using Abp.Auditing;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Research.Member.Members.Dtos
{
    internal class CreateUserUserNameInfoInput
    {
    }

    public class CreateUserWithRoleInput : CreateUserInput
    {
        public string[] RoleNames { get; set; }
    }

    public class CreateUserWithSingleRoleInput : CreateUserInput
    {
        public string RoleNames { get; set; }
    }

    public class CreateUserInput
    {
        [Required]
        public string UserName { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Surname { get; set; }

        [Required]
        [EmailAddress]
        public string EmailAddress { get; set; }

        [Required]
        [DisableAuditing]
        public string Password { get; set; }

        public bool IsActive { get; set; }
    }
}