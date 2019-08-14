
using AutoMapper;
using ResearchHome.Areas.Introduction.Models;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.Book.Models
{ 
    [Dapper.Table("book")]
    public class BookModel
    {
        [Dapper.Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "您需要填写{0}")]
        [StringLength(50, MinimumLength = 1)]
        public string Name { get; set; }

        public string Photo { get; set; }

        public string PhotoHD { get; set; }

        [Required(ErrorMessage = "您需要填写{0}")]
        [StringLength(20, MinimumLength = 1)]
        public string Author { get; set; }

        public int MemberId { get; set; }

        [Helper.Column(Name = "average_score")]
        public int AverageScore { get; set; }

        [Required(ErrorMessage = "您需要填写{0}")]
        [StringLength(20, MinimumLength = 1)]
        [Helper.Column(Name = "resource")]
        public string Resource { get; set; }
        public int State { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [Helper.Column(Name = "create_time")]
        public DateTime CreateTime { get; set; }

        [StringLength(250, MinimumLength = 3)]
        [Helper.Column(Name = "last_comment")]
        public string LastComment { get; set; }
    }
}
