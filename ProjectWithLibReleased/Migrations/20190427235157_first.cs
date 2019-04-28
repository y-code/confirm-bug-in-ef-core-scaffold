using Microsoft.EntityFrameworkCore.Migrations;

namespace ProjectWithLibReleased.Migrations
{
    public partial class first : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "sample");

            migrationBuilder.CreateSequence<int>(
                name: "message_id_seq");

            migrationBuilder.CreateTable(
                name: "message",
                schema: "sample",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false, defaultValueSql: "nextval('sample.message_id_seq'::regclass)"),
                    message = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_message", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "message",
                schema: "sample");

            migrationBuilder.DropSequence(
                name: "message_id_seq");
        }
    }
}
