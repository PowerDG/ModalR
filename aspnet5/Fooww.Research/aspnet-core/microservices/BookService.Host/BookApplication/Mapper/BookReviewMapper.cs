
using AutoMapper;
using BookService.Host.Domain;
using BookService.Host.Domain.Dtos;

namespace BookService.Host.Domain.Mapper
{

	/// <summary>
    /// 配置BookReview的AutoMapper
    /// </summary>
	internal static class BookReviewMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap <BookReview,BookReviewListDto>();
            configuration.CreateMap <BookReviewListDto,BookReview>();

            configuration.CreateMap <BookReviewEditDto,BookReview>();
            configuration.CreateMap <BookReview,BookReviewEditDto>();

        }
	}
}
