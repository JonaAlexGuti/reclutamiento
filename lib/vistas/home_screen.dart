import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclutamiento/vistas/pokemon_like.dart';

import 'package:reclutamiento/widgets/home_drawer.dart';
import 'package:reclutamiento/widgets/user_controller.dart';

import 'list_pokemons.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  late Widget screenView;
  late DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = ListarPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white70,
          body: DrawerUserController(
            menuView: buttonMenu(),
            drawerIsOpen: (bool ) {  },
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
            screenIndex: drawerIndex,

          ),
          ),
        ),
    );
  }

  Widget buttonMenu(){
    return SizedBox(
      height: 30,
      width: 30,
      child: Image.asset('assets/images/icons8-slider-50.png'),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;

      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = ListarPokemons();
        });
      } else if (drawerIndex == DrawerIndex.FAV) {
        setState(() {
         screenView = LikePokemons();
        });
      }
    }
  }
}

