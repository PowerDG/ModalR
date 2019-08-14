

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using BookService.Host.Domain;

namespace BookService.Host.Domain.Dtos
{
    public class CreateOrUpdateBookPhrasebookInput
    {
        [Required]
        public BookPhrasebookEditDto BookPhrasebook { get; set; }

    }
}