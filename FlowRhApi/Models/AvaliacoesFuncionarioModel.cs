namespace FlowRhApi.Models
{
     public class AvaliacoesFuncionarioModel
    {
        public int Id { get; set; }
        public FuncionarioModel Funcionario { get; set; }
        public string Nota { get; set; }
        public string CursosFeitos { get; set; }
        public string CursosFazer { get; set; }
        public string Atividades { get; set; }
        public string MesReferencia { get; set; }
        public string AnoReferencia { get; set; }

    }
}