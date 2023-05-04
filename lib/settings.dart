import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tiles.dart';

const jsonFilePath = 'assets/menu_items.json';
const storageKey = 'menuItems';

/// Loads the menu items from local storage.
/// If none is found, it loads the menu items from `.json` file.
/// Returns a `MenuItemInfo` menu list.
Future<List<MenuItemInfo>> loadMenuItems() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  //await prefs.remove(storageKey);

  final String? jsonStringFromLocalStorage = prefs.getString(storageKey);

  String jsonString;
  // If local storage has content, return it.
  if (jsonStringFromLocalStorage != null) {
    jsonString = jsonStringFromLocalStorage;
  }

  // If not, we initialize it
  else {
    // Setting local storage key with json string from file
    final String jsonStringFromFile = await rootBundle.loadString(jsonFilePath);
    prefs.setString(storageKey, jsonStringFromFile);

    jsonString = jsonStringFromFile;
  }

  // Converting json to list of MenuItemInfo objects
  List<dynamic> data = await json.decode(jsonString);
  final List<MenuItemInfo> menuItems = data.map((obj) => MenuItemInfo.fromJson(obj)).toList();

  // Return the MenuItemInfo list
  return menuItems;
}

/// Updates the root menu item list [menuItems] in shared preferences.
updateRootObjectsInPreferences(List<MenuItemInfo> menuItems) async {
  final jsonString = json.encode(menuItems);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(storageKey, jsonString);
}

/// Update deeply nested menu item [item] with a new [updatedChildren] in shared preferences.
updateDeeplyNestedObjectInPreferences(MenuItemInfo itemToUpdate, List<MenuItemInfo> updatedChildren) async {
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

  // Saving updated menu items encoded to json string.
  final jsonString = json.encode(menuItems);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(storageKey, jsonString);
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
