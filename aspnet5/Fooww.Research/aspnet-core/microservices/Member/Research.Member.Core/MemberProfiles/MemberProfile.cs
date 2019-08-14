using Abp.Application.Services.Dto;
using Abp.AutoMapper;
using Research.Member.Members;
using System;
using System.Collections.Generic;
using System.Text;

namespace Research.Member.MemberProfiles
{
    [AutoMap(typeof(MemberInfo))]
    public class MemberProfile : EntityDto
    {
        //display picture
        public new uint Id { get; set; }

        public string UserName { get; set; }
        public string Name { get; set; }

        //public string Photo { get; set; }
        //public string PhotoHd { get; set; }
        public string ArtPhoto { get; set; }

        public bool Gender { get; set; }
        public string Phone { get; set; }
        public string Qq { get; set; }
        public string WeChat { get; set; }
        public DateTime EntryTime { get; set; }
        public string Title { get; set; }

        //public DateTime? BirthDay { get; set; }
        //public string Remarks { get; set; }
        public DateTime? LeaveTime { get; set; }

        //public bool? IsLeave { get; set; }
        public string Surname { get; set; }

        public string Motto { get; set; }
    }
}