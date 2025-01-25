namespace FlowRhApi.Dto.Usuario
{
    public class UsuarioCriacaoDto
    {
        public required string Nome { get; set; }
        public required string Email { get; set; }
        public required string Senha { get; set; }
    }
}