
using AutoMapper;
using Research.Member.Members;
using Research.Member.Members.Dtos;

namespace Research.Member.Members.Mapper
{

	/// <summary>
    /// 配置MemberInfo的AutoMapper
    /// </summary>
	internal static class MemberInfoMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap <MemberInfo,MemberInfoListDto>();
            configuration.CreateMap <MemberInfoListDto,MemberInfo>();

            configuration.CreateMap <MemberInfoEditDto,MemberInfo>();
            configuration.CreateMap <MemberInfo,MemberInfoEditDto>();

        }
	}
}
