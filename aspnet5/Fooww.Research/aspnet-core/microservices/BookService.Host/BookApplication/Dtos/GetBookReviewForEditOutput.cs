

using System.Collections.Generic;
using Abp.Application.Services.Dto;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class GetBookReviewForEditOutput
    {

        public BookReviewEditDto BookReview { get; set; }

    }
}