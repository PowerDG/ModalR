using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using System;
using System.Drawing;
using System.IO;

namespace ResearchHome.Helper
{
    public class PictureHelper
    {
        private const int ReduceWidth = 150;
        private const int ReduceHeight = 150;
        private const int MaxWidth = 1440;
        private const int MaxHeight = 900;

        public static Tuple<string, string> UploadPicture(string uploadFileType, string imageSrc, IConfiguration configuration, IHostingEnvironment environment)
        {
            string imageFormat = "";
            byte[] imageBytes = GetImgBytes(imageSrc, out imageFormat);
            if (imageBytes == null)
            {
                return new Tuple<string, string>(null, "图片格式错误！");
            }

            string uploadpathUrl = $"{configuration[$@"Paths:{uploadFileType}"]}";
            string directionPath = $"{environment.WebRootPath}{uploadpathUrl}";
            if (!Directory.Exists(directionPath))
            {
                Directory.CreateDirectory(directionPath);
            }

            try
            {
                using (var image = Image.FromStream(new MemoryStream(imageBytes, 0, imageBytes.Length)))
                {
                    var randomFileName = Guid.NewGuid().ToString("N");
                    string savedImagName = $@"{randomFileName}.{imageFormat}";
                    string partialImageName = $@"{randomFileName}part.{imageFormat}";

                    SaveAndReturnTumbnailImage(image, directionPath, savedImagName);
                    SavePartialTumbnailImg(image, directionPath, partialImageName);

                    return new Tuple<string, string>($"{uploadpathUrl}/{savedImagName.Trim('"')}".Replace("//", "/"),
                                                    $"{uploadpathUrl}/{partialImageName.Trim('"')}".Replace("//", "/"));
                }
            }
            catch (Exception e)
            {
                return new Tuple<string, string>(null, "图片上传失败！");
            }
        }

        public static string UploadOriginPicture(string uploadFileType, string imageSrc, IConfiguration configuration, IHostingEnvironment environment)
        {
            string imageFormat = "";
            byte[] imageBytes = GetImgBytes(imageSrc, out imageFormat);
            if (imageBytes == null)
            {
                return null;
            }
            string uploadpathUrl = $"{configuration[$@"Paths:{uploadFileType}"]}";
            string directionPath = $"{environment.WebRootPath}{uploadpathUrl}";
            if (!Directory.Exists(directionPath))
            {
                Directory.CreateDirectory(directionPath);
            }

            try
            {
                using (var image = Image.FromStream(new MemoryStream(imageBytes, 0, imageBytes.Length)))
                {
                    var randomFileName = Guid.NewGuid().ToString("N");
                    string savedImagName = $@"{randomFileName}.{imageFormat}";
                    SaveAndReturnTumbnailImage(image, directionPath, savedImagName);
                    return ($"{uploadpathUrl}/{savedImagName.Trim('"')}".Replace("//", "/"));
                }
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public static byte[] GetImgBytes(string imageSrc, out string imageFormat)
        {
            try
            {
                byte[] byteimage;
                var imgData = imageSrc.Split(";")[1].Trim().Replace("base64,", "").Replace("%", "").Replace(",", "").Replace(" ", "+");
                imageFormat = $@"{imageSrc.Split(";")[0].Split("/")[1]}".Trim();
                if (imgData.Length % 4 > 0)
                {
                    imgData = imgData.PadRight(imgData.Length + 4 - imgData.Length % 4, '=');
                }
                byteimage = Convert.FromBase64String(imgData);
                return byteimage;
            }
            catch
            {
                imageFormat = "";
                return null;
            }
        }

        private static Image SaveAndReturnTumbnailImage(Image image, string directionPath, string savedImagName)
        {
            var saveWidth = image.Width;
            var saveHeight = image.Height;
            bool needZoom = false;
            if (image.Width > MaxWidth)
            {
                saveHeight = Convert.ToInt32(saveHeight / (saveWidth * 1.0 / MaxWidth));
                saveWidth = MaxWidth;
                needZoom = true;
            }
            if (saveHeight > MaxHeight)
            {
                saveWidth = Convert.ToInt32(saveWidth / (saveHeight * 1.0 / MaxHeight));
                saveHeight = MaxHeight;
                needZoom = true;
            }

            Image saveImage = image;
            if (needZoom)
            {
                saveImage = image.GetThumbnailImage(saveWidth, saveHeight, () => false, IntPtr.Zero);
            }
            saveImage.Save($"{directionPath}{savedImagName.Trim('"')}");
            return saveImage;
        }

        private static void SavePartialTumbnailImg(Image image, string directionPath, string partialImageName)
        {
            var saveWidth = image.Width;
            var saveHeight = image.Height;
            var rectangleSideLength = 0;
            var offsetX = 0;
            var offsetY = 0;
            if (saveWidth > saveHeight)
            {
                rectangleSideLength = saveHeight;
                offsetX = (saveWidth - rectangleSideLength) / 2;
            }
            else
            {
                rectangleSideLength = saveWidth;
                offsetY = (saveHeight - rectangleSideLength) / 2;
            }
            using (var bitmap = new Bitmap(rectangleSideLength, rectangleSideLength))
            {
                using (var graphic = Graphics.FromImage(bitmap))
                {
                    graphic.DrawImage(image, 0, 0, new Rectangle(offsetX, offsetY, rectangleSideLength, rectangleSideLength), GraphicsUnit.Pixel);
                    using (var saveImage = Image.FromHbitmap(bitmap.GetHbitmap()))
                    {
                        var tumbnailImage = saveImage.GetThumbnailImage(ReduceWidth, ReduceHeight, new Image.GetThumbnailImageAbort(() => false), IntPtr.Zero);
                        tumbnailImage.Save($"{directionPath}{partialImageName.Trim('"')}");
                    }
                }
            }
        }

        public static bool DeletePicture(string fileUrl)
        {
            if (System.IO.File.Exists(fileUrl))
            {
                try
                {
                    System.IO.File.Delete(fileUrl);
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
            return true;
        }
    }
}