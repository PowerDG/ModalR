using Microsoft.EntityFrameworkCore.Migrations;

namespace Research.Migrations
{
    public partial class Init_description_to_role : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "description",
                table: "AbpRoles",
                maxLength: 5000,
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "description",
                table: "AbpRoles");
        }
    }
}
