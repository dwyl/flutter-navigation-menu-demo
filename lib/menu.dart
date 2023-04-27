import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages.dart';
import 'tiles.dart';

const drawerMenuKey = Key("drawer_menu");
const todoTileKey = Key("todo_tile");
const tourTileKey = Key("tour_tile");
const settingsTileKey = Key("settings_tile");

const closeMenuKey = Key("close_key_icon");

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  Future<List<MenuItemInfo>> _loadMenuItems() async {
    final String response = await rootBundle.loadString('assets/menu_items.json');
    List<dynamic> data = await json.decode(response);

    final List<MenuItemInfo> menuItems = data.map((obj) => MenuItemInfo.fromJson(obj)).toList();

    return menuItems;
  }

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
          child: FutureBuilder<List<MenuItemInfo>>(
              future: _loadMenuItems(),
              builder: (BuildContext context, AsyncSnapshot<List<MenuItemInfo>> snapshot) {
                // If the data is correctly loaded
                if (snapshot.hasData) {
                  return ListView(
                      key: todoTileKey,
                      padding: const EdgeInsets.only(top: 32),
                      children: snapshot.data!
                          .map(
                            (tile) => MenuItem(info: tile),
                          )
                          .toList());
                }

                // While it's not loaded (error or waiting)
                else {
                  return const SizedBox.shrink();
                }
              })),
    );
  }
}
