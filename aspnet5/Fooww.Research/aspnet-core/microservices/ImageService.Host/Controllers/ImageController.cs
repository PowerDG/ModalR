using ImageService.Host.Dtos;
using ImageService.Host.Helper;
using ImageService.Host.Result;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.IO;
using System.Threading.Tasks;

namespace ImageService.Host.Controllers
{
    /// <summary>
    /// 图片操作相关接口
    /// </summary>
    public class ImageController : BaseController
    {
        private readonly string m_pathBase;
        private readonly IConfiguration m_configuration;

        /// <summary>
        /// 构造函数注入
        /// </summary>
        public ImageController(IConfiguration configuration, IHostingEnvironment environment)
        {
            m_configuration = configuration;
            m_pathBase = environment.WebRootPath;
            if (!Directory.Exists(m_pathBase))
            {
                Directory.CreateDirectory(m_pathBase);
            }
        }

        /// <summary>
        /// 接口上传图片方法
        /// </summary>
        /// <param name="fileDtos">文件传输对象,传过来的json数据</param>
        /// <returns>上传结果</returns>
        [HttpPost]
        public async Task<UploadResult> Upload([FromBody]FileDtos fileDtos)
        {
            UploadResult result = new UploadResult();
            string imageFormat = ImageHelper.GetSuffixFromBase64Str(fileDtos.Base64String);
            if (!string.IsNullOrEmpty(imageFormat))
            {
                string uploadPath = m_configuration[$"Paths:{fileDtos.FileType}"];
                if (string.IsNullOrEmpty(uploadPath))
                {
                    uploadPath = m_configuration["Paths:FileUpload"];
                }
                string filePath = m_pathBase + uploadPath;
                if (!Directory.Exists(filePath))
                {
                    Directory.CreateDirectory(filePath);
                }
                var randomFileName = Guid.NewGuid().ToString("N");
                result.OriginalUrl = ImageHelper.SaveImage(fileDtos.Base64String, filePath + $@"{randomFileName}.{imageFormat}")
                    .Substring(m_pathBase.Length);
                if (fileDtos.NeedThumb)
                {
                    result.ThumbUrl = ImageHelper.SaveTumbImage(fileDtos.Base64String, filePath + $@"{randomFileName}part.{imageFormat}")
                        .Substring(m_pathBase.Length);
                }
                result.Success = true;
            }
            return result;
        }

        /// <summary>
        /// 删除图片
        /// </summary>
        /// <returns>执行结果</returns>
        [HttpDelete()]
        public async Task<bool> Delete(string path)
        {
            string filePath = m_pathBase + path;
            if (System.IO.File.Exists(filePath))
            {
                try
                {
                    System.IO.File.Delete(filePath);
                    return true;
                }
                catch (Exception exception)
                {
                    return false;
                }
            }
            return true;
        }
    }
}