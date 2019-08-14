using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Models;
using System.Drawing;

namespace ResearchHome.Controllers
{
    public class FileOptionController : Controller
    {
        private IConfiguration _configuration;
        private IHostingEnvironment _environment;

        public FileOptionController(IConfiguration config, IHostingEnvironment environment)
        {
            _configuration = config;
            _environment = environment;
        }

        public IActionResult Index()
        {
            return View();
        }
        public bool ThumbnailCallback()
        {
            return false;
        }

        [DisableRequestSizeLimit]
        public IActionResult UploadFile(string uploadFileType)
        {
            string uploadpathUrl = $"{_configuration[$@"Paths:{uploadFileType}"]}";
            string dirPath = $"{_environment.WebRootPath}{uploadpathUrl.Replace('/', '\\')}";
            var pictureList = new List<UploadPictureModel>();
            if (!Directory.Exists(dirPath))
            {
                Directory.CreateDirectory(dirPath);
            }
            foreach (var myfile in HttpContext.Request.Form.Files)
            {
                string fileExt = Path.GetExtension(myfile.FileName).ToLower();
                string newFileName = Guid.NewGuid().ToString("N") + fileExt;
                string filename = myfile.FileName;
                if (myfile.Length > 0)
                {
                    var url = $"{dirPath}{newFileName.Trim('"')}";
                    using (var image = Image.FromStream(myfile.OpenReadStream()))
                    {
                        var saveWidth = image.Width;
                        var saveHeight = image.Height;
                        if (image.Width > 1440)
                        {
                            saveHeight = Convert.ToInt32(saveHeight / (saveWidth * 1.0 / 1440));
                            saveWidth = 1440;
                        }
                        if (saveHeight > 900)
                        {
                            saveWidth = Convert.ToInt32(saveWidth / (saveHeight * 1.0 / 900));
                            saveHeight = 900;
                        }
                        Image.GetThumbnailImageAbort myCallback = new Image.GetThumbnailImageAbort(ThumbnailCallback);
                        image.GetThumbnailImage(saveWidth, saveHeight, myCallback, IntPtr.Zero).Save(url);
                    }
                    var showFileUrl = (uploadpathUrl + "/" + newFileName.Trim('"')).Replace("//", "/").Replace("//", "/");
                    pictureList.Add(new UploadPictureModel
                    {
                        Src = showFileUrl,
                        Name = filename,
                        Type = fileExt,
                    });
                }
            }
            return Json(pictureList);
        }
        
        [HttpPost]
        public JsonResult DeleteFile(string fileUrl)
        {
            var fullFileUrl = $"{_environment.WebRootPath}{fileUrl}";
            if (System.IO.File.Exists(fullFileUrl))
            {
                System.IO.File.Delete(fullFileUrl);
            }
            return Json("");
        }

        public FileResult DownWebFile(string imgSrc)
        {
            string dirPath = $"{_environment.WebRootPath}{imgSrc.Replace('/', '\\')}";
            var fileIsExists = System.IO.File.Exists(dirPath);
            if (!fileIsExists)
            {
                dirPath = $"{_environment.WebRootPath}{"/images/public/NonePicture.png".Replace('/', '\\')}";
            }
            var fileName = System.IO.Path.GetFileName(dirPath);
            var fileBytes = System.IO.File.ReadAllBytes(dirPath);
            return File(fileBytes, "application/x-msdownload", fileName);
        }
    }
}