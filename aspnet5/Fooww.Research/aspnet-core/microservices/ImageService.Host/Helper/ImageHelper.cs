using System;
using System.Drawing;
using System.IO;

namespace ImageService.Host.Helper
{
    public class ImageHelper
    {
        private const int ReduceWidth = 150;
        private const int ReduceHeight = 150;
        private const int MaxWidth = 1440;
        private const int MaxHeight = 900;

        public static bool GetImgBytes(string imageSrc, out Image image)
        {
            try
            {
                var imgData = imageSrc.Split(";")[1].Trim().Replace("base64,", "").Replace("%", "").Replace(",", "").Replace(" ", "+");

                if (imgData.Length % 4 > 0)
                {
                    imgData = imgData.PadRight(imgData.Length + 4 - imgData.Length % 4, '=');
                }
                byte[] base64String = Convert.FromBase64String(imgData);
                image = Image.FromStream(new MemoryStream(base64String, 0, base64String.Length));
                return true;
            }
            catch
            {
                image = null;
                return false;
            }
        }

        public static string GetSuffixFromBase64Str(string base64Str)
        {
            string suffix = string.Empty;
            string prefix = "data:image/";
            if (base64Str.StartsWith(prefix) && base64Str.Contains(";") && base64Str.Contains(","))
            {
                base64Str = base64Str.Split(';')[0];
                suffix = base64Str.Substring(prefix.Length);
            }
            return suffix;
        }

        public static string SaveImage(string base64Str, string imageFile)
        {
            GetImgBytes(base64Str, out Image image);
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
            saveImage.Save(imageFile);
            return imageFile;
        }

        public static string SaveTumbImage(string base64Str, string imageFile)
        {
            GetImgBytes(base64Str, out Image image);
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
                    graphic.DrawImage(image, 0, 0, new Rectangle(offsetX, offsetY, rectangleSideLength, rectangleSideLength),
                        GraphicsUnit.Pixel);
                    using (var saveImage = Image.FromHbitmap(bitmap.GetHbitmap()))
                    {
                        var tumbnailImage = saveImage.GetThumbnailImage(ReduceWidth, ReduceHeight,
                            new Image.GetThumbnailImageAbort(() => false), IntPtr.Zero);
                        tumbnailImage.Save(imageFile);
                    }
                }
            }
            return imageFile;
        }
    }
}