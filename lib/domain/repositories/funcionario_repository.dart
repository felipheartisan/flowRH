import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:flow_rh/domain/repositories/avaliacoes_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FuncionarioRepository{
  late DatabaseProvider databaseProvider;

  FuncionarioRepository(this.databaseProvider);

  Future<int> insert(Funcionario entity) async{
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Funcionarios", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }
   
    
  }

  Future<int>  delete(Funcionario entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Funcionarios",
                  where : "idFuncionarios = ?", 
                  whereArgs:  ["${entity.idFuncionarios}"]);
                 
  }

  Future<int>  update(Funcionario entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.update("Funcionarios",
                    entity.toMap(), 
                    where : "idFuncionarios = ?", 
                  whereArgs:  ["${entity.idFuncionarios}"]);
  }

  Future<Funcionario> findById(int idFuncionarios) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Funcionarios WHERE idFuncionarios = ${idFuncionarios}");
    //Se retornou resultados
    var funcionario = Funcionario();
    if (result.isNotEmpty){
        Map<String, Object?> item = result[0];
        funcionario.idFuncionarios = item["idFuncionarios"] as int;
        funcionario.nome = item["nome"] as String;
        
    }
    return funcionario;
  }

  /// Busca todos os registro do banco de dados convertido para
  /// um objeto do tipo List<Estado>.   
  Future<List<Funcionario>> findAll() async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Funcionarios");
        
    List<Funcionario> funcionarioResults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            Funcionario funcionario = Funcionario.fromMap(item);
            funcionarioResults.add(funcionario);
        }
    }
     
    return funcionarioResults;
  }  

}