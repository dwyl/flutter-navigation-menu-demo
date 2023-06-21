import 'package:app/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Load menu items with `SharedPreferences` not initialized.', () async {
    // Initializing widget bindings and shared preferences in tests
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    // List items that are fetched from file when Shared Preferences isn't initialized with menu items
    final listItems = await loadMenuItems();

    expect(listItems.length, equals(2));
  });

  test('Updating deeply nested item', () async {
    // Initializing widget bindings and shared preferences in tests
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    // List items that are fetched from file when Shared Preferences isn't initialized with menu items
    final listItems = await loadMenuItems();
    final updatedFriendsMenuItem = listItems.elementAt(0).tiles.elementAt(0).tiles.elementAt(1);

    // Updates nested item inside shared preferences
    updateDeeplyNestedObjectInPreferences(updatedFriendsMenuItem, []);

    expect(listItems.length, equals(2));
  });
}
