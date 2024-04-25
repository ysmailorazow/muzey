import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get_storage/get_storage.dart';

import 'lang/ru.dart';
import 'lang/tm.dart';
import 'supported_localizations.dart';

class LocalizationService extends Translations {
  static const Locale defaultLocale = Locale('ru', 'RU');

  static const Locale fallbackLocale = Locale('tm', 'TM');

  static final List<String> langs = ['Русский',  'Türkmen'];

  static const String _selectedLocaleStringKey = 'selected_locale_key';

  final GetStorage _box = GetStorage();

  static final List<Locale> availableLocales = [
    const Locale('ru', 'RU'),
    const Locale('tm', 'TM')
  ];

  static Iterable<LocalizationsDelegate> localizationsDelegate() {
    return [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ];
  }

  Locale getLocale() {
    String? selectedLocale = _box.read<String>(_selectedLocaleStringKey);
    return _getLocaleFromLanguage(selectedLocale);
  }

  String getLangCode() {
    Locale locale = getLocale();
    return '${locale.languageCode}_${locale.countryCode}';
  }

  void changeLocale(String lang) {
    final Locale locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
    _box.write(_selectedLocaleStringKey, lang);
  }

  @override
  Map<String, Map<String, String>> get keys =>
      {russian: ruRu, turkmen: tmTm};

  Locale _getLocaleFromLanguage(String? lang) {
    for (int pos = 0; pos < availableLocales.length; pos++) {
      if (lang == langs[pos]) return availableLocales[pos];
    }
    return Get.locale ?? defaultLocale;
  }
}
