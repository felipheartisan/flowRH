using FlowRhApi.Dto.Funcionario;
using FlowRhApi.Models;

namespace FlowRhApi.Repositories.Funcionario
{
    public interface IFuncionarioInterface
    {
        Task<ResponseModel<List<FuncionarioModel>>> ListarFuncionario();
        Task<ResponseModel<FuncionarioModel>> BuscarFuncionarioPorId(int idFuncionario);
        Task<ResponseModel<List<FuncionarioModel>>> CriarFuncionario(FuncionarioCriacaoDto funcionarioCriacaoDto);
        Task<ResponseModel<List<FuncionarioModel>>> EditarFuncionario(FuncionarioEdicaoDto funcionarioEdicaoDto);
        Task<ResponseModel<List<FuncionarioModel>>> DeletarFuncionario(int idUsuario);
    }
}