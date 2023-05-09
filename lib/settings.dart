import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const jsonFilePath = 'assets/menu_items.json';
const storageKey = 'menuItems';

/// Class that holds information about the possible tile icon
class MenuItemInfoIcon {
  late final int? code;
  late final String? emoji;
  late final String? url;
  late final String? colour;

  MenuItemInfoIcon({this.code, this.emoji, this.url, this.colour});

  MenuItemInfoIcon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    emoji = json['emoji'];
    url = json['url'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['emoji'] = emoji;
    data['url'] = url;
    data['colour'] = colour;

    return data;
  }
}

/// Class holding the information of the tile
class MenuItemInfo {
  late int id;
  late int indexInLevel;
  late String title;
  late Color textColor;
  late MenuItemInfoIcon? _icon;
  late List<MenuItemInfo> tiles;

  MenuItemInfo({required this.id, required this.title, this.tiles = const []});

  /// Converts a [hexString] to a Color.
  /// Color white is returned by default.
  Color _hexToColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return const Color(0xFFFFFFFF);
    }
  }

  /// Gets the icon widget of the tile.
  /// The priority of the icon retrieved is by:
  /// 1 - the `code` field.
  /// 2 - the `emoji` field.
  /// 3 - the `url` field.
  /// If there is no icon, the `null` is returned.
  Widget? getIcon() {
    bool iconExists = _icon != null;

    // Check if any icon information exists
    if (iconExists) {

      // Icon parameters
      int? iconCode = _icon?.code;
      String? emojiText = _icon?.emoji;
      String? imageUrl = _icon?.url;
      String? colourHex = _icon?.colour;

      // Icon colour
      Color colour = _hexToColor(colourHex!);

      if (iconCode != null) {
        return Icon(
          IconData(iconCode, fontFamily: 'MaterialIcons'),
          color: colour,
        );
      }

      if (emojiText != null) {
        return Text(emojiText.toString(), style: TextStyle(color: colour, fontSize: 30));
      }

      if(imageUrl != null) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Image.network(imageUrl, fit: BoxFit.fitHeight, height: 64));
      }
    } 
    
    // If there's no icon information, return null
    else {
      return null;
    }
  }

  /// Converts `json` text to BasicTile
  MenuItemInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexInLevel = json['index_in_level'];
    title = json['title'];
    textColor = _hexToColor(json['text_color']);

    // Decoding `tiles` field
    if (json['tiles'] != null) {
      tiles = [];
      json['tiles'].forEach((v) {
        tiles.add(MenuItemInfo.fromJson(v));
      });
    }

    _icon = null;
    // Decoding `icon` field
    if (json['icon'] != null) {
      _icon = MenuItemInfoIcon.fromJson(json['icon']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['index_in_level'] = indexInLevel;
    data['title'] = title;
    data['text_color'] = '#${textColor.value.toRadixString(16)}';

    // Adding `tiles` field
    if (tiles.isNotEmpty) {
      data['tiles'] = tiles.map((v) => v.toJson()).toList();
    } else {
      data['tiles'] = [];
    }

    // Adding `icon` field
    if (_icon != null) {
      data['icon'] = _icon!.toJson();
    }

    return data;
  }
}

/// Loads the menu items from local storage.
/// If none is found, it loads the menu items from `.json` file.
/// Returns a `MenuItemInfo` menu list.
Future<List<MenuItemInfo>> loadMenuItems() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove(storageKey);

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
