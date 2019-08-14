using Abp.Domain.Repositories;
using BookService.Host.Domain.Dtos;
using ResearchService.Host.Web;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace BookService.Host.Domain.DomainService
{
    /// <summary>
    /// Book领域层的业务管理
    ///</summary>
    public class BookManager : BookDomainServiceBase, IBookManager
    {
        private readonly IRepository<Book, uint> m_repository;

        /// <summary>
        /// Book的构造方法
        ///</summary>
        public BookManager(
            IRepository<Book, uint> repository
        )
        {
            m_repository = repository;
        }

        /// <summary>
        /// 初始化
        ///</summary>
        public void InitBook()
        {
            throw new NotImplementedException();
        }

        public virtual IQueryable<Book> GetPersonalBooks(IQueryable<Book> query2, GetBooksInput input)
        {
            return m_repository.GetAll().Where(r => r.Resource == "个人图书"); ;
        }

        public virtual IQueryable<Book> GetLibraryBooks(IQueryable<Book> query2, GetBooksInput input)
        {
            return m_repository.GetAll().Where(r => r.Resource != "个人图书"); ;
        }

        public virtual async Task ReturnBooks(uint bookId)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = m_repository.Get(bookId);
            entity.ReturnBooks();
            entity.MemberId = ResearchServiceConsts.DefaultBorrowBookMemberId;

            await m_repository.UpdateAsync(entity);
        }

        // TODO:编写领域业务代码
    }
}