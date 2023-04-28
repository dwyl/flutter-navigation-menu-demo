import 'dart:convert';

import 'package:flutter/services.dart';

import 'tiles.dart';

mixin SettingsManagerMixin {
  final jsonFilePath = 'assets/menu_items.json';


  /// Loads the MenuItemInfo list from the json file
  Future<List<MenuItemInfo>> loadMenuItems() async {
    // Get string from json
    final String response = await rootBundle.loadString(jsonFilePath);
    List<dynamic> data = await json.decode(response);

    // Converting json to list of MenuItemInfo objects
    final List<MenuItemInfo> menuItems = data.map((obj) => MenuItemInfo.fromJson(obj)).toList();

    // Return the MenuItemInfo list
    return menuItems;
  }


  

}
