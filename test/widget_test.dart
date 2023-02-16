// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/menu.dart';
import 'package:app/pages.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
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
}
