import 'package:flutter/material.dart';
import 'package:projeto_ap1/data/filhosData.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mysql1/mysql1.dart';

class FilhoModel extends Model {
  String _nome = "";
  String _idUsuario = "";
  bool _isLoading = false;
  FilhosData _filhoData;

  String get nome => _nome;
  String get idUsuario => _idUsuario;
  bool get isLoading => _isLoading;
  FilhosData get userApp => _filhoData;

  Future<void> addFilho(
      {@required Map<String, dynamic> filhoData,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    _isLoading = true;
    notifyListeners();
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    // Create a table
    await conn.query(
        "INSERT INTO filho (nome,cpf,dataNascimento,estado,cidade,bairro,numeroSus)VALUES ('${filhoData["nome"]}','${filhoData["cpf"]}', '${filhoData["dataNascimento"]}" +
        "','${filhoData["estado"]}','${filhoData["cidade"]}','${filhoData["bairro"]}','${filhoData["numeroSus"]}')");
    // Finally, close the connection
    await conn.close();

    _isLoading = false;
    notifyListeners();
    onSuccess();
  }

  Future<void> updateFilho(
      {@required Map<String, dynamic> filhoData,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    _isLoading = true;
    notifyListeners();
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    // Create a table
    await conn.query(
        "update filho set "+
        "nome = '${filhoData["nome"]}', "+
        "cpf = '${filhoData["cpf"]}', "+
        "dataNascimento = '${filhoData["dataNascimento"]}', " +
        "estado = '${filhoData["estado"]}', "+
        "cidade = '${filhoData["cidade"]}', "+
        "bairro = '${filhoData["bairro"]}', "+
        "numeroSus = '${filhoData["numeroSus"]}' "+
        "where id = ${filhoData["id"]}");

    // Finally, close the connection
    await conn.close();

    _isLoading = false;
    notifyListeners();
    onSuccess();
  }

  Future<FilhosData> editPageFilho({@required int idFilho}) async {
    _isLoading = true;
    notifyListeners();
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    // Create a table
    var results = await conn.query(
        "select * from filho where id = $idFilho");

    // Finally, close the connection
    await conn.close();

    _isLoading = false;
    notifyListeners();
    FilhosData filho = new FilhosData(results.first.fields);
    return filho;
  }
}
