

using System;
using System.Threading.Tasks;
using Abp;
using Abp.Domain.Services;
using Research.Member.Members;


namespace Research.Member.Members.DomainService
{
    public interface IMemberInfoManager : IDomainService
    {

        /// <summary>
        /// 初始化方法
        ///</summary>
        void InitMemberInfo();



		 
      
         

    }
}
