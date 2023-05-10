import 'package:app/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Menu item info model', () {
    final title = {"en": "title", "pt": "título"};
    var item = MenuItemInfo(id: 0, title: title, tiles: []);

    expect(item.title['en'], equals('title'));
  });

    test('Menu item info icon model', () {
    var item = MenuItemInfoIcon(code: 61668, emoji: '🧑‍🤝‍🧑', url: 'someurl.com', colour: '#Ffb97e');

    expect(item.code, equals(61668));
    expect(item.emoji, equals('🧑‍🤝‍🧑'));
    expect(item.url, equals('someurl.com'));
    expect(item.colour, equals('#Ffb97e'));
  });
}
