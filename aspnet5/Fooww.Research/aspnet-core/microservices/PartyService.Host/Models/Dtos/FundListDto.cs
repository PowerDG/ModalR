using Abp.Application.Services.Dto;
using System;

namespace PartyService.Host.Models.Dtos
{
    public class FundListDto : EntityDto<long>
    {
        public DateTime InsertTime { get; set; }

        public string ItemName { get; set; }

        public decimal OperateMoney { get; set; }

        public decimal RemainMoney { get; set; }

        public string Description { get; set; }

        public string MemberName { get; set; }
    }
}