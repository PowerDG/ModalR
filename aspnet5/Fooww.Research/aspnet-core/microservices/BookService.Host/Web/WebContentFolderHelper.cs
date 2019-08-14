using System;
using System.IO;
using System.Linq;

namespace ResearchService.Host.Web
{
    /// <summary>
    /// This class is used to find root path of the web project in;
    /// unit tests (to find views) and entity framework core command line commands (to find conn string).
    /// </summary>
    public static class WebContentDirectoryFinder
    {
        public static string CalculateContentRootFolder()
        {
            var coreAssemblyDirectoryPath = Path.GetDirectoryName(AppContext.BaseDirectory);
            if (coreAssemblyDirectoryPath == null)
            {
                throw new Exception("Could not find location of MyCompany.Core assembly!");
            }

            var directoryInfo = new DirectoryInfo(coreAssemblyDirectoryPath);
            while (!DirectoryContains(directoryInfo.FullName, "Research.Member.sln"))
            {
                if (directoryInfo.Parent == null)
                {
                    return coreAssemblyDirectoryPath;
                    //throw new Exception("Could not find content root folder!");
                }

                directoryInfo = directoryInfo.Parent;
            }

            return coreAssemblyDirectoryPath;
            //throw new Exception($"{Path.DirectorySeparatorChar} root folder!");
            //return Path.Combine(directoryInfo.FullName, $"src{Path.DirectorySeparatorChar}BookService.Host");
        }

        private static bool DirectoryContains(string directory, string fileName)
        {
            return Directory.GetFiles(directory).Any(filePath => string.Equals(Path.GetFileName(filePath), fileName));
        }
    }
}