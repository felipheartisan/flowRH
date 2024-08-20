import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BeneficiosRepository{
  late DatabaseProvider databaseProvider;

  BeneficiosRepository(this.databaseProvider);

  Future<int> insert(Beneficio entity) async{
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Beneficios", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }
   
    
  }

  Future<int>  delete(Beneficio entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Beneficios", 
                  where : "idBeneficios = ?", 
                  whereArgs:  ["${entity.idBeneficios}"]);
  }

  Future<int>  update(Beneficio entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.update("Beneficios",
                    entity.toMap(), 
                    where : "idBeneficios = ?", 
                  whereArgs:  ["${entity.idBeneficios}"]);
  }

  Future<Beneficio> findById(int idBeneficios) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Beneficios WHERE idBeneficios = ${idBeneficios}");
    //Se retornou resultados
    var beneficio = Beneficio();
    if (result.isNotEmpty){
        Map<String, Object?> item = result[0];
        beneficio.idBeneficios = item["idBeneficios"] as int;
        beneficio.descricao = item["descricao"] as String;
        
    }
    return beneficio;
  }

  /// Busca todos os registro do banco de dados convertido para
  /// um objeto do tipo List<Estado>.   
  Future<List<Beneficio>> findAll() async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery("SELECT * FROM Beneficios");
        
    List<Beneficio> beneficioResults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            Beneficio beneficio = Beneficio.fromMap(item);
            beneficioResults.add(beneficio);
        }
    }
     
    return beneficioResults;
  }  
}