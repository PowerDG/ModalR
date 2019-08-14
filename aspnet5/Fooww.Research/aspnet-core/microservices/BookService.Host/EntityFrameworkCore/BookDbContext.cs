using Abp.EntityFrameworkCore;
using BookService.Host.Domain;
using Microsoft.EntityFrameworkCore;

namespace BookService.Host.EntityFrameworkCore
{
    public class BookDbContext : AbpDbContext
    {
        //Add DbSet properties for your entities...

        public DbSet<Book> Books { get; set; }
        public DbSet<BookReview> BookReviews { get; set; }

        public BookDbContext(DbContextOptions<BookDbContext> options)
            : base(options)
        {
        }
    }
}