import 'package:flutter/material.dart';

/// Class holding the information of the tile
class MenuItemInfo {
  late String title;
  late List<MenuItemInfo> tiles;

  MenuItemInfo({required this.title, this.tiles = const []});

  /// Converts `json` text to BasicTile
  MenuItemInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['tiles'] != null) {
      tiles = [];
      json['tiles'].forEach((v) {
        tiles.add(MenuItemInfo.fromJson(v));
      });
    }
  }
}

/// Custom tile class that expands if there are child tiles or not.
class MenuItem extends StatefulWidget {
  final MenuItemInfo info;
  final double leftPadding;

  const MenuItem({super.key, required this.info, this.leftPadding = 16});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // If the tile's children is empty, we render the leaf tile
    if (widget.info.tiles.isEmpty) {
      return ListTile(
          contentPadding: EdgeInsets.only(left: widget.leftPadding),
          title: Text(widget.info.title,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              )));
    }

    // If the tile has children, we render this as an expandable tile.
    else {
      return ExpansionTile(
        tilePadding: EdgeInsets.only(left: widget.leftPadding),
        title: Text(widget.info.title,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
        trailing: Icon(
          _expanded ? Icons.expand_less : Icons.arrow_drop_down,
          color: Colors.white,
        ),
        children: widget.info.tiles.map((tile) => MenuItem(info: tile, leftPadding: widget.leftPadding + 16)).toList(),
        onExpansionChanged: (bool expanded) {
          setState(() => _expanded = expanded);
        },
      );
    }
  }
}
