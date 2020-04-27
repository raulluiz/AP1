import 'package:flutter/material.dart';
import 'package:projeto_ap1/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

// import 'Cliente/chamado_screen.dart';
// import 'Tecnico/chamadoTecnico_screen.dart';
// import 'Terceirizada/menu_screen.dart';
import 'signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UsuarioModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UsuarioModel>( //UserModel
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty)
                        return "Usuário inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty)
                        return "Senha inválida!";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){
                        if(_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Insira seu e-mail para recuperação!"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              )
                          );

                        /*else{
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Confira se email!"),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(seconds: 2),
                              )
                          );
                        }*/

                      },
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                        child: Text("Entrar",
                          style: TextStyle(fontSize: 10.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                          }
                          user = model;
                          model.parseUserFromResponse(
                              login: _emailController.text,
                              senha: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);



                          /*model.signIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );*/
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
    Navigator.of(context).pop();
    print("-----------Flutter App Raul-------------");
    Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ChamadoClienteScreen()) //ChamadoClienteScreen
      );

    //var perfil = user.userApp.perfil;
    // if(perfil == "5" || perfil == "6") //Cliente
    // {
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context)=>ChamadoClienteScreen()) //ChamadoClienteScreen
    //   );
    // }
    // else if(perfil == "1") //Administrador
    //   {
    //     Navigator.of(context).push(
    //         MaterialPageRoute(builder: (context)=>ChamadoClienteScreen()) //MenuScreen
    //     );
    //   }
    // else if(perfil == "4") //Técnico
    // {
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (context)=>ChamadoTecnicoScreen()) //MenuScreen
    //   );
    // }

  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao entrar!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
    );
  }

}