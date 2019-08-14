using Consul;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Ocelot.Provider.Consul;
using Swashbuckle.AspNetCore.Swagger;
using System;
using System.Collections.Generic;

namespace OcelotGateway.Host
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var identityServer = ConsulHelper.GetServiceAddress("Fooww.Research.Web.Host");
            var authenticationScheme = "OcelotKey";
            services.AddAuthentication("Bearer")
                .AddIdentityServerAuthentication(authenticationScheme, options =>
                {
                    options.Authority = identityServer;//"http://192.168.1.136:9500";//identity server 地址
                    options.RequireHttpsMetadata = false;
                });

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            #region CORS

            services.AddCors(c =>
            {
                c.AddPolicy("LimitRequests", policy =>
                {
                    policy
                        .WithOrigins(Configuration["Cors"].Split(','))
                        // .AllowCredentials()
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });

            #endregion CORS

            #region Swagger

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info
                {
                    Version = Configuration["Swagger:Version"],
                    Title = Configuration["Swagger:Title"],
                    TermsOfService = "None",
                    Contact = new Contact { Name = "Fooww", Email = "Fooww.Research@xxx.com", Url = "https://research.fooww.com/" }
                });
            });

            #endregion Swagger

            services.AddOcelot(Configuration).AddConsul();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IApplicationLifetime applicationLifetime)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors("LimitRequests");
            app.UseMvc();
            AddSwaggerDoc(app);
            app.UseOcelot().Wait();
            RegisterConsul(applicationLifetime);
        }

        private void AddSwaggerDoc(IApplicationBuilder app)
        {
            #region Swagger

            var apis = new List<string> { "EmailService", "PartyService.Host" };
            app.UseSwagger();
            app.UseSwaggerUI(options =>
            {
                options.SwaggerEndpoint("/swagger/v1/swagger.json", Configuration["Swagger:Version"]);
                apis.ForEach(m => { options.SwaggerEndpoint($"/{m}/swagger.json", m); });
            });

            #endregion Swagger
        }

        private void RegisterConsul(IApplicationLifetime applicationLifetime)
        {
            string ip = Configuration["ip"];
            int port = Convert.ToInt32(Configuration["port"]);
            string serviceName = "OcelotGateway.Host";
            string serviceId = serviceName + Guid.NewGuid();
            using (var client = new ConsulClient(ConsulConfig))
            {
                client.Agent.ServiceRegister(new AgentServiceRegistration()
                {
                    ID = serviceId,//服务编号，不能重复，用Guid最简单
                    Name = serviceName,//服务的名字
                    Address = ip,//服务提供者的能被消费者访问的ip地址(可以被其他应用访问的地址，本地测试可以用127.0.0.1，机房环境中一定要写自己的内网ip地址)
                    Port = port,//服务提供者的能被消费者访问的端口
                    Check = new AgentServiceCheck
                    {
                        DeregisterCriticalServiceAfter = TimeSpan.FromSeconds(5),//服务停止多久后反注册(注销)
                        Interval = TimeSpan.FromSeconds(10),//健康检查时间间隔，或者称为心跳间隔
                        HTTP = $"http://{ip}:{port}/api/health",//健康检查地址
                        Timeout = TimeSpan.FromSeconds(5)
                    }
                }).Wait();//Consult客户端的所有方法几乎都是异步方法，但是都没按照规范加上Async后缀，所以容易误导。记得调用后要Wait()或者await
            }

            //程序正常退出的时候从Consul注销服务//要通过方法参数注入IApplicationLifetime
            applicationLifetime.ApplicationStopped.Register(() =>
            {
                using (var client = new ConsulClient(ConsulConfig))
                {
                    client.Agent.ServiceDeregister(serviceId).Wait();
                }
            });
        }

        private void ConsulConfig(ConsulClientConfiguration c)
        {
            //            c.Address = new Uri("http://127.0.0.1:8500");
            c.Address = new Uri("http://192.168.1.102:8500");
            c.Datacenter = "dc1";
        }
    }
}