using Microsoft.Extensions.DependencyInjection;
using System;
using System.Data;

namespace ResearchHome.DataBase
{
    public static class DatabaseServiceCollection
    {
        public static IServiceCollection AddDapperDataBase(this IServiceCollection services, Func<IDbConnection> CreateConnection)
        {
            services.Configure<DataBaseOptions>(opt =>
            {
                opt.DbConnection = CreateConnection;
            });
            services.AddScoped<IDatabase, Database>();
            return services;
        }
    }
}
