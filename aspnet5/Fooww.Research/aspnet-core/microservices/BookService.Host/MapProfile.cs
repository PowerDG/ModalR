using AutoMapper;
using BookService.Host.Domain;
using BookService.Host.Domain.Dtos;
using ResearchService.Host.Web;

namespace BookService.Host
{
    public class MapProfile : Profile
    {
        public MapProfile()
        {
            CreateMap<BookReview, BookReviewListDto>().ConstructUsing(x => new BookReviewListDto()
            { MemberName = UserNameHelper.GetUserName(x.LastModifierUserId) });

            CreateMap<Book, BookListDto>().ConstructUsing(x => new BookListDto()
            { MemberName = UserNameHelper.GetUserName(x.MemberId) });
        }
    }
}