import 'package:flutter/material.dart';
import 'package:projeto_ap1/data/userData.dart';
import 'package:projeto_ap1/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditUserScreen extends StatefulWidget {
final UserData usuario;
  const EditUserScreen({Key key, this.usuario}): super(key: key);
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cpfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.usuario.nome;
    _emailController.text = widget.usuario.email;
    _cpfController.text = widget.usuario.cpf;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Editar Usuário"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context,child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        hintText: "Nome"
                    ),
                    validator: (text){
                      if(text.isEmpty)
                        return "Nome inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(
                        hintText: "CPF"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (text){
                      if(text.isEmpty)
                        return "Nome inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text("Salvar",
                          style: TextStyle(fontSize: 10.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(_formKey.currentState.validate()){

                          }

                          Map<String, dynamic> userData = {
                            "name" : _nameController.text,
                            "cpf" : _cpfController.text,
                            "email": _emailController.text
                          };

                          model.updateUsuario(
                              usuarioData: userData,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário editado com sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.pop(context);
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao editar o usuário!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
    );
  }
}