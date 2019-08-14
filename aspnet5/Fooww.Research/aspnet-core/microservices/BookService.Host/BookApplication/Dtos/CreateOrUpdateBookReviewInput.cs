

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class CreateOrUpdateBookReviewInput
    {
        [Required]
        public BookReviewEditDto BookReview { get; set; }

    }
}