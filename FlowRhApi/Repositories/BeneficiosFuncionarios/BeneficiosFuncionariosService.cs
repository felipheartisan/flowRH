using FlowRhApi.Data;
using FlowRhApi.Dto.BeneficiosFuncionarios;
using FlowRhApi.Models;
using FlowRhApi.Repositories.BeneficiosFuncionarios;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Usuario
{
    public class BeneficiosFuncionariosService : IBeneficiosFuncionariosInterface
    {
        private readonly AppDbContext _context;
        public BeneficiosFuncionariosService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<List<BeneficiosFuncionariosModel>>> BuscarPorBeneficio(int idBeneficio)
        {
            ResponseModel<List<BeneficiosFuncionariosModel>> response = new ResponseModel<List<BeneficiosFuncionariosModel>>();

            try
            {
                var beneficio = await _context.Beneficios.FirstOrDefaultAsync(x => x.Id == idBeneficio);
                if (beneficio == null)
                {
                    response.Mensagem = "Beneficio não encontrado";
                    response.Status = true;
                    return response;
                }

                var vinculo = await _context.BeneficiosFuncionarios.FirstOrDefaultAsync(x => x.Beneficio.Id == idBeneficio);

                if (vinculo == null)
                {
                    response.Mensagem = "Nenhum vinculo encontrado para este beneficio";
                    response.Status = true;
                    return response;
                }

                var beneficiosFuncionarios = await _context.BeneficiosFuncionarios
                   .Include(x => x.Funcionario)
                   .Include(x => x.Beneficio)
                   .Where(x => x.Beneficio.Id == idBeneficio).ToListAsync();

                response.Dados = beneficiosFuncionarios;
                response.Status = true;
                response.Mensagem = "Vinculos listados com sucesso";
                return response;
            }
            catch (Exception ex)
            {

                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficiosFuncionariosModel>>> BuscarPorFuncionario(int idFuncionario)
        {
            ResponseModel<List<BeneficiosFuncionariosModel>> response = new ResponseModel<List<BeneficiosFuncionariosModel>>();

            try
            {
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(x => x.Id == idFuncionario);
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionario não encontrado";
                    response.Status = true;
                    return response;
                }

                var vinculo = await _context.BeneficiosFuncionarios.FirstOrDefaultAsync(x => x.Funcionario.Id == idFuncionario);

                if (vinculo == null)
                {
                    response.Mensagem = "Nenhum vinculo encontrado para este beneficio";
                    response.Status = true;
                    return response;
                }

                var beneficiosFuncionarios = await _context.BeneficiosFuncionarios
                   .Include(x => x.Funcionario)
                   .Include(x => x.Beneficio)
                   .Where(x => x.Funcionario.Id == idFuncionario).ToListAsync();

                response.Dados = beneficiosFuncionarios;
                response.Status = true;
                response.Mensagem = "Vinculos listados com sucesso";
                return response;
            }
            catch (Exception ex)
            {

                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficiosFuncionariosModel>>> DeletarVinculoBeneficioFuncionario(int idBeneficioFuncionario)
        {
            ResponseModel<List<BeneficiosFuncionariosModel>> response = new ResponseModel<List<BeneficiosFuncionariosModel>>();

            try
            {
                var vinculo = await _context.BeneficiosFuncionarios.FirstOrDefaultAsync(x => x.Id == idBeneficioFuncionario);
                if (vinculo == null)
                {
                    response.Mensagem = "Vinculo não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.BeneficiosFuncionarios.Remove(vinculo);
                await _context.SaveChangesAsync();

                var beneficiosFuncionarios = await _context.BeneficiosFuncionarios
                    .Include(x => x.Funcionario)
                    .Include(x => x.Beneficio).ToListAsync();

                response.Dados = beneficiosFuncionarios;
                response.Status = true;
                response.Mensagem = "Vinculos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {

                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficiosFuncionariosModel>>> ListarTodos()
        {
            ResponseModel<List<BeneficiosFuncionariosModel>> response = new ResponseModel<List<BeneficiosFuncionariosModel>>();

            try
            {
                var beneficiosFuncionarios = await _context.BeneficiosFuncionarios
                    .Include(x => x.Funcionario)
                    .Include(x => x.Beneficio).ToListAsync();

                response.Dados = beneficiosFuncionarios;
                response.Status = true;
                response.Mensagem = "Vinculos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {

                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficiosFuncionariosModel>>> VincularBeneficioFuncionario(BeneficioFuncionarioCriacaoDto beneficioFuncionarioCriacaoDto)
        {

            ResponseModel<List<BeneficiosFuncionariosModel>> response = new ResponseModel<List<BeneficiosFuncionariosModel>>();

            try
            {

                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(linhaBanco => linhaBanco.Id == beneficioFuncionarioCriacaoDto.FuncionarioId);
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionario nao encontrado";
                    response.Status = false;
                    return response;
                }

                var beneficio = await _context.Beneficios.FirstOrDefaultAsync(linhaBanco => linhaBanco.Id == beneficioFuncionarioCriacaoDto.BeneficioId);
                if (beneficio == null)
                {
                    response.Mensagem = "Beneficio nao encontrado";
                    response.Status = false;
                    return response;
                }

                var novoVinculo = new BeneficiosFuncionariosModel()
                {
                    Beneficio = beneficio,
                    Funcionario = funcionario

                };

                _context.BeneficiosFuncionarios.Add(novoVinculo);
                await _context.SaveChangesAsync();

                var beneficiosFuncionarios = await _context.BeneficiosFuncionarios
                    .Include(x => x.Beneficio)
                    .Include(x => x.Funcionario).ToListAsync();

                response.Dados = beneficiosFuncionarios;
                response.Status = true;
                response.Mensagem = "avaliacaos listados com sucesso";

                return response;

            }
            catch (Exception ex)
            {

                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }

    }

}
