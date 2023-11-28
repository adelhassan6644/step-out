import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../model/language_model.dart';
import '../repo/localization_repo.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final LocalizationRepo repo;

  LocalizationProvider({required this.sharedPreferences, required this.repo}) {
    _loadCurrentLanguage();
    initializeAllLanguages();
  }

  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;
  void initializeAllLanguages() {
    if (_languages.isEmpty) {
      _languages = AppStorageKey.languages;
      notifyListeners();
    }
  }

  Locale _locale = const Locale('ar', 'SA');
  bool _isLtr = false;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    repo.updateLanguage(_locale.languageCode);
    _saveLanguage(_locale);

    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppStorageKey.languageCode) ?? 'ar',
        sharedPreferences.getString(AppStorageKey.countryCode) ?? 'SA');
    _isLtr = _locale.languageCode == 'en';
    if (_locale.languageCode == 'en') {
      _selectIndex = 0;
    } else {
      _selectIndex = 1;
    }
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppStorageKey.languageCode, locale.languageCode);
    sharedPreferences.setString(AppStorageKey.countryCode, locale.countryCode!);
  }
}
