import 'package:flutter/material.dart';
import 'package:projeto_ap1/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'drawerTile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241 ),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: Text("PostoApp",
                        style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UsuarioModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Olá, ${model.nome}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                GestureDetector(
                                  child: Text("Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: (){
                                    /*if(!model.isLoggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>LoginScreen())
                                      );
                                    else
                                      model.signOut();*/
                                  },
                                )
                              ],
                            );
                          },
                        )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.supervisor_account, "Usuários",pageController,0),
              DrawerTile(Icons.assignment, "Chamado/Preventiva",pageController,1),
              DrawerTile(Icons.show_chart, "Dashboard",pageController,2),
              //DrawerTile(Icons.perm_identity, "Cliente",pageController,2),
              //DrawerTile(Icons.playlist_add_check, "Meus Pedidos",pageController,3)
            ],
          )
        ],
      ),
    );
  }
}
