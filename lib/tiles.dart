import 'package:flutter/material.dart';

/// Class holding the information of the tile
class MenuItemInfo {
  late int id;
  late int indexInLevel;
  late String title;
  late List<MenuItemInfo> tiles;

  MenuItemInfo({required this.id, required this.title, this.tiles = const []});

  /// Converts `json` text to BasicTile
  MenuItemInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexInLevel = json['index_in_level'];
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
  final Key key;
  final MenuItemInfo info;
  final double leftPadding;

  const MenuItem({required this.key, required this.info, this.leftPadding = 16}) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _expanded = false;
  
  late List<MenuItemInfo> menuItemInfoList;

  @override
  void initState() {
    super.initState();
    menuItemInfoList = widget.info.tiles;
  }

  /// Callback function that reorders the tiles
  void _reorderTiles(int oldIndex, int newIndex, List<MenuItemInfo> menuItemInfoList) {
    // an adjustment is needed when moving the tile down the list
    if (oldIndex < newIndex) {
      newIndex--;
    }

    // get the tile we are moving
    final tile = menuItemInfoList.removeAt(oldIndex);

    // place the tile in the new position
    menuItemInfoList.insert(newIndex, tile);

    // Update state
    setState(() {
      menuItemInfoList = menuItemInfoList;
    });

    // TODO: update the JSON file (change index_at_level)
  }

  @override
  Widget build(BuildContext context) {
    // If the tile's children is empty, we render the leaf tile
    if (menuItemInfoList.isEmpty) {
      return Container(
        key: widget.key,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
        child: ListTile(
            contentPadding: EdgeInsets.only(left: widget.leftPadding),
            title: Text(widget.info.title,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ))),
      );
    }

    // If the tile has children, we render this as an expandable tile.
    else {
      return Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),

        // Rendering `ExpansionTile` which expands to render the children.
        // The children are rendered in a `ReorderableListView`
        // so they can be reordered on the same level.
        child: ExpansionTile(
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
          children: [
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) => _reorderTiles(oldIndex, newIndex, menuItemInfoList),
              children: menuItemInfoList.map((tile) => MenuItem(key: ValueKey(tile.id), info: tile,  leftPadding: widget.leftPadding + 16)).toList(),
            )
          ],
          onExpansionChanged: (bool expanded) {
            setState(() => _expanded = expanded);
          },
        ),
      );
    }
  }
}
