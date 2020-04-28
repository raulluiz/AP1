import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:projeto_ap1/data/userData.dart';
import 'package:projeto_ap1/models/userModel.dart';

import 'updateUsuarioScreen.dart';

class ListaUsuarios extends StatelessWidget {
    final UserData user;

    ListaUsuarios({Key key, this.user}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<UserData>>(
        future: _getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserData> data = snapshot.data;
            return _jobsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      );
  }
}

Future<List<UserData>> _getUsuarios() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    var results = await conn.query(
        "select * from usuario");

    await conn.close();
    List<UserData> usuarios = new List<UserData>();
    for (var item in results) {
      var user = UserData(item.fields);
      // user.id = row.[0];
      // user.nome = row[1];
      // user.cpf = row[2];
      // user.email = row[3];
      usuarios.add(user);
    }

    return usuarios;
}


ListView _jobsListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>EditUserScreen(usuario: data[index]))
            );
          },
          child: Card(
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  child: _tile2(data[index].id.toString(), data[index].nome,data[index].cpf.toString(),"teste", Icons.work, context)
              )
          ),
        );
      });
}

ListTile _tile2(String id, String nomeCliente,String data, String status, IconData icon, BuildContext context) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 2.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Text(id,style: TextStyle(color: Colors.white),),
    ),
    title: Text(
      nomeCliente,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      data,
      style: TextStyle(color: Colors.white),
    ),
    trailing: InkWell(
      onTap: () {
        showDialog(
            context: context,
            child: new AlertDialog(
              title: const Text("Deseja remover esse item?"),
              content: const Text(
                  "teste"),
              actions: [
                new FlatButton(
                  child: const Text("Ok"),
                  onPressed: (){
                    Deletar(id);
                  }),
              ],
            ),
        );
          Deletar(id);
          
      },
      child: Icon(Icons.delete, color: Colors.white,),
    )
);

Future<void> Deletar(String id) async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    // Create a table
    await conn.query(
        "DELETE FROM usuario WHERE id = $id;");

    // Finally, close the connection
    await conn.close();
}
//Icon(Icons.delete, color: Colors.white,)