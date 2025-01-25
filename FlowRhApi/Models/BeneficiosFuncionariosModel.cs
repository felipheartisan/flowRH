namespace FlowRhApi.Models
{
    public class BeneficiosFuncionariosModel
    {
        public int Id { get; set; }
        public FuncionarioModel Funcionario { get; set; }
        public BeneficioModel Beneficio { get; set; }

    }
}