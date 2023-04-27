import 'package:flutter/material.dart';

import 'pages.dart';
import 'tiles.dart';

const drawerMenuKey = Key("drawer_menu");
const todoTileKey = Key("todo_tile");
const tourTileKey = Key("tour_tile");
const settingsTileKey = Key("settings_tile");

const closeMenuKey = Key("close_key_icon");

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerMenuKey,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ),
          actions: [
            IconButton(
              key: closeMenuKey,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.menu_open,
                color: Colors.white,
              ),
            ),
          ]),
      body: Container(
          color: Colors.black,
          child: ListView(
              key: todoTileKey,
              padding: const EdgeInsets.only(top: 32),
              children: mockTilesData
                  .map(
                    (tile) => MenuItem(tile: tile),
                  )
                  .toList())),
    );
  }
}
