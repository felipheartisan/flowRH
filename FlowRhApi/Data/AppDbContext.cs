using FlowRhApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Data
{
    public class AppDbContext : DbContext{
    
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<BeneficiosFuncionariosModel> BeneficiosFuncionarios { get; set; }
        public DbSet<UsuarioModel> Usuarios { get; set; }
        public DbSet<BeneficioModel> Beneficios { get; set; }
        public DbSet<CaixaModel> Caixas { get; set; }
        public DbSet<FuncionarioModel> Funcionarios { get; set; }
        public DbSet<AvaliacoesFuncionarioModel> AvaliacoesFuncionarios { get; set; }

    }
}