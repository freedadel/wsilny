import 'dart:convert';
import 'dart:ui';

import 'package:wassilni/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';

import '../utils/language.dart';

class SettingsRepo{
  final ApiClient apiClient;
final SharedPreferences sharedPreferences;
  SettingsRepo({required this.apiClient,required this.sharedPreferences});

  Future<void> setLanguage(String language) async {
    try{
      if(language == "العربية"){
        await sharedPreferences.setString(AppConstants.LANGUAGE__LANGUAGE_CODE_KEY, "ar");
        await sharedPreferences.setString(AppConstants.LANGUAGE__COUNTRY_CODE_KEY, "DZ");
        await sharedPreferences.setString(AppConstants.LANGUAGE__LANGUAGE_NAME_KEY, "Arabic");
        await sharedPreferences.setString('locale',
            Locale("ar", "DZ").toString());
      }else{
        await sharedPreferences.setString(AppConstants.LANGUAGE__LANGUAGE_CODE_KEY, "en");
        await sharedPreferences.setString(AppConstants.LANGUAGE__COUNTRY_CODE_KEY, "US");
        await sharedPreferences.setString(AppConstants.LANGUAGE__LANGUAGE_NAME_KEY, "English");
        await sharedPreferences.setString('locale',
            Locale("en", "US").toString());
      }
    }catch(e){
      throw e;
    }
  }

  Language getLanguage() {
    final String languageCode = sharedPreferences
        .getString(AppConstants.LANGUAGE__LANGUAGE_CODE_KEY) ??
        AppConstants.defaultLanguage.languageCode;
    final String countryCode = sharedPreferences
        .getString(AppConstants.LANGUAGE__COUNTRY_CODE_KEY) ??
        AppConstants.defaultLanguage.countryCode;
    final String languageName = sharedPreferences
        .getString(AppConstants.LANGUAGE__LANGUAGE_NAME_KEY) ??
        AppConstants.defaultLanguage.name;

    return Language(
        languageCode: languageCode,
        countryCode: countryCode,
        name: languageName);
  }
}