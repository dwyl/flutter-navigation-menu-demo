import 'package:flutter/material.dart';

import 'menu.dart';

const iconKey = Key("menu_icon");
const todoItemKey = Key("todo_item");
const homePageKey = Key("home_page");

// coverage:ignore-start
void main() {
  runApp(const App());
}
// coverage:ignore-end 

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Flutter Menu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool showMenu = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpeg"),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showMenu,
            child: IconButton(
              key: iconKey,
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Center(
        key: homePageKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the main page",
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Check the todo item below to open the menu above to check more pages.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ListTile(
              key: todoItemKey,
              title: Text(
                'check this todo item',
                style: TextStyle(decoration: showMenu ? TextDecoration.lineThrough : TextDecoration.none),
              ),
              minVerticalPadding: 25.0,
              tileColor: Colors.black12,
              onTap: () {
                setState(() {
                  showMenu = true;
                });
              },
            )
          ],
        ),
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 1.0, 
        child: const Drawer(child: DrawerMenu())),
    );
  }
}
