using Abp.Domain.Services;

namespace PartyService.Host.Services.Domain
{
    public interface IFundManager : IDomainService
    {
        /// <summary>
        /// 初始化方法
        ///</summary>
        void InitFundModel();
    }
}