using FlowRhApi.Dto.Avaliacao;
using FlowRhApi.Models;

namespace FlowRhApi.Repositories.Avaliacao
{
    public interface IAvaliacaoInterface
    {
        Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> ListarAvaliacoes();
        Task<ResponseModel<AvaliacoesFuncionarioModel>> BuscarAvaliacaoPorId(int idAvaliacao);
        Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> CriarAvaliacao(AvaliacaoCriacaoDto AvaliacaoCriacaoDto);
        Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> EditarAvaliacao(AvaliacaoEdicaoDto AvaliacaoEdicaoDto);
        Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> DeletarAvaliacao(int idAvaliacao);
    }
}