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
using BookService.Host.EntityFrameworkCore;
using Swashbuckle.AspNetCore.Swagger;
using System;
using System.IO;
using ResearchService.Host.Web;
using Microsoft.AspNetCore.Http;

namespace BookService.Host
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
            services.AddAbpDbContext<BookDbContext>(options =>
            {
                DbContextOptionsConfigurer.Configure(options.DbContextOptions, options.ConnectionString);
            });
            services.AddMvc(options =>
            {
                options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
            }).SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

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
                var xmlPath = Path.Combine(basePath, "BookService.Host.xml");
                options.IncludeXmlComments(xmlPath);
            });

            #endregion Swagger

            services.AddDynamicWebApi();

            var identityServer = ConsulHelper.GetServiceAddress("Fooww.Research.Web.Host");
            //var authenticationScheme = "OcelotKey";

            services.AddAuthentication("Bearer")
                .AddIdentityServerAuthentication(options =>
                {
                    options.Authority = identityServer;
                    options.RequireHttpsMetadata = false;
                });

            services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>(); //Context获取

            return services.AddAbp<BookServiceHostModule>(
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

            //app.UseCors(_defaultCorsPolicyName); // Enable CORS!
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
            string serviceName = "BookService.Host";
            string serviceId = serviceName + Guid.NewGuid();
            using (var client = new ConsulClient(ConsulConfig))
            {
                client.Agent.ServiceRegister(new AgentServiceRegistration()
                {
                    ID = serviceId,
                    Name = serviceName,
                    Address = ip,
                    Port = port,
                    Check = new AgentServiceCheck
                    {
                        DeregisterCriticalServiceAfter = TimeSpan.FromSeconds(5),
                        Interval = TimeSpan.FromSeconds(45),
                        HTTP = $"http://{ip}:{port}/api/health",
                        Timeout = TimeSpan.FromSeconds(5)
                    }
                }).Wait();
            }

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
            c.Address = new Uri("http://192.168.1.102:8500");
            c.Datacenter = "dc1";
        }
    }
}