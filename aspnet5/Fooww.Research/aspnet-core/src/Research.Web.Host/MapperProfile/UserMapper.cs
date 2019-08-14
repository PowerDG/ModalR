using AutoMapper;
using Research.Authorization.Users;
using Research.Users.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
 

namespace PartyService.Host.MapperProfile
{
    public class UserMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap<UserWithoutRoleDto, User>();
        }
    }
}
