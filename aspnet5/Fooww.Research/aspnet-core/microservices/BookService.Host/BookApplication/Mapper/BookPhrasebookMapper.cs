
using AutoMapper;
using BookService.Host.Domain;
using BookService.Host.Domain.Dtos;

namespace BookService.Host.Domain.Mapper
{

	/// <summary>
    /// 配置BookPhrasebook的AutoMapper
    /// </summary>
	internal static class BookPhrasebookMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap <BookPhrasebook,BookPhrasebookListDto>();
            configuration.CreateMap <BookPhrasebookListDto,BookPhrasebook>();

            configuration.CreateMap <BookPhrasebookEditDto,BookPhrasebook>();
            configuration.CreateMap <BookPhrasebook,BookPhrasebookEditDto>();

        }
	}
}
