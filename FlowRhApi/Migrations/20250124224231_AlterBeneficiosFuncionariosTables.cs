using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FlowRhApi.Migrations
{
    /// <inheritdoc />
    public partial class AlterBeneficiosFuncionariosTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DescricaoBeneficio",
                table: "BeneficiosFuncionarios");

            migrationBuilder.DropColumn(
                name: "NomeFuncionario",
                table: "BeneficiosFuncionarios");

            migrationBuilder.RenameColumn(
                name: "IdFuncionario",
                table: "BeneficiosFuncionarios",
                newName: "FuncionarioId");

            migrationBuilder.RenameColumn(
                name: "IdBbeneficio",
                table: "BeneficiosFuncionarios",
                newName: "BeneficioId");

            migrationBuilder.CreateIndex(
                name: "IX_BeneficiosFuncionarios_BeneficioId",
                table: "BeneficiosFuncionarios",
                column: "BeneficioId");

            migrationBuilder.CreateIndex(
                name: "IX_BeneficiosFuncionarios_FuncionarioId",
                table: "BeneficiosFuncionarios",
                column: "FuncionarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_BeneficiosFuncionarios_Beneficios_BeneficioId",
                table: "BeneficiosFuncionarios",
                column: "BeneficioId",
                principalTable: "Beneficios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_BeneficiosFuncionarios_Funcionarios_FuncionarioId",
                table: "BeneficiosFuncionarios",
                column: "FuncionarioId",
                principalTable: "Funcionarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_BeneficiosFuncionarios_Beneficios_BeneficioId",
                table: "BeneficiosFuncionarios");

            migrationBuilder.DropForeignKey(
                name: "FK_BeneficiosFuncionarios_Funcionarios_FuncionarioId",
                table: "BeneficiosFuncionarios");

            migrationBuilder.DropIndex(
                name: "IX_BeneficiosFuncionarios_BeneficioId",
                table: "BeneficiosFuncionarios");

            migrationBuilder.DropIndex(
                name: "IX_BeneficiosFuncionarios_FuncionarioId",
                table: "BeneficiosFuncionarios");

            migrationBuilder.RenameColumn(
                name: "FuncionarioId",
                table: "BeneficiosFuncionarios",
                newName: "IdFuncionario");

            migrationBuilder.RenameColumn(
                name: "BeneficioId",
                table: "BeneficiosFuncionarios",
                newName: "IdBbeneficio");

            migrationBuilder.AddColumn<string>(
                name: "DescricaoBeneficio",
                table: "BeneficiosFuncionarios",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NomeFuncionario",
                table: "BeneficiosFuncionarios",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
