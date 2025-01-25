using FlowRhApi.Dto.Funcionario;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Funcionario;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FuncionarioController : ControllerBase
    {
        private readonly IFuncionarioInterface _funcionarioInterface;

        public FuncionarioController(IFuncionarioInterface funcionarioInterface)
        {
            _funcionarioInterface = funcionarioInterface;
        }

        [HttpGet("ListarFuncionarios")]
        public async Task<ActionResult<ResponseModel<List<FuncionarioModel>>>> ListarFuncionarios()
        {
            var funcionariosListReponse = await _funcionarioInterface.ListarFuncionario();
            return Ok(funcionariosListReponse);
        }

        [HttpGet("BuscarFuncionarioPorId")]
        public async Task<ActionResult<ResponseModel<UsuarioModel>>> BuscarFuncionarioPorId(int idFuncionario)
        {
            var funcionariosListReponse = await _funcionarioInterface.BuscarFuncionarioPorId(idFuncionario);
            return Ok(funcionariosListReponse);
        }

        [HttpPost("CriarFuncionario")]
        public async Task<ActionResult<ResponseModel<List<FuncionarioModel>>>> CriarFuncionario(FuncionarioCriacaoDto funcionarioCriacaoDto)
        {
            var funcionariosListReponse = await _funcionarioInterface.CriarFuncionario(funcionarioCriacaoDto);
            return Ok(funcionariosListReponse);
        }

        [HttpDelete("DeletarFuncionario/{idFuncionario}")]
        public async Task<ActionResult<ResponseModel<List<FuncionarioModel>>>> DeletarFuncionario(int idFuncionario)
        {
            var funcionariosListReponse = await _funcionarioInterface.DeletarFuncionario(idFuncionario);
            return Ok(funcionariosListReponse);
        }
        
        [HttpPut("EditarFuncionario")]
        public async Task<ActionResult<ResponseModel<List<FuncionarioModel>>>> EditarFuncionario(FuncionarioEdicaoDto funcionarioEdicaoDto)
        {
            var funcionariosListReponse = await _funcionarioInterface.EditarFuncionario(funcionarioEdicaoDto);
            return Ok(funcionariosListReponse);
        }
    }
}