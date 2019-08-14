using Abp.AspNetCore;
using Abp.Castle.Logging.Log4Net;
using Abp.EntityFrameworkCore;
using Castle.Facilities.Logging;
using Consul;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Panda.DynamicWebApi;
using PartyService.Host.EntityFrameworkCore;
using ResearchService.Host.Web;
using Swashbuckle.AspNetCore.Swagger;
using System;
using System.IO;
using System.Reflection;

namespace PartyService.Host
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public IServiceProvider ConfigureServices(IServiceCollection services)
        {
            services.AddAbpDbContext<PartyDbContext>(options =>
            {
                DbContextOptionsConfigurer.Configure(options.DbContextOptions, options.ConnectionString);
            });

            #region CORS

            services.AddCors(c =>
            {
                c.AddPolicy("LimitRequests", policy =>
                {
                    //                    policy
                    //                        .WithOrigins("http://192.168.1.136:8080", "http://192.168.1.165:8080", "http://localhost:8080")
                    //                        .AllowCredentials()
                    //                        .AllowAnyHeader()
                    //                        .AllowAnyMethod();
                    //                    policy.AllowAnyOrigin();
                    policy.WithOrigins("http://192.168.1.136:8080", "http://192.168.1.165:8080",
                        "http://localhost:8080").AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });

            #endregion CORS

            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
            //            services.AddMvc(options =>
            //            {
            //                options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
            //            }).SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            #region Swagger

            services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new Info
                {
                    Version = Configuration["Swagger:Version"],
                    Title = Configuration["Swagger:Title"],
                    Description = "接口说明文档",
                    TermsOfService = "None",
                    Contact = new Contact { Name = "Fooww", Email = "Research@xxx.com", Url = "https://research.fooww.com/" }
                });
                options.DocInclusionPredicate((docName, description) =>
                {
                    return true;
                });
                var basePath = Path.GetDirectoryName(typeof(Program).Assembly.Location);
                var xmlPath = Path.Combine(basePath, "PartyService.Host.xml");
                options.IncludeXmlComments(xmlPath);
            });

            #endregion Swagger

            services.AddDynamicWebApi();
            var identityServer = ConsulHelper.GetServiceAddress("Fooww.Research.Web.Host");
            services.AddAuthentication("Bearer")
                .AddIdentityServerAuthentication(options =>
                {
                    options.Authority = identityServer;// "http://192.168.1.136:9500";//identity server 地址
                    options.RequireHttpsMetadata = false;
                });

            return services.AddAbp<PartyServiceHostModule>(
                  // Configure Log4Net logging
                  options => options.IocManager.IocContainer.AddFacility<LoggingFacility>(
                      f => f.UseAbpLog4Net().WithConfig("log4net.config")
                  )
              );
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IApplicationLifetime applicationLifetime)
        {
            app.UseAbp(); // Initializes ABP framework.
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors("LimitRequests"); // Enable CORS!
            app.UseStaticFiles();
            app.UseAuthentication();
            AddSwagger(app);
            app.UseMvc();
            RegisterConsul(applicationLifetime);
        }

        private void AddSwagger(IApplicationBuilder app)
        {
            #region Swagger

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", Configuration["Swagger:DefineSwaggerName"]);
            });

            #endregion Swagger
        }

        private void RegisterConsul(IApplicationLifetime applicationLifetime)
        {
            string ip = Configuration["ip"];
            int port = Convert.ToInt32(Configuration["port"]);
            string serviceName = Assembly.GetExecutingAssembly().GetName().Name;
            string serviceId = serviceName + Guid.NewGuid();
            using (var client = new ConsulClient(ConsulConfig))
            {//注册服务到Consul
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
            // c.Address = new Uri("http://127.0.0.1:8500");
            c.Address = new Uri("http://192.168.1.102:8500");
            c.Datacenter = "dc1";
        }
    }
}