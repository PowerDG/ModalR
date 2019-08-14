using AutoMapper;
using PartyService.Host.Models;
using PartyService.Host.Models.Dtos;

namespace PartyService.Host.MapperProfile
{
    public class FundMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap<FundModel, FundListDto>();
            configuration.CreateMap<FundListDto, FundModel>();
            configuration.CreateMap<FundCreateDto, FundEditDto>();

            configuration.CreateMap<FundEditDto, FundModel>();
            configuration.CreateMap<FundModel, FundEditDto>();
        }
    }
}