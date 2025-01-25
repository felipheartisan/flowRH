import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/cash.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CashRepository { 
  late DatabaseProvider databaseProvider;
  
  CashRepository(this.databaseProvider);

  Future<int> insert(Cash entity) async{
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Cash", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }
   
    
  }

  Future<int>  delete(Cash entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Cash", 
                  where : "idCash = ?", 
                  whereArgs:  ["${entity.idCash}"]);
  }

  Future<int>  update(Cash entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.update("Cash",
                    entity.toMap(), 
                    where : "idCash = ?", 
                  whereArgs:  ["${entity.idCash}"]);
  }

  Future<Cash> findById(int idCash) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Cash WHERE idCash = $idCash");
    //Se retornou resultados
    var cash = Cash();
    if (result.isNotEmpty){
        Map<String, Object?> item = result[0];
        cash.idCash = item["idCash"] as int;
        cash.valor = item["valor"] as String;
        
    }
    return cash;
  }

  /// Busca todos os registro do banco de dados convertido para
  /// um objeto do tipo List<Estado>.   
  Future<List<Cash>> findAll() async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Cash");
        
    List<Cash> cashResults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            Cash cash = Cash.fromMap(item);
            cashResults.add(cash);
        }
    }
     
    return cashResults;
  }  
}