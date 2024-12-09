import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  // Store the current locale
  static final List<String> supportedLanguages = [
    "en",
    "fr",
    "ar"
  ]; // Supported languages
  static const Locale fallbackLocale = Locale('en', 'US');
  static Locale defaultLocale = fallbackLocale;

  static final Map<String, Map<String, String>> _localizedStrings = {};

  static Locale createLocale(String language) {
    return language.contains('_')
        ? Locale.fromSubtags(
            languageCode: language.split('_').first,
            scriptCode: language.split('_').last,
          )
        : Locale(language);
  }

  List<Locale> getSupportedLocales() {
    return supportedLanguages
        .map((language) => createLocale(language))
        .toList();
  }

  static Future<void> loadTranslations() async {
    // Load the JSON files
    for (var locale in supportedLanguages) {
      String jsonString =
          await rootBundle.loadString('assets/translations/$locale.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings[locale] =
          jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
    defaultLocale = await getLocale();
  }

  @override
  Map<String, Map<String, String>> get keys => _localizedStrings;

  // Function to change the locale
  static void updateLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale); // Save the locale
    Get.updateLocale(Locale(locale));
  }

  static Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('locale');
    return createLocale(savedLocale ?? fallbackLocale.languageCode);
  }
}
