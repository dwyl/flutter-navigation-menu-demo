import 'dart:ui';

import 'package:flutter/material.dart';

import 'settings.dart';

/// Proxy decorator function that overrides the background color
/// of the hovered menu item.
/// See https://github.com/flutter/flutter/issues/45799.
Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(0, 6, animValue)!;
      return Material(
        elevation: elevation,
        color: const Color.fromARGB(255, 76, 76, 76),
        child: child,
      );
    },
    child: child,
  );
}

// Widget with the list of Menu Item tiles
class DynamicMenuTilesList extends StatefulWidget {
  final List<MenuItemInfo> menuItemInfoList;

  const DynamicMenuTilesList({super.key, required this.menuItemInfoList});

  @override
  State<DynamicMenuTilesList> createState() => _DynamicMenuTilesListState();
}

class _DynamicMenuTilesListState extends State<DynamicMenuTilesList> {
  late List<MenuItemInfo> menuItemInfoList;

  @override
  void initState() {
    super.initState();
    menuItemInfoList = widget.menuItemInfoList;
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

    // update the `indexInLevel` field of each item to be in order
    menuItemInfoList.asMap().forEach((index, value) => value.indexInLevel = index);

    // Update state
    setState(() {
      menuItemInfoList = menuItemInfoList;
    });

    // update the menu item object with updated children in the `json` file.
    updateRootObjectsInPreferences(menuItemInfoList);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        shrinkWrap: true,
        // https://stackoverflow.com/questions/56726298/nesting-reorderable-lists
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 32),
        proxyDecorator: _proxyDecorator,
        onReorder: (oldIndex, newIndex) => _reorderTiles(oldIndex, newIndex, menuItemInfoList),
        children: menuItemInfoList
            .map(
              (tile) => MenuItem(key: ValueKey(tile.id), info: tile),
            )
            .toList()
          ..sort((a, b) => a.info.indexInLevel.compareTo(b.info.indexInLevel)));
  }
}

/// Widget that expands if there are child tiles or not.
class MenuItem extends StatefulWidget {
  // https://stackoverflow.com/questions/59444423/reorderablelistview-does-not-identify-keys-in-custom-widget
  final Key key;
  final MenuItemInfo info;
  final double leftPadding;

  const MenuItem({required this.key, required this.info, this.leftPadding = 16}) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _expanded = false;

  late List<MenuItemInfo> childrenMenuItemInfoList;

  @override
  void initState() {
    super.initState();
    childrenMenuItemInfoList = widget.info.tiles;
  }

  /// Callback function that reorders the tiles
  void _reorderTiles(int oldIndex, int newIndex, MenuItemInfo menuItemInfo) {
    List<MenuItemInfo> menuItemInfoList = menuItemInfo.tiles;

    // an adjustment is needed when moving the tile down the list
    if (oldIndex < newIndex) {
      newIndex--;
    }

    // get the tile we are moving
    final tile = menuItemInfoList.removeAt(oldIndex);

    // place the tile in the new position
    menuItemInfoList.insert(newIndex, tile);

    // update the `indexInLevel` field of each item to be in order
    menuItemInfoList.asMap().forEach((index, value) => value.indexInLevel = index);

    // Update state
    setState(() {
      menuItemInfoList = menuItemInfoList;
    });

    // update the menu item object with updated children in the `json` file.
    updateDeeplyNestedObjectInPreferences(menuItemInfo, menuItemInfoList);
  }

  @override
  Widget build(BuildContext context) {
    // If the tile's children is empty, we render the leaf tile
    if (childrenMenuItemInfoList.isEmpty) {
      return Container(
        key: widget.key,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
        child: ListTile(
            contentPadding: EdgeInsets.only(left: widget.leftPadding),
            title: Text(widget.info.title,
                style: TextStyle(
                  fontSize: 25,
                  color: widget.info.textColor,
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
              style: TextStyle(
                fontSize: 25,
                color: widget.info.textColor,
              )),
          trailing: Icon(
            _expanded ? Icons.expand_less : Icons.arrow_drop_down,
            color: Colors.white,
          ),
          children: [
            ReorderableListView(
              // https://stackoverflow.com/questions/56726298/nesting-reorderable-lists
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              proxyDecorator: _proxyDecorator,
              onReorder: (oldIndex, newIndex) => _reorderTiles(oldIndex, newIndex, widget.info),
              children: childrenMenuItemInfoList.map((tile) => MenuItem(key: ValueKey(tile.id), info: tile, leftPadding: widget.leftPadding + 16)).toList()
                ..sort((a, b) => a.info.indexInLevel.compareTo(b.info.indexInLevel)),
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
