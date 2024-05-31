import 'dart:io';

import 'package:flutter/services.dart';
import 'package:inventar/Model/lingua_model.dart';
import 'package:inventar/Model/publicacao_model.dart';
import 'package:inventar/Model/tipo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> abrirBancoDeDados() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');

    bool existe = await databaseExists(path);

    if (!existe) {
      ByteData data = await rootBundle.load(join('assets', 'my_database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path);
  }

  Future<List<LinguaModel>> buscarLinguas() async {
    Database db = await abrirBancoDeDados();

    List<Map<String, dynamic>> resultado = await db.query('lingua');

    List<LinguaModel> linguas =
        resultado.map((map) => LinguaModel.fromMap(map)).toList();
    await db.close();

    return linguas;
  }

  Future<List<TipoModel>> buscarTipos() async {
    Database db = await abrirBancoDeDados();

    List<Map<String, dynamic>> resultado = await db.query('Tipo');

    List<TipoModel> tipos =
        resultado.map((map) => TipoModel.fromMap(map)).toList();
    await db.close();

    return tipos;
  }

  Future<List<PublicacaoModel>> buscarPublicacoes() async {
    Database db = await abrirBancoDeDados();

    List<Map<String, dynamic>> resultado = await db.query('Publicacao');

    List<PublicacaoModel> publicacoes =
        resultado.map((map) => PublicacaoModel.fromMap(map)).toList();
    await db.close();

    return publicacoes;
  }
}
