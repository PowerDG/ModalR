using Abp.Domain.Services;

namespace BookService.Host.Domain.DomainService
{
    public interface IBookManager : IDomainService
    {
        /// <summary>
        /// 初始化方法
        ///</summary>
        void InitBook();
    }
}