import 'package:app/settings.dart';
import 'package:flutter/material.dart';

import 'app_localization.dart';

const tourPageKey = Key("tour_page");
const settingsPageKey = Key("settings_page");
const dynamicMenuPageKey = Key("dynamic_menu_page");

class TourPage extends StatelessWidget {
  const TourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: tourPageKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).getTranslatedValue("feature_page.title").toString(),
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalization.of(context).getTranslatedValue("feature_page.description").toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalization.of(context).getTranslatedValue("goBack_button").toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: settingsPageKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalization.of(context).getTranslatedValue("settings_page.title").toString(),
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalization.of(context).getTranslatedValue("settings_page.description").toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalization.of(context).getTranslatedValue("goBack_button").toString()),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicMenuPage extends StatelessWidget {
  final MenuItemInfo menuItem;

  const DynamicMenuPage({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: dynamicMenuPageKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              menuItem.title,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:  Text(AppLocalization.of(context).getTranslatedValue("goBack_button").toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
