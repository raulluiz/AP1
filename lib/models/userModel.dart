import 'package:flutter/material.dart';
import 'package:projeto_ap1/data/userData.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';

class UsuarioModel extends Model {
  String _nome = "";
  String _token = "";
  String _idUsuario = "";
  bool _isLoading = false;
  UserData _userData;

  String get nome => _nome;
  String get token => _token;
  String get idUsuario => _idUsuario;
  bool get isLoading => _isLoading;
  UserData get userApp => _userData;

  static UsuarioModel of(BuildContext context) =>
      ScopedModel.of<UsuarioModel>(context);

  // Future<dynamic> _getUser(login, senha) async {
  //   //logic for fetching remote data
  //   HttpClient httpClient = new HttpClient();
  //   HttpClientRequest request = await httpClient
  //       .postUrl(Uri.parse("http://postosobcontrole.com/api/Login"));
  //   request.headers.set('content-type', 'application/json');

  //   Map map = {'login': login, 'password': senha};

  //   request.add(utf8.encode(json.encode(map)));
  //   HttpClientResponse response = await request.close();
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }

  Future parseUserFromResponse(
      {@required String login,
      @required String senha,
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

    var results = await conn.query(
        "select * from usuario where email = '$login' and senha='$senha'");

    await conn.close();

    var usuario = results.first.fields;
    //UserData(data)
    if (results.length <= 1) {
      _userData = UserData(usuario);
      onSuccess();
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<String> apiRequest(String url, String login, String senha) async {
    var response =
        await http.post(url, body: {'login': login, 'password': senha});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body.toString();
  }

  Future<void> signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
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
        "INSERT INTO usuario (nome,cpf,email,senha)VALUES ('${userData["name"]}','${userData["cpf"]}', '${userData["email"]}','$pass')");

    // Finally, close the connection
    await conn.close();

    _isLoading = false;
    notifyListeners();
    onSuccess();
  }

  Future<void> updateUsuario(
      {@required Map<String, dynamic> usuarioData,
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
        "update usuario set "+
        "nome = '${usuarioData["nome"]}', "+
        "cpf = '${usuarioData["cpf"]}', "+
        "email = '${usuarioData["email"]}' " +
        "where id = ${usuarioData["id"]}");

    // Finally, close the connection
    await conn.close();

    _isLoading = false;
    notifyListeners();
    onSuccess();
  }
}
