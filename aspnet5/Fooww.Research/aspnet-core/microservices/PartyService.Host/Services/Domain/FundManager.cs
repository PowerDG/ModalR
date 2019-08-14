using Abp.Domain.Repositories;
using PartyService.Host.Models;
using System;

namespace PartyService.Host.Services.Domain
{
    /// <summary>
    /// FundModel领域层的业务管理
    ///</summary>
    public class FundModelManager : DomainServiceBase, IFundManager
    {
        private readonly IRepository<FundModel, int> _repository;

        /// <summary>
        /// FundModel的构造方法
        ///</summary>
        public FundModelManager(
            IRepository<FundModel, int> repository
        )
        {
            _repository = repository;
        }

        /// <summary>
        /// 初始化
        ///</summary>
        public void InitFundModel()
        {
            throw new NotImplementedException();
        }

        // TODO:编写领域业务代码
    }
}