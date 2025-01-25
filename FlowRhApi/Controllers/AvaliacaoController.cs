using FlowRhApi.Dto.Avaliacao;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Avaliacao;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AvaliacaoController : ControllerBase
    {
        private readonly IAvaliacaoInterface _avaliacaoInterface;

        public AvaliacaoController(IAvaliacaoInterface avaliacaoInterface)
        {
            _avaliacaoInterface = avaliacaoInterface;
        }

        [HttpGet("Listaravaliacaos")]
        public async Task<ActionResult<ResponseModel<List<AvaliacoesFuncionarioModel>>>> ListarAvaliacao()
        {
            var avaliacaosListReponse = await _avaliacaoInterface.ListarAvaliacoes();
            return Ok(avaliacaosListReponse);
        }

        [HttpGet("BuscaravaliacaoPorId")]
        public async Task<ActionResult<ResponseModel<AvaliacoesFuncionarioModel>>> BuscarAvaliacaoPorId(int idAvaliacao)
        {
            var avaliacaosListReponse = await _avaliacaoInterface.BuscarAvaliacaoPorId(idAvaliacao);
            return Ok(avaliacaosListReponse);
        }

        [HttpPost("Criaravaliacao")]
        public async Task<ActionResult<ResponseModel<List<AvaliacoesFuncionarioModel>>>> CriarAvaliacao(AvaliacaoCriacaoDto avaliacaoCriacaoDto)
        {
            var avaliacaosListReponse = await _avaliacaoInterface.CriarAvaliacao(avaliacaoCriacaoDto);
            return Ok(avaliacaosListReponse);
        }

        [HttpDelete("Deletaravaliacao/{idAvaliacao}")]
        public async Task<ActionResult<ResponseModel<List<AvaliacoesFuncionarioModel>>>> DeletarAvaliacao(int idAvaliacao)
        {
            var avaliacaosListReponse = await _avaliacaoInterface.DeletarAvaliacao(idAvaliacao);
            return Ok(avaliacaosListReponse);
        }
        
        [HttpPut("Editaravaliacao")]
        public async Task<ActionResult<ResponseModel<List<AvaliacoesFuncionarioModel>>>> EditarAvaliacao(AvaliacaoEdicaoDto avaliacaoEdicaoDto)
        {
            var avaliacaosListReponse = await _avaliacaoInterface.EditarAvaliacao(avaliacaoEdicaoDto);
            return Ok(avaliacaosListReponse);
        }
    }
}