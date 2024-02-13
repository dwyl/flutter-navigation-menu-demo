import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_localization.dart';
import 'menu.dart';

const iconKey = Key("menu_icon");
const todoItemKey = Key("todo_item");
const homePageKey = Key("home_page");
const ptButtonkey = Key("pt_button");
const enButtonkey = Key("en_button");

// coverage:ignore-start
void main() {
  runApp(const ProviderScope(child: App()));
}
// coverage:ignore-end

/// Provider that tracks the current locale of the app
final currentLocaleProvider = StateProvider<Locale>((_) => const Locale('en', 'US'));

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);

    return MaterialApp(
        title: 'Navigation Flutter Menu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        locale: currentLocale,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'PT'),
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode && locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          // coverage:ignore-start
          return supportedLocales.first;
          // coverage:ignore-end
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalization.delegate
        ],
        home: const HomePage());
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
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
            Image.asset("assets/images/syslogopayoff.png", fit: BoxFit.fitHeight, height: 30),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/syslogopayoff.png"),
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
            Text(
              AppLocalization.of(context).getTranslatedValue("title").toString(),
              style: const TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalization.of(context).getTranslatedValue("description").toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      key: ptButtonkey,
                      onPressed: () {
                        ref.read(currentLocaleProvider.notifier).state = const Locale('pt', 'PT');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 161, 30, 30)),
                      child: const Text("PT")),
                  ElevatedButton(
                      key: enButtonkey,
                      onPressed: () {
                        ref.read(currentLocaleProvider.notifier).state = const Locale('en', 'US');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 18, 50, 110)),
                      child: const Text("EN")),
                ],
              ),
            )
          ],
        ),
      ),
      endDrawer: SizedBox(width: MediaQuery.of(context).size.width * 1.0, child: const Drawer(child: DrawerMenu())),
    );
  }
}
