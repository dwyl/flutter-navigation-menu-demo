import 'package:flutter/material.dart';

import 'main.dart';
import 'pages.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.menu_open,
                color: Colors.white,
              ),
            ),
          ]),
      body: Container(
          color: Colors.black,
          child: ListView(padding: const EdgeInsets.only(top: 32), children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white), top: BorderSide(color: Colors.white))),
              child: ListTile(
                leading: const Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                title: const Text('Todo List (Personal)',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
                onTap: () {
                  // Do nothing
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: ListTile(
                leading: const Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                title: const Text('Feature Tour',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TourPage()),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
                title: const Text('Settings',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ),
          ])),
    );
  }
}
