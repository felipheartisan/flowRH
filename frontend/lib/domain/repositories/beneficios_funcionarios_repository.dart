import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/beneficios.dart';
import 'package:flow_rh/domain/models/beneficios_funcionarios.dart';
import 'package:flow_rh/domain/models/funcionarios.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BeneficiosFuncionariosRepository{
  late DatabaseProvider databaseProvider;
  BeneficiosFuncionariosRepository(this.databaseProvider);

  Future<int> insert(BeneficiosFuncionarios entity) async {
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Beneficios_has_Funcionarios", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }
  }

  Future<int>  delete(BeneficiosFuncionarios entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Beneficios_has_Funcionarios", 
                  where : "id_beneficios_funcionarios = ?", 
                  whereArgs:  ["${entity.id_beneficios_funcionarios}"]);
  }

  Future<int>  deletebyfunc(Funcionario entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Beneficios_has_Funcionarios", 
                  where : "idFuncionarios = ?", 
                  whereArgs:  ["${entity.id}"]);
  }

  Future<int>  deletebyBene(Beneficio entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.delete("Beneficios_has_Funcionarios", 
                  where : "idBeneficios = ?", 
                  whereArgs:  ["${entity.idBeneficios}"]);
  }

  Future<int>  update(BeneficiosFuncionarios entity) async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    return await dt.update("Beneficios_has_Funcionarios",
                    entity.toMap(), 
                    where : "id_beneficios_funcionarios = ?", 
                  whereArgs:  [entity.id_beneficios_funcionarios]);
  }

  // Future<BeneficiosFuncionarios> findById(int Beneficios_idBeneficios, int Funcionarios_idFuncionarios) async{
  //   await databaseProvider.open();
  //   Database dt = databaseProvider.database;
  //   List<Map<String, Object?>> result = await dt.rawQuery(
  //     '''SELECT Beneficios.descricao as beneficio, Funcionarios.nome as funcionario  
  //         FROM Beneficios_has_Funcionarios as bf
  //         JOIN
  //         Beneficios  ON bf.Beneficios_idBeneficios = Beneficios.idBeneficios
  //         JOIN
  //         Funcionarios ON bf.Funcionarios_idFuncionarios = f.idFuncionarios;
  //         WHERE bf.Beneficios_idBeneficios = ${Beneficios_idBeneficios} AND bf.Funcionarios_idFuncionarios = ${Funcionarios_idFuncionarios};
  //     ''');
  //   //Se retornou resultados
  //   var beneficios_funcionarios = BeneficiosFuncionarios();
  //   if (result.isNotEmpty){
  //       Map<String, Object?> item = result[0];
  //       beneficios_funcionarios.descricao_beneficio = item["beneficio"] as String;
  //       beneficios_funcionarios.nome_funcionario = item["funcionario"] as String;
        
  //   }
  //   return beneficios_funcionarios;
  // }

  Future<List<BeneficiosFuncionarios>> findAll() async{
    await databaseProvider.open();
    Database dt = databaseProvider.database;
    List<Map<String, Object?>> result = await dt.rawQuery('''
SELECT bf.*,
      f.nome AS NomeFuncionario,
      b.descricao AS NomeBeneficio
FROM Beneficios_has_Funcionarios as bf
JOIN Funcionarios as f ON bf.idFuncionarios = f.idFuncionarios
JOIN Beneficios b ON bf.idBeneficios = b.idBeneficios;

''');
    
    List<BeneficiosFuncionarios> beneficiosFuncionariosresults = [];
    
    //Se retornou resultados
    if (result.isNotEmpty){
        for (int i = 0; i < result.length; i++){            
            Map<String, Object?> item = result[i];
            //Convertendo um Map para o objeto apropriado
            BeneficiosFuncionarios beneficiosFuncionarios = BeneficiosFuncionarios.fromMap(item);
            beneficiosFuncionariosresults.add(beneficiosFuncionarios);
        }
    }
     
    return beneficiosFuncionariosresults;
  }  

}