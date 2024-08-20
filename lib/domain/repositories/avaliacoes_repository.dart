import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/avaliacoes_funcionarios.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AvaliacoesRepository{
  late DatabaseProvider databaseProvider;
  
  AvaliacoesRepository(this.databaseProvider);

   Future<int> insert(Avaliacao entity) async {
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Avaliacoes", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }
  }

  Future<int>  delete(Avaliacao entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Avaliacoes", 
                  where : "idAvaliacoes = ?", 
                  whereArgs:  ["${entity.idAvaliacoes}"]);
  }

  Future<int>  update(Avaliacao entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.update("Avaliacoes",
                    entity.toMap(), 
                    where : "idAvaliacoes = ?", 
                  whereArgs:  [entity.idAvaliacoes]);
  }

  Future<Avaliacao> findById(int idAvaliacoes) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Avaliacoes WHERE idAvaliacoes = ${idAvaliacoes}");
    //Se retornou resultados
    var avaliacao = Avaliacao();
    if (result.isNotEmpty){
        Map<String, Object?> item = result[0];
        avaliacao.idAvaliacoes = item["idAvaliacoes"] as int;
        avaliacao.nota = item["nota"] as String;
        
    }
    return avaliacao;
  }
 

   /// Busca todos os registro do banco de dados convertido para
  /// um objeto do tipo List<Estado>.   
  Future<List<Avaliacao>> findAll() async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery('''
SELECT a.*,
      f.nome AS NomeFuncionario
FROM Avaliacoes as a
JOIN Funcionarios as f 
    ON a.idFuncionarios = f.idFuncionarios;

''');
        
    List<Avaliacao> avaliacaoResults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            Avaliacao avaliacao = Avaliacao.fromMap(item);
            avaliacaoResults.add(avaliacao);
        }
    }
     
    return avaliacaoResults;
  }  

}
