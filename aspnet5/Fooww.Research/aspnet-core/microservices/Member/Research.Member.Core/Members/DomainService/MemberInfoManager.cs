using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.Threading.Tasks;
using Abp.Linq;
using Abp.Linq.Extensions;
using Abp.Extensions;
using Abp.UI;
using Abp.Domain.Repositories;
using Abp.Domain.Services;

using Research.Member;
using Research.Member.Members;

namespace Research.Member.Members.DomainService
{
    /// <summary>
    /// MemberInfo领域层的业务管理
    ///</summary>
    public class MemberInfoManager : MemberDomainServiceBase, IMemberInfoManager
    {
        private readonly IRepository<MemberInfo, long> _repository;

        /// <summary>
        /// MemberInfo的构造方法
        ///</summary>
        public MemberInfoManager(
            IRepository<MemberInfo, long> repository
        )
        {
            _repository = repository;
        }

        /// <summary>
        /// 初始化
        ///</summary>
        public void InitMemberInfo()
        {
            throw new NotImplementedException();
        }

        // TODO:编写领域业务代码
    }
}