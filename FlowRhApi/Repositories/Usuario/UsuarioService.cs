using Azure;
using FlowRhApi.Data;
using FlowRhApi.Dto.Usuario;
using FlowRhApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Usuario
{
    public class UsuarioService : IUsuarioInterface
    {
        private readonly AppDbContext _context;
        public UsuarioService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<UsuarioModel>> BuscarPorId(int idUsuario)
        {
            ResponseModel<UsuarioModel> response = new ResponseModel<UsuarioModel>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == idUsuario);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = usuario;
                response.Status = true;
                response.Mensagem = "Usuário encontrado com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }
       
        public async Task<ResponseModel<List<UsuarioModel>>> CriarUsuario(UsuarioCriacaoDto usuarioCriacaoDto)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var novoUsuario = new UsuarioModel()
                {
                    Nome = usuarioCriacaoDto.Nome,
                    Email = usuarioCriacaoDto.Email,
                    Senha = usuarioCriacaoDto.Senha,
                   
                };

                 _context.Usuarios.Add(novoUsuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<UsuarioModel>>> DeletarUsuario(int idUsuario)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == idUsuario);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.Usuarios.Remove(usuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }

        public async Task<ResponseModel<List<UsuarioModel>>> EditarUsuario(UsuarioEdicaoDto usuarioEdicaoDto)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == usuarioEdicaoDto.Id);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                usuario.Nome = usuarioEdicaoDto.Nome;
                usuario.Email = usuarioEdicaoDto.Email; 
                usuario.Senha = usuarioEdicaoDto.Senha;

                _context.Usuarios.Update(usuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<UsuarioModel>>> ListarUsuarios()
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

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