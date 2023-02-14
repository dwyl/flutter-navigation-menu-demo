import 'package:app/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'sliding_menu.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Flutter Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// https://docs.flutter.dev/development/ui/animations/tutorial#animationcontroller
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _menuSlideController;

  @override
  void initState() {
    super.initState();

    _menuSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _menuSlideController.dispose();
    super.dispose();
  }

  bool _isMenuOpen() {
    return _menuSlideController.value == 1.0;
  }

  bool _isMenuOpening() {
    return _menuSlideController.status == AnimationStatus.forward;
  }

  bool _isMenuClosed() {
    return _menuSlideController.value == 0.0;
  }

  void _toggleMenu() {
    if (_isMenuOpen() || _isMenuOpening()) {
      _menuSlideController.reverse();
    } else {
      _menuSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'some menu',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        //automaticallyImplyLeading: false,
        /*
        actions: [
          AnimatedBuilder(
            animation: _menuSlideController,
            builder: (context, child) {
              return IconButton(
                onPressed: _toggleMenu,
                icon: _isMenuOpen() || _isMenuOpening()
                    ? const Icon(
                        Icons.menu_open,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
              );
            },
          ),
        ],
        */
      ),
      body: Stack(
        children: [
          const SizedBox(),
          AnimatedBuilder(
            animation: _menuSlideController,
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(1.0 - _menuSlideController.value, 0.0),
                child: _isMenuClosed() ? const SizedBox() : const SlidingMenu(),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(),
    );
  }
}
