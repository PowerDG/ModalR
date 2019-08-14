
using System;
using System.Collections.Generic;
using System.Text;

using Abp.Dependency;
using Abp.Runtime.Session;

namespace Research.Member
{
    public class TestAppService : ITransientDependency
{
    private readonly IAbpSession _abpSession;
    
    public TestAppService(IAbpSession abpSession)
    {
        _abpSession = abpSession;
    }
    
    public void TestMethod()
    {
        using(_abpSession.Use(null,5))
        {
            // 其他操作
        }
        
        // 出去 using 语句之后会自动释放之前的值
    }
}
}
