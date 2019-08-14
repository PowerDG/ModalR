using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome
{
    public class ExceptionTool : ExceptionFilterAttribute
    {
        private NLog.Logger logger;

        public ExceptionTool()
        {
            logger = NLog.Web.NLogBuilder.ConfigureNLog("nlog.config").GetCurrentClassLogger();
        }

        public override void OnException(ExceptionContext context)
        {
            //TODO：内容格式待调整
            logger.Error(context.Exception, context.Exception.Message + "\r\n" + context.Exception.StackTrace );
            base.OnException(context);
        }
    }
}
