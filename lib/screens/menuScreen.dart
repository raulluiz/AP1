import 'package:flutter/material.dart';
import 'package:projeto_ap1/widget/customDrawer.dart';

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
            title: Text(""),
            centerTitle: true,
          ),
          body: ListaUsuarios(),
          drawer: CustomDrawer(_pageController),
        ),
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text("Chamado / Preventiva"),
        //     centerTitle: true,
        //   ),
        //   body: ChamadoPreventivaScreen(),
        //   drawer: CustomDrawer(_pageController),
        // ),
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
