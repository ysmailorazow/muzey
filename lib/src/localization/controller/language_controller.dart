import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localization_service.dart';

class LanguageController extends GetxController {
  final Rx<Locale> selectedLocale = const Locale('ru').obs;
  LocalizationService localizationService = LocalizationService();
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    selectedLocale.value = localizationService.getLocale();
    currentIndex.value =
        LocalizationService.availableLocales.indexOf(selectedLocale.value);
    super.onInit();
  }

  void updateLanguage(String lang) {
    localizationService.changeLocale(lang);
    selectedLocale.value = localizationService.getLocale();
    currentIndex.value =
        LocalizationService.availableLocales.indexOf(selectedLocale.value);
  }
}
