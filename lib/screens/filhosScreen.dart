import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:projeto_ap1/data/filhosData.dart';
import 'package:projeto_ap1/models/userModel.dart';

import 'updateFilhoScreen.dart';

class ListaFilhos extends StatelessWidget {
    final FilhosData filho;

    ListaFilhos({Key key, this.filho}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<FilhosData>>(
        future: _getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FilhosData> data = snapshot.data;
            return _jobsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      );
  }
}

Future<List<FilhosData>> _getUsuarios() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'jbraz300_raul',
        password: 'Qu@lquer1',
        db: 'jbraz300_ap1'));

    var results = await conn.query(
        "select * from filho");

    await conn.close();
    List<FilhosData> filhos = new List<FilhosData>();
    for (var item in results) {
      var user = FilhosData(item.fields);
      filhos.add(user);
    }

    return filhos;
}


ListView _jobsListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){

            var tst = data;
            var ind = index;
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>UpdateFilhoScreen(filho: data[index]))
            );
          },
          child: Card(
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  child: _tile2(data[index].id.toString(), data[index].nome,data[index].dataNascimento.toString(), context)
              )
          ),
        );
      });
}

ListTile _tile2(String id, String nome,String data, BuildContext context) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 2.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Text(id,style: TextStyle(color: Colors.white),),
    ),
    title: Text(
      nome,
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
                  ""),
              actions: [
                new FlatButton(
                  child: const Text("Ok"),
                  onPressed: (){
                    Deletar(id);
                    Navigator.pop(context);
                  }),
              ],
            ),
        );          
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
        "DELETE FROM filho WHERE id = $id;");

    // Finally, close the connection
    await conn.close();
}
//Icon(Icons.delete, color: Colors.white,)