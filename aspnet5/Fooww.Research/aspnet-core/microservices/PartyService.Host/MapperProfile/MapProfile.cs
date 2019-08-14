using AutoMapper;
using PartyService.Host.Models;
using PartyService.Host.Models.Dtos;
using ResearchService.Host.Web;

namespace PartyService.Host.MapperProfile
{
    public class MapProfile : Profile
    {
        public MapProfile()
        {
            CreateMap<FundModel, FundListDto>().ConstructUsing(x => new FundListDto()
            { MemberName = UserNameHelper.GetUserName(x.MemberId) }); ;
            CreateMap<FundCreateDto, FundModel>();

            CreateMap<FundEditDto, FundModel>();
            CreateMap<FundModel, FundEditDto>();

            CreateMap<PartyCreateDto, Party>();
            CreateMap<PartyCreateDto, PartyEditDto>();
            CreateMap<PartyEditDto, Party>();
            CreateMap<Party, PartyListDto>();

            CreateMap<PartyCommentDto, PartyComment>();
            CreateMap<PartyComment, PartyCommentDto>();

            CreateMap<PartyPhotoDto, PartyPhoto>();
            CreateMap<PartyPhoto, PartyPhotoDto>();
        }
    }
}