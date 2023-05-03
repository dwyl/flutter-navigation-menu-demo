import 'package:app/tiles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Menu item info model', () {
    var item = MenuItemInfo(id: 0, title: 'title', tiles: []);

    expect(item.title, equals('title'));
  });

}
