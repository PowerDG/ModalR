using Consul;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Swashbuckle.AspNetCore.Swagger;
using System;
using System.IO;
using System.Reflection;

namespace ImageService.Host
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
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

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
                var xmlPath = Path.Combine(basePath, "ImageService.Host.xml");
                options.IncludeXmlComments(xmlPath);
            });

            #endregion Swagger
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IApplicationLifetime applicationLifetime)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            AddSwagger(app);
            app.UseMvc();
            RegisterConsul(applicationLifetime);
            app.UseStaticFiles();
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
                        Interval = TimeSpan.FromSeconds(60),
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