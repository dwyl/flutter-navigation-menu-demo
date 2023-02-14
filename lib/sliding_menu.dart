import 'package:flutter/material.dart';

class SlidingMenu extends StatefulWidget {
  const SlidingMenu({super.key});

  @override
  State<SlidingMenu> createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
        Text('This is the menu', style: TextStyle(color: Colors.white)),
      ])),
    );
  }
}
