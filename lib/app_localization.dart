import 'dart:convert';

import 'package:app/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utils class for app localization with delegate
class AppLocalization {
  late final Locale _locale;

  AppLocalization(this._locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizedValues;

  // This function will load requested language `.json` file and will assign it to the `_localizedValues` map
  Future loadLanguage() async {
    String jsonStringValues = await rootBundle.loadString("assets/i18n/${_locale.languageCode}.json");

    Map<String, dynamic> mappedValues = json.decode(jsonStringValues);

    _localizedValues = mappedValues.map((key, value) =>
        MapEntry(key, value.toString())); // converting `dynamic` value to `String`, because `_localizedValues` is of type Map<String,String>
  }

  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationDelegate();
}

/// Private overriden delegate class
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  // It will check if the user's locale is supported by our App or not
  @override
  bool isSupported(Locale locale) {
    return ["en", "pt"].contains(locale.languageCode);
  }

  // It will load the equivalent json file requested by the user
  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
