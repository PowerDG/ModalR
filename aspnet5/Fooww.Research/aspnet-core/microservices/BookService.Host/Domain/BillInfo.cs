using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Abp.Domain.Entities;
using Abp.Domain.Entities.Auditing;

using System;
using System.Collections.Generic;

using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;
using Abp.AutoMapper;
using Abp.Application.Services.Dto;

namespace BookService.Host.Domain
{
    [AutoMap(typeof(BillInfo))]
    public class BillInfoDto : EntityDto<long>
    {
        public new long? Id { get; set; }
        public int BillNo { get; set; }

        [DefaultValue(false)]
        public bool IsCandidate { get; set; }

        [DefaultValue(1)]
        public int Version { get; set; }

        public string SendBranchID { get; set; }

        [DefaultValue(false)]
        public bool BillCheck { get; set; }

        public int BillStateID { get; set; }

        public string TOTAL_CHARGES { get; set; }

        public string BillImgUrl { get; set; }
    }

    public class BillInfo : Entity<long>, ICreationAudited, IDeletionAudited, IModificationAudited
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]  //取消主键自增长，否则出现显示主键inseret 出错
        public override long Id { get; set; }

        public int BillNo { get; set; }

        [DefaultValue(false)]
        public bool IsCandidate { get; set; }

        [DefaultValue(1)]
        public int Version { get; set; }

        public string SendBranchID { get; set; }

        [DefaultValue(false)]
        public bool BillCheck { get; set; }

        public int BillStateID { get; set; }

        public string TOTAL_CHARGES { get; set; }

        public string BillImgUrl { get; set; }

        #region 系统软判断

        public long? CreatorUserId { get; set; }
        public DateTime CreationTime { get; set; }
        public long? DeleterUserId { get; set; }
        public DateTime? DeletionTime { get; set; }
        public bool IsDeleted { get; set; }
        public long? LastModifierUserId { get; set; }
        public DateTime? LastModificationTime { get; set; }

        #endregion 系统软判断

        public void UpBillCheckToTrue()
        {
            BillCheck = true;
        }

        public void UpVersion()
        {
            Version = Version + 1;
        }

        public void ChangeIsCandidate()
        {
            IsCandidate = true;
        }
    }
}