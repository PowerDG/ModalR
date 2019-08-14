using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Helper
{
    public class CacheHelper
    {
        static readonly MemoryCache Cache = new MemoryCache(new MemoryCacheOptions());

        public static void SetCache(string key, object value, MemoryCacheEntryOptions option = null)
        {
            if(option == null)
            {
                option = new MemoryCacheEntryOptions { SlidingExpiration = TimeSpan.FromHours(1) };
            }
            Cache.Set(key, value, option);
        }

        public static object GetCache(string key) => Cache.Get(key);

        public static void RemoveCache(string key) => Cache.Remove(key);
    }
}
