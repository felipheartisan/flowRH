using FlowRhApi.Dto.Usuario;
using FlowRhApi.Models;
using FlowRhApi.ViewModel.Login;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Repositories.Usuario
{
    public interface IUsuarioInterface
    {
        Task<ResponseModel<List<UsuarioModel>>> ListarUsuarios();
        Task<ResponseModel<UsuarioModel>> BuscarPorId(int idUsuario);
        Task<ResponseModel<List<UsuarioModel>>> CriarUsuario(UsuarioCriacaoDto usuarioCriacaoDto);
        Task<ResponseModel<List<UsuarioModel>>> EditarUsuario(UsuarioEdicaoDto usuarioEdicaoDto);
        Task<ResponseModel<UsuarioModel>> Autenticar([FromBody]LoginViewModel loginViewModel);
        Task<ResponseModel<List<UsuarioModel>>> DeletarUsuario(int idUsuario);

    }
}