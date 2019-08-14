using JWT;
using JWT.Algorithms;
using JWT.Serializers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;

namespace ResearchService.Host.Web
{
    public class JwtDecodeHelper
    {
        public static string JWTDecoder(string token)
        {
            string modulus = "yWNUxGw0ACiY0WIecWTz5Ar1gAqPO7cmMAOQfCoAs2ec7e/nte3PCZHn7dC69NPaOtw6i4dyObFZ6Roz7c7QKNHFvG6QG9ZjS9haPrZl3i/pC7xoKjg6A5lMTCC2cC3dlkNd4i1GClUjmkuDEZ6IupJ3EMUQRSejcMx9X7g5kCnmxiwvypTkq3AkfDciHB4k4lmWcZSg2EfixxFoxo8LsEFBXKBKUfYTUT63hmaRW0HCwmqgzNlbSjOtwTu+TbhAuEXxH5tMQqA4SsGRW92r5TOmVOk3Z/m44iohLDUeyMmPZIb5UR3+jMl+CB3R8LQgDwFhBrBL1fxl6orOHwygoQ==";
            string exponent = "AQAB";
            var secret = "def2edf7-5d42-4edc-a84a-30136c340e13";
            try
            {
                IJsonSerializer serializer = new JsonNetSerializer();
                IDateTimeProvider provider = new UtcDateTimeProvider();
                IJwtValidator validator = new JwtValidator(serializer, provider);
                IBase64UrlEncoder urlEncoder = new JwtBase64UrlEncoder();
                RSAlgorithmFactory rS256Algorithm = new RSAlgorithmFactory(() =>
                {
                    RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
                    rsa.ImportParameters(
                      new RSAParameters()
                      {
                          Modulus = FromBase64Url(modulus),
                          Exponent = FromBase64Url(exponent)
                      });

                    byte[] rsaBytes = rsa.ExportCspBlob(true);

                    X509Certificate2 cert = new X509Certificate2(rsaBytes);
                    return cert;
                });
                IJwtDecoder decoder = new JwtDecoder(serializer, validator, urlEncoder, rS256Algorithm);
                var json = decoder.Decode(token, secret, verify: false);//token为之前生成的字符串
                Console.WriteLine(json);
                return json;
            }
            catch (TokenExpiredException)
            {
                Console.WriteLine("Token has expired");
            }
            catch (SignatureVerificationException)
            {
                Console.WriteLine("Token has invalid signature");
            }
            return null;
        }

        public static byte[] FromBase64Url(string base64Url)
        {
            string padded = base64Url.Length % 4 == 0
                ? base64Url : base64Url + "====".Substring(base64Url.Length % 4);
            string base64 = padded.Replace("_", "/")
                                  .Replace("-", "+");
            return Convert.FromBase64String(base64);
        }
    }
}