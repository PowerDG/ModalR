

using System;
using System.Threading.Tasks;
using Abp;
using Abp.Domain.Services;
using BookService.Host.Domain;


namespace BookService.Host.Domain.DomainService
{
    public interface IBookReviewManager : IDomainService
    {

        /// <summary>
        /// 初始化方法
        ///</summary>
        void InitBookReview();



		 
      
         

    }
}
