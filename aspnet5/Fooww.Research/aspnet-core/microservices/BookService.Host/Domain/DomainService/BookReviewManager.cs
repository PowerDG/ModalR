using Abp.Domain.Repositories;
using System;
using System.Threading.Tasks;

namespace BookService.Host.Domain.DomainService
{
    /// <summary>
    /// BookReview领域层的业务管理
    ///</summary>
    public class BookReviewManager : BookDomainServiceBase, IBookReviewManager
    {
        private readonly IRepository<BookReview, uint> m_repository;

        private readonly IRepository<Book, uint> m_bookRepository;

        private readonly BookManager m_bookManager;

        /// <summary>
        /// BookReview的构造方法
        ///</summary>
        public BookReviewManager(
            IRepository<BookReview, uint> repository,
            IRepository<Book, uint> bookRepository,
            BookManager bookManager
        )
        {
            m_bookRepository = bookRepository;
            m_bookManager = bookManager;
            m_repository = repository;
        }

        /// <summary>
        /// 初始化
        ///</summary>
        public void InitBookReview()
        {
            throw new NotImplementedException();
        }

        public virtual async Task UpdateLastBookReview(BookReview input)
        {
            var entity = BookReviewAsync(input);

            await m_bookRepository.UpdateAsync(entity);
        }

        public virtual async Task ReturnBookWithBookReview(BookReview input)
        {
            var entity = BookReviewAsync(input);
            entity.ReturnBooks();
            await m_bookRepository.UpdateAsync(entity);
        }

        private Book BookReviewAsync(BookReview input)
        {
            var entity = m_bookRepository.FirstOrDefault(t => t.Id == input.BookId);
            entity.LastBookReview = input.Review;
            entity.LastModificationTime = DateTime.Now;
            entity.AverageScore = CalculateScore(input.BookId, input.Score);
            return entity;
        }

        public virtual decimal CalculateScore(uint bookId, uint score)
        {
            var book = m_bookRepository.FirstOrDefault(t => t.Id == bookId);
            return (book.AverageScore * (book.NumberOfBookReview - 1) + score) / book.NumberOfBookReview;
        }

        // TODO:编写领域业务代码
    }
}