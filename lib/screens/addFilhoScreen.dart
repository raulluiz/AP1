import 'package:flutter/material.dart';
import 'package:projeto_ap1/models/filhoModel.dart';
import 'package:projeto_ap1/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddFilhoScreen extends StatefulWidget {
  @override
  _AddFilhoScreenState createState() => _AddFilhoScreenState();
}

class _AddFilhoScreenState extends State<AddFilhoScreen> {
  final _nameController = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _estado = TextEditingController();
  final _cidade = TextEditingController();
  final _bairro = TextEditingController();
  final _numeroSus = TextEditingController();
  final _cpfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Adicionar Criança"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome"),
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(hintText: "CPF"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty) return "CPF inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _dataNascimento,
                    decoration: InputDecoration(hintText: "Data de Nascimento"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _estado,
                    decoration: InputDecoration(hintText: "Estado"),
                    validator: (text) {
                      if (text.isEmpty) return "Estado inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _cidade,
                    decoration: InputDecoration(hintText: "Cidade"),
                    validator: (text) {
                      if (text.isEmpty) return "Cidade inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _bairro,
                    decoration: InputDecoration(hintText: "Bairro"),
                    validator: (text) {
                      if (text.isEmpty) return "Bairro inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _numeroSus,
                    decoration: InputDecoration(hintText: "Número do SUS"),
                    validator: (text) {
                      if (text.isEmpty) return "Número do SUS inválido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text(
                          "Adicionar Filho",
                          style: TextStyle(fontSize: 10.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {}

                          Map<String, dynamic> filhoData = {
                            "nome": _nameController.text,
                            "cpf": _cpfController.text,
                            "dataNascimento": _dataNascimento.text,
                            "estado": _estado.text,
                            "cidade": _cidade.text,
                            "bairro": _bairro.text,
                            "numeroSus": _numeroSus.text
                          };

                          FilhoModel filho = new FilhoModel();
                          filho.addFilho(
                              filhoData: filhoData,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Filho cadastrado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pop(context);
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar filho!"),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
