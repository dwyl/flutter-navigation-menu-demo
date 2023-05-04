import 'package:app/menu.dart';
import 'package:app/pages.dart';
import 'package:app/tiles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const jsonFilePath = 'assets/menu_items.json';
  const storageKey = 'menuItems';

  group('Open menu and simple navigation', () {
    testWidgets('Normal setup', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that our counter starts at 0.
      expect(find.text('This is the main page'), findsOneWidget);
    });

    testWidgets('Tapping on todo item should make menu button appear', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);

      // Icon button should be visible
      expect(menuButton.hitTestable(), findsNothing);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Verify that our menu button is showing
      expect(menuButton.hitTestable(), findsOneWidget);
    });

    testWidgets('Tapping on icon menu should show drawer menu', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);
      final drawerMenu = find.byKey(drawerMenuKey);

      // Icon button should be visible
      expect(menuButton.hitTestable(), findsNothing);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Verify that our menu button is showing
      expect(menuButton.hitTestable(), findsOneWidget);
      expect(drawerMenu.hitTestable(), findsNothing);

      // Tap on icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify that our drawer is showing
      expect(drawerMenu.hitTestable(), findsOneWidget);

      // Tap on icon again to close drawer
      await tester.tap(find.byKey(closeMenuKey));
      await tester.pumpAndSettle();
      expect(find.byKey(homePageKey), findsOneWidget);
    });

    testWidgets('Navigating into Tours Page', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);
      final drawerMenu = find.byKey(drawerMenuKey);
      final tourPageTile = find.byKey(tourTileKey);

      // Icon button should be visible
      expect(menuButton.hitTestable(), findsNothing);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Verify that our menu button is showing
      expect(menuButton.hitTestable(), findsOneWidget);
      expect(drawerMenu.hitTestable(), findsNothing);

      // Tap on icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify that our drawer is showing
      expect(drawerMenu.hitTestable(), findsOneWidget);

      // Tap on tours page tile and check if TourPage is shown
      await tester.tap(tourPageTile);
      await tester.pumpAndSettle();
      expect(find.byKey(tourPageKey).hitTestable(), findsOneWidget);

      // Tap on button to go back
      await tester.tap(find.text("Go back"));
      await tester.pumpAndSettle();
      expect(find.byKey(tourPageKey).hitTestable(), findsNothing);
    });

    testWidgets('Navigating into Settings Page', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);
      final drawerMenu = find.byKey(drawerMenuKey);
      final settingsPageTile = find.byKey(settingsTileKey);

      // Icon button should be visible
      expect(menuButton.hitTestable(), findsNothing);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Verify that our menu button is showing
      expect(menuButton.hitTestable(), findsOneWidget);
      expect(drawerMenu.hitTestable(), findsNothing);

      // Tap on icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify that our drawer is showing
      expect(drawerMenu.hitTestable(), findsOneWidget);

      // Tap on tours page tile and check if TourPage is shown
      await tester.tap(settingsPageTile);
      await tester.pumpAndSettle();
      expect(find.byKey(settingsPageKey).hitTestable(), findsOneWidget);

      // Tap on button to go back
      await tester.tap(find.text("Go back"));
      await tester.pumpAndSettle();
      expect(find.byKey(settingsPageKey).hitTestable(), findsNothing);
    });
  });

  group('Dynamic menu', () {
    const itemHeight = 50.0;

    /// Util function to simulate long press and drag
    Future<void> longPressDrag(WidgetTester tester, Offset start, Offset end) async {
      const Duration longPressTimeout = Duration(milliseconds: 2000);

      final TestGesture drag = await tester.startGesture(start, pointer: 2000);
      await tester.pump(longPressTimeout);
      await drag.moveTo(end);
      await tester.pumpAndSettle();
      await drag.up();
    }

    /// Function to set mock shared preferences in unit tests
    setUp(() async {
      final String jsonString = await rootBundle.loadString(jsonFilePath);
      final Map<String, Object> values = <String, Object>{storageKey: jsonString};
      SharedPreferences.setMockInitialValues(values);
    });

    testWidgets('Normal setup with shared preferences should show dynamic menu', (WidgetTester tester) async {
      // Initialize app
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);
      final drawerMenu = find.byKey(drawerMenuKey);
      final dynamicMenuItemList = find.byKey(dynamicMenuItemListKey);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Verify that our drawer is showing
      expect(drawerMenu.hitTestable(), findsOneWidget);
      expect(dynamicMenuItemList, findsOneWidget);
    });

    testWidgets('Click on first expandable menu item', (WidgetTester tester) async {
      // Initialize app
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // First menu and submenu item from `.json` file
      final peopleMenuItem = find.text("People");
      var everyoneMenuItem =
          find.text("Everyone"); // https://stackoverflow.com/questions/54651878/how-to-find-off-screen-listview-child-in-widget-tests

      expect(peopleMenuItem, findsOneWidget);
      expect(everyoneMenuItem, findsNothing);

      // Tap on "people" menu item
      await tester.tap(peopleMenuItem);
      await tester.pumpAndSettle();

      everyoneMenuItem = find.text("Everyone", skipOffstage: false);

      // "everyone" menu item should be shown
      expect(peopleMenuItem, findsOneWidget);
      expect(everyoneMenuItem, findsOneWidget);
    });

    testWidgets('Drag and drop nested elements', (WidgetTester tester) async {
      // Initialize app
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // First menu and submenu item from `.json` file
      final peopleMenuItem = find.text("People");

      // Tap on "people" menu item
      await tester.tap(peopleMenuItem);
      await tester.pumpAndSettle();

      final onlineMenuItem = find.text("Online Now", skipOffstage: false);
      final everyoneMenuItem = find.text("Everyone", skipOffstage: false);

      // Get list of menu items
      var menuItemTitles = find.byType(MenuItem).evaluate().toList().map(
        (e) {
          var menuItem = e.widget as MenuItem;
          return menuItem.info.title;
        },
      ).toList();

      expect(menuItemTitles, orderedEquals(["People", "Online Now", "Everyone", "Potaro"]));

      // Switching "Online Now" and "Everyone"
      await longPressDrag(
        tester,
        tester.getCenter(onlineMenuItem),
        tester.getCenter(everyoneMenuItem) + const Offset(0.0, itemHeight * 2),
      );
      await tester.pumpAndSettle();

      // Check if switching by drag and drop worked
      menuItemTitles = find.byType(MenuItem).evaluate().toList().map(
        (e) {
          var menuItem = e.widget as MenuItem;
          return menuItem.info.title;
        },
      ).toList();

      expect(menuItemTitles, orderedEquals(["People", "Everyone", "Online Now", "Potaro"]));
    });

    testWidgets('Drag and drop nested elements on third level', (WidgetTester tester) async {
      // Initialize app
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // First menu and submenu item from `.json` file
      final peopleMenuItem = find.text("People");

      // Tap on "people" menu item
      await tester.tap(peopleMenuItem);
      await tester.pumpAndSettle();

      final onlineMenuItem = find.text("Online Now", skipOffstage: false);

      // Tap on "Online Now" menu item
      await tester.tap(onlineMenuItem);
      await tester.pumpAndSettle();

      final friendsMenuItem = find.text("Friends", skipOffstage: false);
      final workMenuItem = find.text("Work", skipOffstage: false);

      // Switching "Online Now" and "Everyone"
      await longPressDrag(
        tester,
        tester.getCenter(friendsMenuItem),
        tester.getCenter(workMenuItem) + const Offset(0.0, itemHeight * 2),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('Drag and drop root elements', (WidgetTester tester) async {
      // Initialize app
      await tester.pumpWidget(const App());

      final menuButton = find.byKey(iconKey);
      final todoItem = find.byKey(todoItemKey);

      // Tap on todo item
      await tester.tap(todoItem);
      await tester.pumpAndSettle();

      // Tap menu icon
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // First menu and submenu item from `.json` file
      final peopleMenuItem = find.text("People");
      final potaroMenuItem = find.text("Potaro", skipOffstage: false);

      // Get list of menu items
      var menuItemTitles = find.byType(MenuItem).evaluate().toList().map(
        (e) {
          var menuItem = e.widget as MenuItem;
          return menuItem.info.title;
        },
      ).toList();

      expect(menuItemTitles, orderedEquals(["People", "Potaro"]));

      // Switch "People" and "Potaro" root menu items
      await longPressDrag(
        tester,
        tester.getCenter(peopleMenuItem),
        tester.getCenter(potaroMenuItem) + const Offset(0.0, itemHeight * 2),
      );
      await tester.pumpAndSettle();

      // Check if switching by drag and drop worked
      menuItemTitles = find.byType(MenuItem).evaluate().toList().map(
        (e) {
          var menuItem = e.widget as MenuItem;
          return menuItem.info.title;
        },
      ).toList();

      expect(menuItemTitles, orderedEquals(["Potaro", "People"]));
    });
  });
}
