import 'package:flutter/material.dart';
import 'package:projeto_ap1/widget/customDrawer.dart';

import 'addFilhoScreen.dart';
import 'addUsuarios.dart';
import 'filhosScreen.dart';
import 'usuariosScreen.dart';

class MenuScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Usuários"),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUserScreen()),
                      );
                    }),
              )
            ],
          ),
          body: ListaUsuarios(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Crianças"),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFilhoScreen()),
                      );
                    }),
              )
            ],
          ),
          body: ListaFilhos(),
          drawer: CustomDrawer(_pageController),
        ),
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text("Dashboard"),
        //     centerTitle: true,
        //   ),
        //   drawer: CustomDrawer(_pageController),
        //   body: ChartScreen(),
        // )
      ],
    );
  }
}
