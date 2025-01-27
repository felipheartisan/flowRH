using FlowRhApi.Dto.Usuario;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Usuario;
using FlowRhApi.ViewModel.Login;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioInterface _usuarioInterface;

        public UsuarioController(IUsuarioInterface usuarioInterface)
        {
            _usuarioInterface = usuarioInterface;
        }

        [HttpPost("Autenticar")]
        public async Task<ActionResult<ResponseModel<UsuarioModel>>> Autenticar([FromBody]LoginViewModel loginViewModel)
        {
            var usuariosListReponse = await _usuarioInterface.Autenticar(loginViewModel);
            return Ok(usuariosListReponse);
        }

        [HttpGet("ListarUsuarios")]
        public async Task<ActionResult<ResponseModel<List<UsuarioModel>>>> ListarUsuarios()
        {
            var usuariosListReponse = await _usuarioInterface.ListarUsuarios();
            return Ok(usuariosListReponse);
        }

        [HttpGet("BuscarPorId")]
        public async Task<ActionResult<ResponseModel<UsuarioModel>>> BuscarPorId(int idUsuario)
        {
            var usuariosListReponse = await _usuarioInterface.BuscarPorId(idUsuario);
            return Ok(usuariosListReponse);
        }

        [HttpPost("CriarUsuario")]
        public async Task<ActionResult<ResponseModel<List<UsuarioModel>>>> CriarUsuario(UsuarioCriacaoDto usuarioCriacaoDto)
        {
            var usuariosListReponse = await _usuarioInterface.CriarUsuario(usuarioCriacaoDto);
            return Ok(usuariosListReponse);
        }

        [HttpDelete("DeletarUsuario/{idUsuario}")]
        public async Task<ActionResult<ResponseModel<List<UsuarioModel>>>> DeletarUsuario(int idUsuario)
        {
            var usuariosListReponse = await _usuarioInterface.DeletarUsuario(idUsuario);
            return Ok(usuariosListReponse);
        }
        
        [HttpPut("EditarUsuario")]
        public async Task<ActionResult<ResponseModel<List<UsuarioModel>>>> EditarUsuario(UsuarioEdicaoDto usuarioEdicaoDto)
        {
            var usuariosListReponse = await _usuarioInterface.EditarUsuario(usuarioEdicaoDto);
            return Ok(usuariosListReponse);
        }
    }
}