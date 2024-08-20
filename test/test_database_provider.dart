import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/models/login.dart';
import 'package:flow_rh/domain/repositories/funcionario_repository.dart';
import 'package:flow_rh/domain/repositories/login_repository.dart';

void main() async{

  DatabaseProvider databaseProvider = DatabaseProvider();
  print("teste");
  //Criando a instância do Repositorio Estado
  LoginRepository loginRepository = LoginRepository(databaseProvider);

  Login login = Login();
  login.usuario = "admin";
  login.token = "token";
  
  loginRepository.insert(login);
  //estadoRepository.insert(estado);
}
