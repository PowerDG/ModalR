using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.DataBase
{
    public static class TaskStatus
    {
        public static readonly string NotStarted = "未开始";
        public static readonly string Research = "研究";
        public static readonly string Implement = "实施";
        public static readonly string Testing = "测试";
        public static readonly string Online = "上线";
        public static readonly string Completed = "完成";
        public static readonly string Closed = "关闭";
    }

    public static class TodoStatus
    {
        public static readonly string NotCompleted = "未完成";
        public static readonly string Executing = "执行中";
        public static readonly string Completed = "完成";
    }

    public static class KeyResultStatus
    {
        public static readonly string NotCompleted = "未完成";
        public static readonly string Closed = "关闭";
    }

    public static class PlanStatus
    {
        public static readonly string Opened = "开放";
        public static readonly string Closed = "关闭";
    }
}
