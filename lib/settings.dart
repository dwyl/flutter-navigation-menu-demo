import 'dart:convert';

import 'package:flutter/services.dart';

import 'tiles.dart';

mixin SettingsManagerMixin {
  final jsonFilePath = 'assets/menu_items.json';

  /// Returns the `MenuItemInfo` menu list from the `.json` file
  Future<List<MenuItemInfo>> loadMenuItems() async {
    // Get string from json
    final String response = await rootBundle.loadString(jsonFilePath);
    List<dynamic> data = await json.decode(response);

    // Converting json to list of MenuItemInfo objects
    final List<MenuItemInfo> menuItems = data.map((obj) => MenuItemInfo.fromJson(obj)).toList();

    // Return the MenuItemInfo list
    return menuItems;
  }

  /// Update deeply nested menu item [item] with a new [updatedChildren].
  updateDeeplyNestedObjectInJson(MenuItemInfo itemToUpdate, List<MenuItemInfo> updatedChildren) async {
    // Fetch the menu items from `.json` file
    List<MenuItemInfo> menuItems = await loadMenuItems();

    // Go over the root items list and find & update the object with new children
    MenuItemInfo? updatedItem;
    for (var item in menuItems) {
      updatedItem = _findAndUpdateMenuItem(item, itemToUpdate.id, updatedChildren);
      if (updatedItem != null) {
        break;
      }
    }

    // Updated json string
    final jsonString = json.encode(menuItems);

    return null;
  }


  /// Recursively finds the deeply nested object from a given menu item id [id]
  /// and updates its `tiles` field with [updatedChildren].
  ///
  /// Returns the updated `MenuItemInfo` menu item.
  /// Returns `null` if no `MenuitemInfo` was found with the given [id].
  MenuItemInfo? _findAndUpdateMenuItem(MenuItemInfo item, int id, List<MenuItemInfo> updatedChildren) {
    // Breaking case
    if (item.id == id) {
      item.tiles = updatedChildren;
      return item;
    }

    // Continue searching
    else {
      final children = item.tiles;
      MenuItemInfo? ret;
      for (MenuItemInfo child in children) {
        ret = _findAndUpdateMenuItem(child, id, updatedChildren);
        if (ret != null) {
          break;
        }
      }
      return ret;
    }
  }
}
