import 'package:flutter/material.dart';

/// Class holding the information of the tile
class BasicTile {
  final String title;
  final List<BasicTile> tiles;

  BasicTile({required this.title, this.tiles = const []});
}

/// Custom tile class that expands if there are child tiles or not.
class MenuItem extends StatefulWidget {
  final BasicTile tile;
  final double leftPadding;

  const MenuItem({super.key, required this.tile, this.leftPadding = 16});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // If the tile's children is empty, we render the leaf tile
    if (widget.tile.tiles.isEmpty) {
      return ListTile(
          contentPadding: EdgeInsets.only(left: widget.leftPadding),
          title: Text(widget.tile.title,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              )));
    }

    // If the tile has children, we render this as an expandable tile.
    else {
      return ExpansionTile(
        tilePadding: EdgeInsets.only(left: widget.leftPadding),
        title: Text(widget.tile.title,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            )),
        trailing: Icon(
          _expanded ? Icons.expand_less : Icons.arrow_drop_down,
          color: Colors.white,
        ),
        children: widget.tile.tiles.map((tile) => MenuItem(tile: tile, leftPadding: widget.leftPadding + 16)).toList(),
        onExpansionChanged: (bool expanded) {
          setState(() => _expanded = expanded);
        },
      );
    }
  }
}

/// Mock data.
final mockTilesData = <BasicTile>[
  BasicTile(title: "People", tiles: [
    BasicTile(title: "Online Now", tiles: [
      BasicTile(title: "Family"),
      BasicTile(title: "Friends", tiles: [
        BasicTile(title: "Sports Team"),
        BasicTile(title: "Gamerz"),
      ]),
      BasicTile(title: "Work")
    ]),
    BasicTile(title: "Everyone")
  ])
];
