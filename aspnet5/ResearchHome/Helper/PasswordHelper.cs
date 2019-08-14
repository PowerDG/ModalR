using System;
using System.Security.Cryptography;
using System.Text;

namespace ResearchHome.Helper
{
    public class PasswordHelper
    {
        private const int _hashByteSize = 64;
        private const int _passwordKeyLen = 8;
        private const int _pbkdf2Iterations = 10000;
        
        public static string GetRandomPasswordKey()
        {
            Random strRandom = new Random();
            var result = "";
            var randomStrRange = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
            for (int i = 0; i < _passwordKeyLen; i++)
            {
                result += randomStrRange.Substring(strRandom.Next(0, randomStrRange.Length - 1), 1);
            }
            return result;
        }

        public static string GetRfcDerivePassword(string password, string passwordKey)
        {
            byte[] salt = Encoding.Default.GetBytes(passwordKey);
            var hash = GetPbkdf2Bytes(password, salt, _passwordKeyLen, _hashByteSize);
            var hashedPassword = BitConverter.ToString(hash).Replace("-",string.Empty);
            return hashedPassword;
        }
        
        private static byte[] GetPbkdf2Bytes(string password, byte[] salt, int iterations, int outputBytes)
        {
            var pbkdf2 = new Rfc2898DeriveBytes(password, salt);
            pbkdf2.IterationCount = iterations;
            return pbkdf2.GetBytes(outputBytes);
        }

        public static string GetRandomString(int length)
        {
            Random strRandom = new Random();
            var result = "";
            var randomStrRange = "23456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ";
            for (int i = 0; i < length; i++)
            {
                result += randomStrRange.Substring(strRandom.Next(0, randomStrRange.Length - 1), 1);
            }
            return result;
        }
    }
}
