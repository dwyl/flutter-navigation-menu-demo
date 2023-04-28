import 'package:flutter/material.dart';

import 'tiles.dart';
import 'settings.dart';

const drawerMenuKey = Key("drawer_menu");
const tourTileKey = Key("tour_tile");
const settingsTileKey = Key("settings_tile");

const closeMenuKey = Key("close_key_icon");

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> with SettingsManagerMixin {
  late Future<List<MenuItemInfo>> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = loadMenuItems();
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
          
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: Colors.black,
                child: FutureBuilder<List<MenuItemInfo>>(
                    future: menuItems,
                    builder: (BuildContext context, AsyncSnapshot<List<MenuItemInfo>> snapshot) {
                      // If the data is correctly loaded,
                      // we render a `ReorderableListView` whose children are `MenuItem` tiles.
                      if (snapshot.hasData) {
                        List<MenuItemInfo> menuItemInfoList = snapshot.data!;
          
                        return DrawerMenuTilesList(menuItemInfoList: menuItemInfoList);
                      }
          
                      // While it's not loaded (error or waiting)
                      else {
                        return const SizedBox.shrink();
                      }
                    })),
          ),
        ],
      ),
    );
  }
}
