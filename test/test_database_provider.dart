import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';

void main() async{

  DatabaseProvider databaseProvider = DatabaseProvider();
print("teste");
  //Criando a instância do Repositorio Estado
  FuncionarioRepository funcionarioRepository = FuncionarioRepository(databaseProvider);

  Funcionario funcionario = Funcionario();
  funcionario.nome = 'Erard';
  funcionario.data_nascimento = '10/11/2002';
  funcionario.salario = '20000';
  funcionario.cargo = 'secretario';
  funcionario.departamento = 'secretaria';
  funcionario.cpf = '43688448073';
  funcionario.rg = '288878413';
  funcionario.telefone = '99999999';
  funcionario.rua = 'floresta';
  funcionario.numero_casa = '12';
  funcionario.bairro = 'floresta';
  funcionario.cidade = 'floresta';
  funcionario.email = 'teste@teste';
  
  funcionarioRepository.insert(funcionario);
  //estadoRepository.insert(estado);
  funcionario = await funcionarioRepository.findById(1);
  print(funcionario);
}
